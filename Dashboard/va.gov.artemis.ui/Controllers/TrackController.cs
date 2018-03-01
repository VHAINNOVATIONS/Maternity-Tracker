// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Web.Mvc;
using VA.Gov.Artemis.UI.Data.Brokers.Common;
using VA.Gov.Artemis.UI.Data.Brokers.Pregnancy;
using VA.Gov.Artemis.UI.Data.Brokers.SelectList;
using VA.Gov.Artemis.UI.Data.Models.Common;
using VA.Gov.Artemis.UI.Data.Models.Pregnancy;
using VA.Gov.Artemis.UI.Data.Models.Track;
using VA.Gov.Artemis.UI.Filters;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.UI.Controllers
{
    [Authorize]
    [VerifySession]
    [DisableLocalCache]
    public class TrackController : DashboardController
    {
        [HttpGet]
        public ActionResult Start(string dfn)
        {
            // *** Show start tracking page ***

            ActionResult returnResult;

            CreateTrackingEntry model = GetNewModel(TrackingEntryType.Start, dfn);

            returnResult = View("~/Views/Track/Create.cshtml", model);

            return returnResult;
        }

        [HttpGet]
        public ActionResult Stop(string dfn)
        {
            // *** Show stop tracking page ***

            ActionResult returnResult;

            CreateTrackingEntry model = GetNewModel(TrackingEntryType.Stop, dfn);

            // model.Pregnancy = PregnancyUtilities.GetPregnancy(this.DashboardRepository, dfn, pregIen);

            PregnancyResult results = this.DashboardRepository.Pregnancy.GetCurrentOrMostRecentPregnancy(dfn);

            if (results.Success)
            {
                if (results.Pregnancy != null)
                {
                    string pregIen = results.Pregnancy.Ien;

                    // *** Get the outcome type ***
                    PregnancyOutcomeType outcomeType = PregnancyUtilities.GetPregnancyOutcome(this.DashboardRepository, dfn, pregIen);

                    model.Outcome = PregnancyUtilities.GetOutcomeDetails(this.DashboardRepository, dfn, pregIen, outcomeType);

                    model.Outcome.OutcomeType = outcomeType;

                    model.Outcome.OutcomeDate = results.Pregnancy.DisplayEndDate;
                }
            }



            returnResult = View("~/Views/Track/Stop.cshtml", model);
            //returnResult = View(model);

            return returnResult;
        }

        [HttpGet]
        public ActionResult Accept(string dfn)
        {
            // *** Show accept tracking page ***

            ActionResult returnResult;

            CreateTrackingEntry model = GetNewModel(TrackingEntryType.Accept, dfn);

            returnResult = View("~/Views/Track/Create.cshtml", model);

            return returnResult;
        }

        [HttpGet]
        public ActionResult Reject(string dfn)
        {
            // *** Show reject tracking page ***

            ActionResult returnResult;

            CreateTrackingEntry model = GetNewModel(TrackingEntryType.Reject, dfn);

            returnResult = View("~/Views/Track/Create.cshtml", model);

            return returnResult;
        }

        [HttpPost]
        public ActionResult Create(CreateTrackingEntry newTrackingEntry)
        {
            // *** Post new tracking entry data ***

            ActionResult returnResult;

            Nullable<bool> success = null;

            try
            {
                // *** Get entry type **
                TrackingEntryType eventType = newTrackingEntry.TrackingEntry.EntryType;

                // *** If start, make sure there's a reason ***
                if (eventType == TrackingEntryType.Start)
                    if (string.IsNullOrWhiteSpace(newTrackingEntry.TrackingEntry.Reason))
                    {
                        success = false;
                        this.Error("Please select a reason");
                    }

                if (eventType == TrackingEntryType.Stop)
                    if (newTrackingEntry.TrackingEntry.Reason == "Other")
                        newTrackingEntry.TrackingEntry.Reason = newTrackingEntry.ReasonDetail;

                // *** Check if a determination's been made yet ***
                if (!success.HasValue)
                {
                    // *** Set values for repository ***
                    string dfn = newTrackingEntry.TrackingEntry.PatientDfn;
                    string reason = newTrackingEntry.TrackingEntry.Reason;
                    string comment = newTrackingEntry.TrackingEntry.Comment;

                    // *** Add tracking history entry ***
                    BrokerOperationResult result = this.DashboardRepository.TrackingHistory.Add(dfn, eventType, reason, comment);

                    // *** Set return success ***
                    success = result.Success;

                    // *** Show a message ***
                    if (result.Success)
                    {
                        // *** Update pregnancy status ***
                        if (newTrackingEntry.TrackingEntry.EntryType == TrackingEntryType.Start)
                            if (newTrackingEntry.UpdatePregnancyStatus)
                                UpdatePregnancyStatus(dfn, newTrackingEntry);

                        if (newTrackingEntry.TrackingEntry.EntryType == TrackingEntryType.Stop)
                            this.Information("The patient is no longer being tracked.");
                        else
                            this.Information("Tracking History Entry Created Successfully");
                    }
                    else
                        if (string.IsNullOrWhiteSpace(result.Message))
                        this.Error("Could not add tracking history entry");
                    else
                        this.Error(result.Message);
                }
            }
            catch (Exception genericException)
            {
                this.Error(genericException.Message);
                success = false;
            }

            if (success.Value)
            {
                if ((newTrackingEntry.TrackingEntry.EntryType == TrackingEntryType.Accept) ||
                    (newTrackingEntry.TrackingEntry.EntryType == TrackingEntryType.Reject))
                    returnResult = RedirectToAction("Index", "FlaggedPatients");
                else
                    returnResult = RedirectToAction("Overview", "PatientList");
            }
            else
            {
                // *** Repopulate model for error or problem
                CreateTrackingEntry model = GetNewModel(newTrackingEntry.TrackingEntry.EntryType, newTrackingEntry.TrackingEntry.PatientDfn);
                model.TrackingEntry.Comment = newTrackingEntry.TrackingEntry.Comment;
                returnResult = View("~/Views/Track/Create.cshtml", model);
            }

            return returnResult;
        }

        private CreateTrackingEntry GetNewModel(TrackingEntryType entryType, string dfn)
        {
            // *** Gets appropriate model based on entry type and dfn ***

            CreateTrackingEntry returnModel = new CreateTrackingEntry();

            // *** Set up button text, title, other ui elements ***
            switch (entryType)
            {
                case TrackingEntryType.Start:
                    returnModel.ButtonText = "Start Tracking";
                    returnModel.PageTitle = "Start Tracking a Patient";
                    returnModel.PageMessage = "The following patient will appear as a tracked patient in the dashboard";
                    SelectListResult selectListResult = this.DashboardRepository.SelectLists.GetReasonList();
                    if (selectListResult.Success)
                        returnModel.Reasons = selectListResult.SelectList;
                    returnModel.ReasonText = "Reason for Tracking";
                    break;
                case TrackingEntryType.Stop:
                    returnModel.ButtonText = "Stop Tracking";
                    returnModel.PageTitle = "Stop Tracking a Patient";
                    returnModel.PageMessage = "Patient will no longer appear as a tracked patient in the dashboard";
                    returnModel.OutcomeTableHeader = "Pregnancy Outcome";
                    returnModel.OutcomeHeader = "Outcome:";
                    returnModel.DateHeader = "Outcome/Delivery Date:";
                    returnModel.ReasonText = "Stop Tracking Reason";
                    List<string> stopTrackingReasonList = new List<string>()
                    {
                        "First trimester pregnancy failure or loss",
                        "Second trimester pregnancy failure or loss",
                        "Term or pre-term delivery, completed 8 weeks of postpartum care",
                        "Transfer of care",
                        "Moved out of area",
                        "Other"
                    };
                    returnModel.Reasons = stopTrackingReasonList;
                    break;
                case TrackingEntryType.Accept:
                    returnModel.ButtonText = "Accept Tracking";
                    returnModel.PageTitle = "Accept Flagged Patient";
                    returnModel.PageMessage = "The following patient will appear as a tracked patient in the dashboard";
                    break;
                case TrackingEntryType.Reject:
                    returnModel.ButtonText = "Reject Tracking";
                    returnModel.PageTitle = "Reject Flagged Patient";
                    returnModel.PageMessage = "The following patient will not appear as a tracked or flagged patient in the dashboard";
                    break;
            }

            // *** Set return url ***
            if (TempData.ContainsKey(ReturnUrl))
            {
                returnModel.ReturnUrl = TempData[ReturnUrl].ToString();
                TempData[ReturnUrl] = TempData[ReturnUrl];
            }

            // *** Get patient demographics ***
            this.CurrentPatientDfn = dfn;
            BasePatient currentPatient = this.CurrentPatient;

            if (!currentPatient.NotFound)
            {
                // *** Populate model with data ***
                returnModel.TrackingEntry = new TrackingEntry()
                {
                    PatientDfn = dfn,
                    EntryType = entryType,
                    PatientName = currentPatient.Name
                };

                returnModel.Patient = currentPatient;
            }

            return returnModel;
        }

        private bool UpdatePregnancyStatus(string dfn, CreateTrackingEntry newTrackingEntry)
        {
            bool returnVal = false;

            PregnancyResult pregResult = this.DashboardRepository.Pregnancy.GetCurrentPregnancy(dfn);

            if (!pregResult.Success)
            {
                this.Error(pregResult.Message);
            }
            else if (pregResult.Pregnancy == null)
            {
                PregnancyDetails newPreg = new PregnancyDetails();
                newPreg.PatientDfn = dfn;
                newPreg.RecordType = PregnancyRecordType.Current;
                bool pregnancyValue = true;
                newPreg.Lmp = newTrackingEntry.LMP;
                newPreg.EDD = VistaDates.ParseDateString(newTrackingEntry.EDD, VistaDates.VistADateOnlyFormat);

                BrokerOperationResult result2 = this.DashboardRepository.Pregnancy.SavePregnancyToDifferentNamespace(newPreg, newPreg.PatientDfn, pregnancyValue);
                if (!result2.Success)
                {
                    this.Error(result2.Message);
                }
                else
                {
                    BrokerOperationResult result = this.DashboardRepository.Pregnancy.SavePregnancy(newPreg);

                    if (!result.Success)
                    {
                        this.Error(result.Message);
                    }
                    else
                    {
                        returnVal = true;
                    }
                }
            }

            return returnVal;
        }
    }
}
