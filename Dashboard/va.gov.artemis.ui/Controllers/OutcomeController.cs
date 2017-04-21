// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using VA.Gov.Artemis.Commands.Dsio.Observation;
using VA.Gov.Artemis.UI.Data.Brokers.Common;
using VA.Gov.Artemis.UI.Data.Brokers.Observations;
using VA.Gov.Artemis.UI.Data.Brokers.Pregnancy;
using VA.Gov.Artemis.UI.Data.Models.Observations;
using VA.Gov.Artemis.UI.Data.Models.Outcomes;
using VA.Gov.Artemis.UI.Data.Models.Pregnancy;
using VA.Gov.Artemis.UI.Filters;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.UI.Controllers
{
    [Authorize]
    [DisableLocalCache]
    [VerifySession]
    public class OutcomeController : DashboardController
    {
        [HttpGet]
        public ActionResult AddEdit(string dfn, string pregIen)
        {
            // *** Create the model ***
            PatientOutcomeAddEdit model = new PatientOutcomeAddEdit();

            // *** Make sure patient is set ***
            model.Patient = this.CurrentPatient;

            if (!string.IsNullOrWhiteSpace(pregIen))
            {
                // *** Keep pregnancy ien in model ***
                model.PregnancyIen = pregIen;

                // *** Get the outcome type ***
                PregnancyOutcomeType outcomeType = PregnancyUtilities.GetPregnancyOutcome(this.DashboardRepository, dfn, pregIen);

                // *** Get the outcome details ***
                model.OutcomeDetails = PregnancyUtilities.GetOutcomeDetails(this.DashboardRepository, dfn, pregIen, outcomeType);

                // *** Add outcome type to the model ***
                model.OutcomeDetails.OutcomeType = outcomeType;

                // *** Get the pregnancy details ***
                PregnancyDetails pregDetails = PregnancyUtilities.GetPregnancy(this.DashboardRepository, dfn, pregIen);

                // *** Set the outcome date ***
                if (pregDetails != null)
                {
                    model.OutcomeDetails.OutcomeDate = pregDetails.DisplayEndDate;
                    
                    // *** This is needed for GA in delivery details ***
                    model.Edd = pregDetails.EDD;
                }
            }

            return View(model); 
        }

        [HttpPost]
        public ActionResult AddEdit(PatientOutcomeAddEdit model)
        {
            ActionResult returnResult = null;

            // *** Make sure patient is current ***
            this.CurrentPatientDfn = model.Patient.Dfn;
            model.Patient = this.CurrentPatient;

            bool ok = true; 

            // *** Add pregnancy record if it does not exist ***
            if (string.IsNullOrWhiteSpace(model.PregnancyIen))
            {
                PregnancyDetails newDetails = new PregnancyDetails(){ PatientDfn = this.CurrentPatientDfn, RecordType = PregnancyRecordType.Historical};

                IenResult saveResult = this.DashboardRepository.Pregnancy.SavePregnancy(newDetails);

                if (saveResult.Success)
                    model.PregnancyIen = saveResult.Ien;
                else
                    this.Error(saveResult.Message);
            }

            if (!string.IsNullOrWhiteSpace(model.PregnancyIen))
            {
                 string normalizedOutcomeDate = ""; 
                 if (!string.IsNullOrWhiteSpace(model.OutcomeDetails.OutcomeDate))
                    normalizedOutcomeDate = VistaDates.StandardizeDateFormat(model.OutcomeDetails.OutcomeDate);

                // *** Update outcome observation ***
                List<Observation> outcomeList = ObservationsFactory.CreateOutcomeObservations
                    (
                    model.Patient.Dfn, 
                    model.OutcomeDetails.OutcomeType, 
                    normalizedOutcomeDate, 
                    model.PregnancyIen
                    );

                BrokerOperationResult obsResult = this.DashboardRepository.Observations.SaveSingletonObservations(outcomeList);

                if (!obsResult.Success)
                {
                    this.Error(obsResult.Message);
                    ok = false;
                }

                if (ok)
                {
                    if (!string.IsNullOrWhiteSpace(normalizedOutcomeDate))
                    {
                        // *** Update pregnancy end date ***
                        PregnancyDetails preg = PregnancyUtilities.GetPregnancy(this.DashboardRepository, model.Patient.Dfn, model.PregnancyIen);

                        if (preg != null)
                        {
                            // *** Update date ***
                            preg.DisplayEndDate = normalizedOutcomeDate;

                            // *** Save updated pregnancy ***
                            BrokerOperationResult savePregResult = this.DashboardRepository.Pregnancy.SavePregnancy(preg);

                            // *** Check result ***
                            if (!savePregResult.Success)
                            {
                                this.Error(savePregResult.Message);
                                ok = false;
                            }
                        }

                    }
                }

                // *** Get observations from the model ***
                ObservationConstructable details = model.OutcomeDetails.SelectedDetails;

                if (details != null)
                {
                    List<Observation> obsList = details.GetObservations(model.Patient.Dfn, model.PregnancyIen, "");

                    if (obsList != null)
                        if (obsList.Count > 0)
                        {
                            // *** If we have any, save them ***
                            BrokerOperationResult result = this.DashboardRepository.Observations.SaveSingletonObservationsByCategory(obsList);

                            if (!result.Success)
                            {
                                this.Error(result.Message);
                                ok = false;
                            }
                        }
                }
            }

            if (ok)
                returnResult = RedirectToAction("PregnancyView", "Pregnancy", new { dfn = model.Patient.Dfn, pregIen = model.PregnancyIen });
            else
                returnResult = View(model); 

            return returnResult;
        }
        
        //[HttpGet]
        //public ActionResult SpontaneousAbortion(string dfn, string pregIen)
        //{
        //    ActionResult returnResult; 

        //    // *** Create the model ***
        //    PatientSpontaneousAbortionOutcome model = new PatientSpontaneousAbortionOutcome();

        //    // *** Make sure patient is set ***
        //    model.Patient = this.CurrentPatient;

        //    // *** Keep pregnancy ien in model ***
        //    model.PregnancyIen = pregIen; 

        //    // *** Get the proper observations ***
        //    ObservationListResult result = this.DashboardRepository.Observations.GetObservationListByCategory(dfn, pregIen, model.Details.ObservationCategory);

        //    if (!result.Success)
        //    {
        //        // *** If not successful, report and return to add/edit ***
        //        this.Error(result.Message);
                
        //        returnResult = RedirectToAction("AddEdit", "Pregnancy", new { dfn = dfn, pregIen = pregIen });
        //    }
        //    else 
        //    {
        //        // *** Create new model details if we have observations ***
        //        if (result.Observations != null)
        //            if (result.Observations.Count > 0)
        //                model.Details = new SpontaneousAbortionOutcome(result.Observations);
            
        //        returnResult = View(model);
        //    }
            
        //    return returnResult; 
        //}

        //[HttpPost]
        //public ActionResult SpontaneousAbortion(PatientSpontaneousAbortionOutcome model)
        //{
        //    ActionResult returnResult = null; 

        //    // *** Make sure patient is current ***
        //    this.CurrentPatientDfn = model.Patient.Dfn;
        //    model.Patient = this.CurrentPatient; 

        //    // *** Get observations from the model ***
        //    List<DsioObservation> obsList = model.Details.GetObservations(model.Patient.Dfn, model.PregnancyIen, "");

        //    if (obsList != null)
        //        if (obsList.Count > 0)
        //        {
        //            // *** If we have any, save them ***
        //            BrokerOperationResult result = this.DashboardRepository.Observations.SaveSingletonObservationsByCategory(obsList);

        //            if (!result.Success)
        //            {
        //                this.Error(result.Message);
        //                returnResult = View(model);
        //            }
                        
        //        }

        //    // *** If still null, then redirect back ***
        //    if (returnResult == null) 
        //        returnResult = RedirectToAction("AddEdit", "Pregnancy", new { dfn = model.Patient.Dfn, pregIen = model.PregnancyIen });

        //    return returnResult; 
        //}

        //[HttpGet]
        //public ActionResult PregnancyTermination(string dfn, string pregIen)
        //{
        //    ActionResult returnResult;

        //    // *** Create the model ***
        //    PatientPregnancyTerminationOutcome model = new PatientPregnancyTerminationOutcome();

        //    // *** Make sure patient is set ***
        //    model.Patient = this.CurrentPatient;

        //    // *** Keep pregnancy ien in model ***
        //    model.PregnancyIen = pregIen; 

        //    // *** Get the proper observations ***
        //    ObservationListResult result = this.DashboardRepository.Observations.GetObservationListByCategory(dfn, pregIen, model.Details.ObservationCategory);

        //    if (!result.Success)
        //    {
        //        // *** If not successful, report and return to add/edit ***
        //        this.Error(result.Message);

        //        returnResult = RedirectToAction("AddEdit", "Pregnancy", new { dfn = dfn, pregIen = pregIen });
        //    }
        //    else
        //    {
        //        // *** Create new model details if we have observations ***
        //        if (result.Observations != null)
        //            if (result.Observations.Count > 0)
        //                model.Details = new PregnancyTerminationOutcome(result.Observations);

        //        returnResult = View(model);
        //    }

        //    return returnResult;
        //}

        //[HttpPost]
        //public ActionResult PregnancyTermination(PatientPregnancyTerminationOutcome model)
        //{
        //    ActionResult returnResult = null;

        //    // *** Make sure patient is current ***
        //    this.CurrentPatientDfn = model.Patient.Dfn;
        //    model.Patient = this.CurrentPatient;

        //    // *** Get observations from the model ***
        //    List<DsioObservation> obsList = model.Details.GetObservations(model.Patient.Dfn, model.PregnancyIen, "");

        //    if (obsList != null)
        //        if (obsList.Count > 0)
        //        {
        //            // *** If we have any, save them ***
        //            BrokerOperationResult result = this.DashboardRepository.Observations.SaveSingletonObservationsByCategory(obsList);

        //            if (!result.Success)
        //            {
        //                this.Error(result.Message);
        //                returnResult = View(model);
        //            }

        //        }

        //    // *** If still null, then redirect back ***
        //    if (returnResult == null)
        //        returnResult = RedirectToAction("AddEdit", "Pregnancy", new { dfn = model.Patient.Dfn, pregIen = model.PregnancyIen });

        //    return returnResult;
        //}

        //[HttpGet]
        //public ActionResult StillbirthOutcome(string dfn, string pregIen)
        //{
        //    ActionResult returnResult;

        //    // *** Create the model ***
        //    PatientStillbirthOutcome model = new PatientStillbirthOutcome();

        //    // *** Make sure patient is set ***
        //    model.Patient = this.CurrentPatient;

        //    // *** Keep pregnancy ien in model ***
        //    model.PregnancyIen = pregIen; 

        //    // *** Get the proper observations ***
        //    ObservationListResult result = this.DashboardRepository.Observations.GetObservationListByCategory(dfn, pregIen, model.Details.ObservationCategory);

        //    if (!result.Success)
        //    {
        //        // *** If not successful, report and return to add/edit ***
        //        this.Error(result.Message);

        //        returnResult = RedirectToAction("AddEdit", "Pregnancy", new { dfn = dfn, pregIen = pregIen });
        //    }
        //    else
        //    {
        //        // *** Create new model details if we have observations ***
        //        if (result.Observations != null)
        //            if (result.Observations.Count > 0)
        //                model.Details = new StillbirthOutcome(result.Observations);

        //        returnResult = View(model);
        //    }

        //    return returnResult;
        //}

        //[HttpPost]
        //public ActionResult StillbirthOutcome(PatientStillbirthOutcome model)
        //{
        //    ActionResult returnResult = null;

        //    // *** Make sure patient is current ***
        //    this.CurrentPatientDfn = model.Patient.Dfn;
        //    model.Patient = this.CurrentPatient;

        //    // *** Get observations from the model ***
        //    List<DsioObservation> obsList = model.Details.GetObservations(model.Patient.Dfn, model.PregnancyIen, "");

        //    if (obsList != null)
        //        if (obsList.Count > 0)
        //        {
        //            // *** If we have any, save them ***
        //            BrokerOperationResult result = this.DashboardRepository.Observations.SaveSingletonObservationsByCategory(obsList);

        //            if (!result.Success)
        //            {
        //                this.Error(result.Message);
        //                returnResult = View(model);
        //            }

        //        }

        //    // *** If still null, then redirect back ***
        //    if (returnResult == null)
        //        returnResult = RedirectToAction("AddEdit", "Pregnancy", new { dfn = model.Patient.Dfn, pregIen = model.PregnancyIen });

        //    return returnResult;
        //}

        //[HttpGet]
        //public ActionResult EctopicOutcome(string dfn, string pregIen)
        //{
        //    ActionResult returnResult;

        //    // *** Create the model ***
        //    PatientEctopicOutcome model = new PatientEctopicOutcome();

        //    // *** Make sure patient is set ***
        //    model.Patient = this.CurrentPatient;

        //    // *** Keep pregnancy ien in model ***
        //    model.PregnancyIen = pregIen; 
            
        //    // *** Get the proper observations ***
        //    ObservationListResult result = this.DashboardRepository.Observations.GetObservationListByCategory(dfn, pregIen, model.Details.ObservationCategory);

        //    if (!result.Success)
        //    {
        //        // *** If not successful, report and return to add/edit ***
        //        this.Error(result.Message);

        //        returnResult = RedirectToAction("AddEdit", "Pregnancy", new { dfn = dfn, pregIen = pregIen });
        //    }
        //    else
        //    {
        //        // *** Create new model details if we have observations ***
        //        if (result.Observations != null)
        //            if (result.Observations.Count > 0)
        //                model.Details = new EctopicOutcome(result.Observations);

        //        returnResult = View(model);
        //    }

        //    return returnResult;
        //}

        //[HttpPost]
        //public ActionResult EctopicOutcome(PatientEctopicOutcome model)
        //{
        //    ActionResult returnResult = null;

        //    // *** Make sure patient is current ***
        //    this.CurrentPatientDfn = model.Patient.Dfn;
        //    model.Patient = this.CurrentPatient;

        //    // *** Get observations from the model ***
        //    List<DsioObservation> obsList = model.Details.GetObservations(model.Patient.Dfn, model.PregnancyIen, "");

        //    if (obsList != null)
        //        if (obsList.Count > 0)
        //        {
        //            // *** If we have any, save them ***
        //            BrokerOperationResult result = this.DashboardRepository.Observations.SaveSingletonObservationsByCategory(obsList);

        //            if (!result.Success)
        //            {
        //                this.Error(result.Message);
        //                returnResult = View(model);
        //            }

        //        }

        //    // *** If still null, then redirect back ***
        //    if (returnResult == null)
        //        returnResult = RedirectToAction("AddEdit", "Pregnancy", new { dfn = model.Patient.Dfn, pregIen = model.PregnancyIen });

        //    return returnResult;
        //}

        //[HttpGet]
        //public ActionResult DeliveryDetails(string dfn, string pregIen)
        //{
        //    ActionResult returnResult;

        //    // *** Create the model ***
        //    PatientDeliveryDetails model = new PatientDeliveryDetails();

        //    // *** Make sure patient is set ***
        //    model.Patient = this.CurrentPatient;

        //    // *** Keep pregnancy ien in model ***
        //    model.PregnancyIen = pregIen; 

        //    // *** Get the proper observations ***
        //    ObservationListResult result = this.DashboardRepository.Observations.GetObservationListByCategory(dfn, pregIen, model.Details.ObservationCategory);

        //    if (!result.Success)
        //    {
        //        // *** If not successful, report and return to add/edit ***
        //        this.Error(result.Message);

        //        returnResult = RedirectToAction("AddEdit", "Pregnancy", new { dfn = dfn, pregIen = pregIen });
        //    }
        //    else
        //    {
        //        // *** Create new model details if we have observations ***
        //        if (result.Observations != null)
        //            if (result.Observations.Count > 0)
        //                model.Details = new DeliveryDetails(result.Observations);

        //        returnResult = View(model);
        //    }

        //    return returnResult;
        //}

        //[HttpPost]
        //public ActionResult DeliveryDetails(PatientDeliveryDetails model)
        //{
        //    ActionResult returnResult = null;

        //    // *** Make sure patient is current ***
        //    this.CurrentPatientDfn = model.Patient.Dfn;
        //    model.Patient = this.CurrentPatient;

        //    // *** Get observations from the model ***
        //    List<DsioObservation> obsList = model.Details.GetObservations(model.Patient.Dfn, model.PregnancyIen, "");

        //    if (obsList != null)
        //        if (obsList.Count > 0)
        //        {
        //            // *** If we have any, save them ***
        //            BrokerOperationResult result = this.DashboardRepository.Observations.SaveSingletonObservationsByCategory(obsList);

        //            if (!result.Success)
        //            {
        //                this.Error(result.Message);
        //                returnResult = View(model);
        //            }

        //        }

        //    // *** If still null, then redirect back ***
        //    if (returnResult == null)
        //        returnResult = RedirectToAction("AddEdit", "Pregnancy", new { dfn = model.Patient.Dfn, pregIen = model.PregnancyIen });

        //    return returnResult;
        //}

        //[HttpGet]
        //public ActionResult BabyDetails(string dfn, string pregIen, string babyIen)
        //{
        //    ActionResult returnResult;

        //    // *** Create the model ***
        //    PatientBabyDetails model = new PatientBabyDetails();

        //    // *** Make sure patient is set ***
        //    model.Patient = this.CurrentPatient;

        //    // *** Get the proper observations ***
        //    ObservationListResult result = this.DashboardRepository.Observations.GetObservationListByCategory(dfn, pregIen, model.Details.ObservationCategory);

        //    // *** Keep pregnancy ien in model ***
        //    model.PregnancyIen = pregIen; 

        //    if (!result.Success)
        //    {
        //        // *** If not successful, report and return to add/edit ***
        //        this.Error(result.Message);

        //        returnResult = RedirectToAction("AddEdit", "Pregnancy", new { dfn = dfn, pregIen = pregIen });
        //    }
        //    else
        //    {
        //        // *** Create new model details if we have observations ***
        //        if (result.Observations != null)
        //            if (result.Observations.Count > 0)
        //                model.Details = new BabyDetails(result.Observations);

        //        returnResult = View(model);
        //    }

        //    return returnResult;
        //}

        //[HttpPost]
        //public ActionResult BabyDetails(PatientBabyDetails model)
        //{
        //    ActionResult returnResult = null;

        //    // *** Make sure patient is current ***
        //    this.CurrentPatientDfn = model.Patient.Dfn;
        //    model.Patient = this.CurrentPatient;

        //    // *** Get observations from the model ***
        //    List<DsioObservation> obsList = model.Details.GetObservations(model.Patient.Dfn, model.PregnancyIen, "");

        //    if (obsList != null)
        //        if (obsList.Count > 0)
        //        {
        //            // *** If we have any, save them ***
        //            BrokerOperationResult result = this.DashboardRepository.Observations.SaveSingletonObservationsByCategory(obsList);

        //            if (!result.Success)
        //            {
        //                this.Error(result.Message);
        //                returnResult = View(model);
        //            }
        //        }

        //    // *** If still null, then redirect back ***
        //    if (returnResult == null)
        //        returnResult = RedirectToAction("AddEdit", "Pregnancy", new { dfn = model.Patient.Dfn, pregIen = model.PregnancyIen });

        //    return returnResult;
        //}

        //private PregnancyDetails GetPregnancyDetails(string patientDfn, string pregIen)
        //{
        //    PregnancyDetails returnVal = null; 

        //    PregnancyListResult result = this.DashboardRepository.Pregnancy.GetPregnancies(patientDfn, pregIen);

        //    if (!result.Success)
        //        this.Error(result.Message);
        //    else
        //    {
        //        if (result.Pregnancies != null)
        //            if (result.Pregnancies.Count > 0)
        //            {
        //                returnVal = result.Pregnancies[0];

        //                ObservationListResult obsResult = this.DashboardRepository.Observations.GetObservations(dfn, pregIen, "", "", "", "Outcome", 0, 0);

        //                if (obsResult.Success)
        //                    if (obsResult.Observations != null)
        //                        foreach (DsioObservation obs in obsResult.Observations)
        //                            if (obs.Code == ObservationsFactory.OutcomeTypeCode)
        //                            {
        //                                PregnancyOutcomeType outType = PregnancyOutcomeType.Unknown;
        //                                if (Enum.TryParse<PregnancyOutcomeType>(obs.Value, true, out outType))
        //                                    model.OutcomeType = outType;
        //                            }
        //            }
        //    }
        //}

        
    }
}
