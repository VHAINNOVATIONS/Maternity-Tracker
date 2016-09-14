using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using System.Web.Mvc;
using System.Xml;
using System.Xml.Serialization;
using VA.Gov.Artemis.Core;
using VA.Gov.Artemis.UI.Data.Brokers.Common;
using VA.Gov.Artemis.UI.Data.Brokers.Pregnancy;
using VA.Gov.Artemis.UI.Data.Models.Pregnancy;
using VA.Gov.Artemis.UI.Data.Models.Text4Baby;
using VA.Gov.Artemis.UI.Filters;
using VA.Gov.Artemis.UI.Text4BabyServiceReference;

namespace VA.Gov.Artemis.UI.Controllers
{
    [VerifySession]
    [DisableLocalCache]
    [Authorize]
    public class Text4BabyController : DashboardController
    {
        [HttpGet]
        public ActionResult Index(string dfn)
        {
            Text4BabyModel model = new Text4BabyModel();
            model.Patient = this.CurrentPatient; 
            
            return View(model);
        }

        [HttpGet]
        public ActionResult Enroll(string dfn)
        {
            Text4BabyModel model = new Text4BabyModel();

            // *** Set patient ***
            model.Patient = this.CurrentPatient;

            // *** Add values to enrollment ***
            model.Enrollment.FirstName = model.Patient.FirstName;
            model.Enrollment.MenstrualPeriodDate = this.CurrentPatient.Lmp;
            model.Enrollment.MobileNumber = this.CurrentPatient.MobilePhone;
            model.Enrollment.ZipCode = this.CurrentPatient.ZipCode;
            model.Enrollment.EmailAddress = this.CurrentPatient.Email;
            
            // *** Get most recent pregnancy ***
            PregnancyResult pregResult = this.DashboardRepository.Pregnancy.GetCurrentOrMostRecentPregnancy(dfn);

            // *** Check Result ***
            if (pregResult.Success) 
                if (pregResult.Pregnancy != null)
                    if (pregResult.Pregnancy.RecordType == PregnancyRecordType.Current)
                    {
                        // *** If current preg has EDD, add data to enrollment ***
                        if (pregResult.Pregnancy.EDD != DateTime.MinValue)
                        {
                            model.Enrollment.DueDateKnown = true;
                            model.Enrollment.PregnancyDueDate = pregResult.Pregnancy.EDD;
                            model.Enrollment.ParticipantType = Text4BabyParticipantType.Pregnant;
                        }
                    }
                    else
                    {               
                        // *** Get the outcome type ***
                        PregnancyOutcomeType outcomeType = PregnancyUtilities.GetPregnancyOutcome(this.DashboardRepository, dfn, pregResult.Pregnancy.Ien);

                        // *** Display most recent pregnancy outcome ***
                        string outcomeMessage = string.Format("This patient's most recent pregnancy outcome: {0}", PregnancyOutcomeUtility.GetDescription(outcomeType));

                        switch (outcomeType)
                        {
                            case PregnancyOutcomeType.FullTermDelivery:
                            case PregnancyOutcomeType.PretermDelivery:
                            case PregnancyOutcomeType.Unknown:
                                model.Enrollment.ParticipantType = Text4BabyParticipantType.NewMom;
                                model.EnrollmentInfo = outcomeMessage;
                                break;
                            default:
                                model.EnrollmentWarning = outcomeMessage;
                                break; 
                        }

                        if (pregResult.Pregnancy.EndDate != DateTime.MinValue)
                            model.Enrollment.BabyDateOfBirth = pregResult.Pregnancy.EndDate;
                    }


            return View(model);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Enroll(Text4BabyModel model)
        {
            ActionResult returnResult = View(model); 

            bool anyErrors = false; 

            try
            {
                // *** Create the soap client ***
                using (VoxivaSoapClient client = new VoxivaSoapClient())
                {
                    
                    // *** Create an authorization header from app settings data ***
                    WorkflowAuthHeader authHeader = new WorkflowAuthHeader();                    

                    authHeader.UserName = ConfigurationManager.AppSettings["Text4BabyApiUserName"];
                    authHeader.Password = ConfigurationManager.AppSettings["Text4BabyApiPassword"];
                    authHeader.ApplicationId = ConfigurationManager.AppSettings["Text4BabyApiApplicationId"];

                    model.Enrollment.ReferringUrl = ConfigurationManager.AppSettings["Text4BabyApiReferringUrl"];

                    // *** Get xml request ***
                    string dataXml = model.Enrollment.ToRequestXml();

                    // *** Invoke API ! ***
                    string resultXml = client.InvokeAPI(authHeader, dataXml);

                    // *** Create Serializer ***
                    XmlSerializer serializer = new XmlSerializer(typeof(Text4BabyResponse));

                    // *** Create reader ***
                    using (XmlReader xmlReader = XmlReader.Create(new StringReader(resultXml)))
                    {
                        Text4BabyResponse t4bResponse;

                        // *** Deserialize result ***
                        if (serializer.CanDeserialize(xmlReader))
                        {
                            t4bResponse = (Text4BabyResponse)serializer.Deserialize(xmlReader);

                            // *** Determine if there were errors ***
                            if (!string.IsNullOrWhiteSpace(t4bResponse.Error.Text))
                            {
                                this.Error(t4bResponse.Error.Text);
                                anyErrors = true; 
                            }
                            else
                            {
                                this.Information("The patient has been successfully registered with Text4Baby");

                                // *** Save info to VistA ***
                                BrokerOperationResult opResult = this.DashboardRepository.Patients.SaveText4BabyInfo(model.Patient.Dfn, Text4BabyStatus.Enrolled, t4bResponse.Result.ParticipantId);

                                if (!opResult.Success)
                                {
                                    this.Error(opResult.Message);
                                    anyErrors = true;
                                }
                                
                                returnResult = RedirectToAction("Index", "Text4Baby", new { dfn = model.Patient.Dfn });
                            }
                        }
                        else
                        {
                            this.Error("Unknown Response from Text4Baby");
                            ErrorLogger.Log("Text4BabyController.Enroll: Unknown Response from Text4Baby API");
                            ErrorLogger.Log(resultXml);
                        }
                    }
                }
            }
            catch (Exception genericException)
            {
                ErrorLogger.Log(genericException, "Error enrolling patient in Text4Baby");
                this.Error(genericException.Message);
                anyErrors = true; 
            }

            if (anyErrors)
            {
                this.CurrentPatientDfn = model.Patient.Dfn;
                model.Patient = this.CurrentPatient;
                returnResult = View(model);
            }

            return returnResult; 
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult NotInterested(Text4BabyModel model)
        {
            // *** Save NotInterested as t4b status ***

            ActionResult returnResult;

            this.CurrentPatientDfn = model.Patient.Dfn;

            BrokerOperationResult opResult = this.DashboardRepository.Patients.SaveText4BabyInfo(model.Patient.Dfn, Text4BabyStatus.NotInterested);

            if (!opResult.Success)
                this.Error(opResult.Message);
            else
                this.Information("Text4Baby Status updated");
            
            returnResult = RedirectToAction("Index", "Text4Baby", new { dfn = model.Patient.Dfn });

            return returnResult;
        }
    }
}
