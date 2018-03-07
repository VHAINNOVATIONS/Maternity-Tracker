// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System.Web.Mvc;
using VA.Gov.Artemis.Commands.Dsio.Checklist;
using VA.Gov.Artemis.UI.Data.Brokers.Checklist;
using VA.Gov.Artemis.UI.Data.Brokers.Observations;
using VA.Gov.Artemis.UI.Data.Brokers.Pregnancy;
using VA.Gov.Artemis.UI.Data.Models.Checklist;
using VA.Gov.Artemis.UI.Data.Models.Patient;
using VA.Gov.Artemis.UI.Data.Models.Pregnancy;
using VA.Gov.Artemis.UI.Filters;

namespace VA.Gov.Artemis.UI.Controllers
{
    [DisableLocalCache]
    [VerifySession]
    [Authorize]
    public class PatientController : DashboardController
    {
        [HttpGet]
        public ActionResult Summary(string dfn)
        {
            // *** Create new model ***
            PatientSummary model = new PatientSummary();
            string errorMessage = "";
            string attentionMessage = "";

            // *** Get patient demographics ***
            model.Patient = this.CurrentPatient;

            // *** Check for success ***
            if (!model.Patient.NotFound)
            {
                IObservationsRepository observations = this.DashboardRepository.Observations;
                PregnancyResult updatedPregResult = this.DashboardRepository.Pregnancy.UpdateCurrentPregnancyLactationWithCPRSData(dfn, observations, model.Patient);
                if (!updatedPregResult.Success)
                {
                    errorMessage = errorMessage + updatedPregResult.Message;
                    this.Error(errorMessage);
                }
                else
                {
                    attentionMessage = attentionMessage + updatedPregResult.Message;
                    if (!string.IsNullOrWhiteSpace(attentionMessage))
                    {
                        this.Attention(attentionMessage);
                    }
                }

                PregnancyResult pregResult = this.DashboardRepository.Pregnancy.GetCurrentOrMostRecentPregnancy(dfn);
                if (pregResult.Success)
                {
                    if (pregResult.Pregnancy != null)
                    {
                        if (pregResult.Pregnancy.RecordType == PregnancyRecordType.Current)
                        {
                            model.Patient.Pregnant = true;
                        }
                        else
                        {
                            model.Patient.Pregnant = false;
                        }
                        if (pregResult.Pregnancy.RecordType == PregnancyRecordType.Current)
                        {
                            model.CurrentPregnancy = pregResult.Pregnancy;

                            PregnancyDetails tempDetails = PregnancyUtilities.GetPregnancyObservationData(this.DashboardRepository, dfn, model.CurrentPregnancy.Ien);

                            model.CurrentPregnancy.Lmp = tempDetails.Lmp;
                            model.CurrentPregnancy.FetusBabyCount = tempDetails.FetusBabyCount;
                            model.CurrentPregnancy.EddBasis = tempDetails.EddBasis;
                            model.CurrentPregnancy.EddIsFinal = tempDetails.EddIsFinal;
                        }
                        else
                        {
                            // TODO: Show most recent pregnancy ?
                        }

                        // *** Get pregnancy checklist ***
                        UpdateChecklistSummary(model, dfn, pregResult);
                    }
                }
                else
                {
                    errorMessage = errorMessage + pregResult.Message;
                    this.Error(errorMessage);
                }

                // *** Get Pregnancy History ***
                PregnancyHistoryResult histResult = this.DashboardRepository.Pregnancy.GetPregnancyHistory(dfn);

                if (histResult.Success)
                {
                    model.PregnancyHistory = histResult.PregnancyHistory;
                }
                else
                {
                    model.PregnancyHistory = new PregnancyHistory();
                    errorMessage = errorMessage + histResult.Message;
                    this.Error(errorMessage);
                }
            }

            // *** Set return url ***
            if (TempData.ContainsKey(LastPatientListUrl))
            {
                model.ReturnUrl = TempData[LastPatientListUrl].ToString();

                TempData.Keep(LastPatientListUrl);

                // *** Indicate how to get back here ***
                TempData[ReturnUrl] = Url.Action("Summary", "Patient", new { dfn = dfn });
            }

            return View("Summary2", model);
        }

        //[HttpGet]
        //public ActionResult Timeline(string patientId)
        //{
        //    TrackedPatient model = this.DashboardRepository.Patients.Get("1234");

        //    return View(model);

        //}

        private void UpdateChecklistSummary(PatientSummary model, string dfn, PregnancyResult pregResult)
        {
            const int itemCount = 4;

            PregnancyChecklistItemsResult checklistResult = this.DashboardRepository.Checklist.GetPregnancyItems(dfn, pregResult.Pregnancy.Ien, "", DsioChecklistCompletionStatus.NotComplete);

            if (checklistResult.Success)
            {
                if (checklistResult.Items != null)
                {
                    PregnancyChecklistItemList tempList = new PregnancyChecklistItemList();

                    tempList.AddRange(checklistResult.Items);

                    tempList.AddPregnancyDates(pregResult.Pregnancy.EDD, pregResult.Pregnancy.EndDate);

                    tempList.Sort(delegate (PregnancyChecklistItem x, PregnancyChecklistItem y)
                    {
                        return x.DueDate.CompareTo(y.DueDate);
                    });

                    int tempCount = 0;
                    foreach (PregnancyChecklistItem tempItem in tempList)
                    {
                        if (model.PregnancyChecklistItems == null)
                            model.PregnancyChecklistItems = new PregnancyChecklistItemList();

                        model.PregnancyChecklistItems.Add(tempItem);

                        tempCount += 1;

                        if (tempCount == itemCount)
                            break;
                    }

                    if (tempList.Count > itemCount)
                        model.MoreChecklistItems = string.Format("{0} more", tempList.Count - itemCount);

                    model.ChecklistLink = Url.Action("PregnancyIndex", "Checklist", new { dfn = model.Patient.Dfn, pregIen = pregResult.Pregnancy.Ien, page = "1" });
                }

            }

        }
    }

}
