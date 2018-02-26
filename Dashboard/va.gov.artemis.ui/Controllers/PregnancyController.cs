// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Reflection;
using System.Web.Mvc;
using VA.Gov.Artemis.Core;
using VA.Gov.Artemis.UI.Data.Brokers.Common;
using VA.Gov.Artemis.UI.Data.Brokers.NonVACare;
using VA.Gov.Artemis.UI.Data.Brokers.Observations;
using VA.Gov.Artemis.UI.Data.Brokers.Pregnancy;
using VA.Gov.Artemis.UI.Data.Models.Common;
using VA.Gov.Artemis.UI.Data.Models.Edd;
using VA.Gov.Artemis.UI.Data.Models.NonVACare;
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
    public class PregnancyController : DashboardController
    {
        private const int SelectNonVACarePageSize = 10;
        private const int EddItemsPerPage = 10;

        [HttpGet]
        public ActionResult Index(string dfn)
        {
            PregnancyIndex model = GetPregnancyIndexModel(dfn);

            model.Patient = this.CurrentPatient;

            TempData[ReturnUrl] = Url.Action("Index", new { @dfn = dfn });

            return View(model);
        }

        [HttpGet]
        public ActionResult PregnancyView(string dfn, string pregIen)
        {
            ActionResult returnResult;

            PregnancyView model = new PregnancyView();

            model.Patient = this.CurrentPatient;

            if (string.IsNullOrWhiteSpace(pregIen))
                returnResult = RedirectToAction("Index", "Pregnancy", new { dfn = dfn });
            else
            {
                model.Pregnancy = PregnancyUtilities.GetPregnancy(this.DashboardRepository, dfn, pregIen);

                PregnancyOutcomeType outcomeType = this.GetPregnancyOutcome(dfn, pregIen);

                model.Outcome = PregnancyUtilities.GetOutcomeDetails(this.DashboardRepository, dfn, pregIen, outcomeType);

                model.Outcome.OutcomeType = outcomeType;
                model.Outcome.OutcomeDate = model.Pregnancy.DisplayEndDate;

                // *** Get the baby details ***
                model.Babies = GetBabyDetails(dfn, pregIen);

                // *** Add a baby details if no observations, but baby exists in pregnancy ***
                if (model.Pregnancy.Babies != null)
                    foreach (Baby baby in model.Pregnancy.Babies)
                    {
                        bool found = false;
                        foreach (BabyDetails bd in model.Babies)
                            if (bd.Ien == baby.Ien)
                                found = true;

                        if (!found)
                            model.Babies.Add(new BabyDetails() { Ien = baby.Ien, BabyNum = baby.BabyNum.ToString() });
                    }

                TempData[ReturnUrl] = Url.Action("PregnancyView", new { @dfn = dfn, @pregIen = pregIen });

                returnResult = View(model);
            }

            return returnResult;
        }

        [HttpGet]
        public ActionResult AddEdit(string dfn, string pregIen)
        {
            PregnancyAddEdit model = new PregnancyAddEdit();

            model.Patient = this.CurrentPatient;

            if (!string.IsNullOrWhiteSpace(pregIen))
            {
                //PregnancyListResult result = this.DashboardRepository.Pregnancy.GetPregnancies(dfn, pregIen);
                model.Item = PregnancyUtilities.GetPregnancy(this.DashboardRepository, dfn, pregIen);

                //if (!result.Success)
                //    this.Error(result.Message);
                //else
                //{
                //    if (result.Pregnancies != null)
                //        if (result.Pregnancies.Count > 0)
                //        {
                //            model.Item = result.Pregnancies[0];

                if (model.Item != null)
                {
                    ObservationListResult obsResult = this.DashboardRepository.Observations.GetObservations(dfn, pregIen, "", "", "", "", "Outcome", 0, 0);

                    if (obsResult.Success)
                        if (obsResult.Observations != null)
                            foreach (Observation obs in obsResult.Observations)
                                if (obs.Code == ObservationsFactory.OutcomeTypeCode)
                                {
                                    PregnancyOutcomeType outType = PregnancyOutcomeType.Unknown;
                                    if (Enum.TryParse<PregnancyOutcomeType>(obs.Value, true, out outType))
                                        model.OutcomeType = outType;
                                }

                    // *** Keep track of original values ***
                    model.OriginalLmp = model.Item.Lmp;
                    model.OriginalFetusBabyCount = model.Item.FetusBabyCount;
                }
            }
            else
            {
                // *** Creating new historical pregnancy ***
                model.Item.RecordType = PregnancyRecordType.Historical;
                model.Item.PatientDfn = dfn;
            }

            NonVACareItemsResult nonVAResult = this.DashboardRepository.NonVACare.GetList(NonVACareItemType.Provider, 1, 1000, false);

            if (nonVAResult.Success)
                if (nonVAResult.Items != null)
                {
                    model.ObList.Add("", "(Select)");
                    foreach (NonVACareItem item in nonVAResult.Items)
                        model.ObList.Add(item.Ien, item.Name);
                }

            nonVAResult = this.DashboardRepository.NonVACare.GetList(NonVACareItemType.Facility, 1, 1000, false);

            if (nonVAResult.Success)
                if (nonVAResult.Items != null)
                {
                    model.LDList.Add("", "(Select)");
                    foreach (NonVACareItem item in nonVAResult.Items)
                        model.LDList.Add(item.Ien, item.Name);
                }

            model.FofList = this.GetFofChoices(dfn);

            TempData[ReturnUrl] = Url.Action("PregnancyView", new { @dfn = dfn, @pregIen = pregIen });

            model.ReturnUrl = TempData[ReturnUrl].ToString();

            TempData[FinishedUrl] = Url.Action("AddEdit", "Pregnancy", new { @dfn = dfn, @pregIen = pregIen });

            return View(model);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult AddEdit(PregnancyAddEdit model)
        {
            ActionResult returnResult;

            bool ok = false;

            bool addingNew = string.IsNullOrWhiteSpace(model.Item.Ien);

            // *** Validate ***

            // *** Update estimated "start" of pregnancy ***
            if (model.Item.EDD != DateTime.MinValue)
                model.Item.StartDate = model.Item.EDD.Subtract(new TimeSpan(280, 0, 0, 0));
            else if (model.Item.LmpDateType != ClinicalDateType.Unknown)
                if (!string.IsNullOrWhiteSpace(model.Item.Lmp))
                {
                    string tempDate = VistaDates.StandardizeDateFormat(model.Item.Lmp);

                    if (!string.IsNullOrWhiteSpace(tempDate))
                        model.Item.StartDate = VistaDates.ParseDateString(tempDate, VistaDates.VistADateOnlyFormat);
                }

            IenResult saveResult = this.DashboardRepository.Pregnancy.SavePregnancy(model.Item);

            if (saveResult.Success)
            {
                model.Item.Ien = saveResult.Ien;

                // *** Create observations for LMP and Fetus/Baby Count ***
                List<Observation> obsList = this.CreatePregnancyObservations(model);

                // *** Check if any to save ***
                if (obsList.Count > 0)
                {
                    BrokerOperationResult obsResult = this.DashboardRepository.Observations.SaveSingletonObservations(obsList);

                    if (obsResult.Success)
                        ok = true;
                    else
                        this.Error(obsResult.Message);
                }
                else
                    ok = true;

                // *** When creating a new current pregnancy, the checklist becomes inaccessible ***
                // *** Clear the next checklist due ***
                if (ok)
                {
                    if (model.Item.RecordType == PregnancyRecordType.Current)
                    {
                        BrokerOperationResult result = this.DashboardRepository.Patients.SaveNextChecklistDue(model.Item.PatientDfn, DateTime.MinValue);

                        if (!result.Success)
                            this.Error("Could not update next checklist due date");
                    }
                }
            }
            else
                this.Error(saveResult.Message);

            if (ok)
                returnResult = RedirectToAction("PregnancyView", new { dfn = model.Patient.Dfn, pregIen = saveResult.Ien });
            else
            {
                this.Error(saveResult.Message);

                this.CurrentPatientDfn = model.Patient.Dfn;
                model.Patient = this.CurrentPatient;

                returnResult = View(model);
            }

            return returnResult;
        }

        [HttpGet]
        public ActionResult SelectNonVACare(string dfn, string pien, string itemType, string page)
        {
            SelectNonVACareModel model = new SelectNonVACareModel();

            // *** Make sure patient is updated ***
            model.Patient = this.CurrentPatient;

            // *** Set the pregnancy IEN ***
            model.PregnancyIen = pien;

            // *** Get pregnancy details ***
            PregnancyListResult pregResult = this.DashboardRepository.Pregnancy.GetPregnancies(dfn, pien);

            bool ok = pregResult.Success;

            //NonVACareItemType nonVaType = (itemType == "P") ? NonVACareItemType.Provider : NonVACareItemType.Facility;

            NonVACareItemType nonVaType = NonVACareItemType.Provider;

            int itemTypeVal = -1;
            if (int.TryParse(itemType, out itemTypeVal))
                nonVaType = (NonVACareItemType)itemTypeVal;

            // *** Set current FOF from pregnancy info ***
            if (ok)
                if (pregResult.Pregnancies != null)
                    if (pregResult.Pregnancies.Count == 1)
                    {
                        if (nonVaType == NonVACareItemType.Facility)
                            model.CurrentSelectionIen = pregResult.Pregnancies[0].PlannedLaborDeliveryFacilityIen;
                        else
                            model.CurrentSelectionIen = pregResult.Pregnancies[0].ObstetricianIen;
                    }

            model.ItemType = nonVaType;

            int pageVal = GetPage(page);

            NonVACareItemsResult listResult = this.DashboardRepository.NonVACare.GetList(nonVaType, pageVal, SelectNonVACarePageSize, false);

            if (listResult.Success)
            {
                model.Items = listResult.Items;

                model.Paging.SetPagingData(SelectNonVACarePageSize, pageVal, listResult.TotalResults);

                model.Paging.BaseUrl = Url.Action("SelectNonVACare", new { dfn = dfn, pien = pien, itemType = itemType, page = "" });
            }
            else
                model.Paging.SetPagingData(SelectNonVACarePageSize, pageVal, 0);

            TempData[FinishedUrl] = Url.Action("SelectNonVACare", "Pregnancy", new { @dfn = dfn, @pien = pien, @itemType = itemType });

            return View(model);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult SelectNonVACare(SelectNonVACareModel model)
        {
            ActionResult returnResult = null;

            this.CurrentPatientDfn = model.Patient.Dfn;

            PregnancyDetails preg = GetPregnancy(model.PregnancyIen);

            if (preg != null)
            {
                // *** Update the IEN ***
                if (model.ItemType == NonVACareItemType.Facility)
                    preg.PlannedLaborDeliveryFacilityIen = model.CurrentSelectionIen;
                else
                    preg.ObstetricianIen = model.CurrentSelectionIen;

                // *** Save updated pregnancy ***
                BrokerOperationResult savePregResult = this.DashboardRepository.Pregnancy.SavePregnancy(preg);

                // *** Check result ***
                if (!savePregResult.Success)
                    this.Error(savePregResult.Message);
                else // *** Redirect to summary ***                    
                    returnResult = RedirectToActionPermanent("Summary", "Patient", new { @dfn = this.CurrentPatientDfn });
            }

            if (returnResult == null)
            {
                model.Patient = this.CurrentPatient;
                returnResult = View(model);
            }

            return returnResult;
        }

        [HttpGet]
        public ActionResult SelectFather(string dfn, string pien)
        {
            ActionResult returnResult = null;

            SelectFatherModel model = new SelectFatherModel();

            // *** Make sure patient is updated ***
            model.Patient = this.CurrentPatient;

            // *** Set the pregnancy IEN ***
            model.PregnancyIen = pien;

            // *** Get pregnancy details ***
            PregnancyListResult pregResult = this.DashboardRepository.Pregnancy.GetPregnancies(dfn, pien);

            bool ok = pregResult.Success;

            // *** Set current FOF from pregnancy info ***
            if (ok)
                if (pregResult.Pregnancies != null)
                    if (pregResult.Pregnancies.Count == 1)
                        model.CurrentSelection = pregResult.Pregnancies[0].FatherOfFetusIen;

            model.Choices = GetFofChoices(dfn);

            if (string.IsNullOrWhiteSpace(model.CurrentSelection))
                model.CurrentSelection = "U";

            if (string.IsNullOrWhiteSpace(model.PregnancyIen))
                model.PregnancyIen = "-1";

            returnResult = View(model);

            return returnResult;
        }

        private Dictionary<string, string> GetFofChoices(string dfn)
        {
            Dictionary<string, string> returnList = new Dictionary<string, string>();

            PersonListResult personResult = this.DashboardRepository.Pregnancy.GetPersons(dfn, "");

            returnList.Add("U", "Unknown/Unspecified");

            if (personResult.Success)
                if (personResult.TotalResults > 0)
                    foreach (Person person in personResult.PersonList)
                        if (!returnList.ContainsKey(person.Ien))
                        {
                            string tempName = person.Name;
                            if (person.Spouse)
                                tempName += " (Spouse)";

                            returnList.Add(person.Ien, tempName);
                        }

            return returnList;
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult SelectFather(SelectFatherModel model)
        {
            ActionResult returnResult = null;

            this.CurrentPatientDfn = model.Patient.Dfn;

            PregnancyDetails preg = GetPregnancy(model.PregnancyIen);

            if (preg != null)
            {
                // *** Update the IEN ***
                preg.FatherOfFetusIen = model.CurrentSelection;

                // *** Save updated pregnancy ***
                BrokerOperationResult savePregResult = this.DashboardRepository.Pregnancy.SavePregnancy(preg);

                // *** Check result ***
                if (!savePregResult.Success)
                    this.Error(savePregResult.Message);
                else // *** Redirect to summary ***                    
                    returnResult = RedirectToActionPermanent("Summary", "Patient", new { @dfn = this.CurrentPatientDfn });
            }

            if (returnResult == null)
                returnResult = View(model);

            return returnResult;
        }

        private PregnancyDetails GetPregnancy(string ien)
        {
            PregnancyDetails returnVal = null;

            // *** Determine if we have a pregnancy ***
            int pien = -1;
            int.TryParse(ien, out pien);
            if (pien > 0)
            {
                // *** Get pregnancy ***
                PregnancyListResult pregResult = this.DashboardRepository.Pregnancy.GetPregnancies(
                    this.CurrentPatientDfn,
                    ien);

                // *** Check result ***
                if (!pregResult.Success)
                    this.Error(pregResult.Message);
                else
                {
                    // *** Get the pregnancy from the result ***
                    if (pregResult.Pregnancies != null)
                        if (pregResult.Pregnancies.Count == 1)
                            returnVal = pregResult.Pregnancies[0];
                }
            }
            else
            {
                returnVal = new PregnancyDetails();
                returnVal.PatientDfn = this.CurrentPatientDfn;
                returnVal.RecordType = PregnancyRecordType.Current;
            }

            return returnVal;
        }

        [HttpGet]
        public ActionResult AddEditFather(string dfn, string pien, string fien)
        {
            ActionResult returnResult = null;

            FatherOfFetus model = new FatherOfFetus();

            model.Patient = this.CurrentPatient;
            model.PregnancyIen = pien;

            int fatherIen = -1;
            int.TryParse(fien, out fatherIen);

            model.Fof = GetFof(dfn, fatherIen);

            returnResult = View(model);

            return returnResult;
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult AddEditFather(FatherOfFetus model)
        {
            // *** Post the data from the add/edit father view ***

            ActionResult returnResult = null;

            // *** Set the patient ***
            this.CurrentPatientDfn = model.Patient.Dfn;
            model.Patient = this.CurrentPatient;

            // *** Save ***
            BrokerOperationResult saveResult = this.DashboardRepository.Pregnancy.SavePerson(model.Patient.Dfn, model.Fof);

            // *** Check result ***
            if (saveResult.Success)
                returnResult = RedirectToAction("SelectFather", new { @dfn = model.Patient.Dfn, @pien = model.PregnancyIen });
            else
            {
                // *** Prepare the model for staying on the same screen ***

                int fatherIen = -1;
                int.TryParse(model.Fof.Ien, out fatherIen);
                model.Fof = GetFof(model.Patient.Dfn, fatherIen);

                this.Error(saveResult.Message);

                returnResult = View(model);
            }

            return returnResult;
        }

        private Person GetFof(string patientDfn, int fatherIen)
        {
            Person returnVal = new Person();

            if (fatherIen > 0)
            {
                PersonListResult personResult = this.DashboardRepository.Pregnancy.GetPersons(patientDfn, fatherIen.ToString());

                if (personResult.Success)
                {
                    if (personResult.PersonList != null)
                        if (personResult.PersonList.Count == 1)
                            returnVal = personResult.PersonList[0];
                }
            }

            return returnVal;
        }

        [HttpGet]
        public ActionResult EditPregnancyHistory(string dfn)
        {
            // *** Prepare and show a view to edit pregnancy history ***

            EditPregnancyHistory model = new EditPregnancyHistory();

            // *** Add patient to the model ***
            model.Patient = this.CurrentPatient;

            // *** Try to get the pregnancy history ***
            PregnancyHistoryResult result = this.DashboardRepository.Pregnancy.GetPregnancyHistory(dfn);

            // *** Check for success ***
            if (!result.Success)
                this.Error(result.Message);
            else
                model.History = result.PregnancyHistory;

            // *** Make sure there is a pregnancy history ***
            if (model.History == null)
                model.History = new PregnancyHistory();

            // *** Set return url ***
            model.ReturnUrl = Url.Action("Summary", "Patient", new { @dfn = dfn });

            return View(model);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult EditPregnancyHistory(EditPregnancyHistory model)
        {
            ActionResult returnResult = null;

            this.CurrentPatientDfn = model.Patient.Dfn;

            BrokerOperationResult result = this.DashboardRepository.Pregnancy.SavePregnancyHistory(model.Patient.Dfn, model.History);

            if (!result.Success)
                this.Error(result.Message);
            else
                returnResult = RedirectToAction("Summary", "Patient", new { @dfn = this.CurrentPatientDfn });

            if (returnResult == null)
            {
                model.Patient = this.CurrentPatient;
                returnResult = View(model);
            }

            return returnResult;
        }

        [HttpGet]
        public ActionResult EddHistory(string dfn, string pregIen, string page)
        {
            ActionResult returnResult;

            EddHistoryModel model = new EddHistoryModel();

            model.Patient = this.CurrentPatient;
            model.PregnancyIen = pregIen;

            int pageVal = this.GetPage(page);

            if (string.IsNullOrWhiteSpace(pregIen))
            {
                this.Error("Invalid Pregnancy Identifier");
                returnResult = RedirectToAction("Summary", "Patient", new { @dfn = dfn });
            }
            else
            {
                ObservationListResult result = this.DashboardRepository.Pregnancy.GetObservations(dfn, pregIen, "", "", "", "EDD", pageVal, EddItemsPerPage);

                if (!result.Success)
                    this.Error(result.Message);
                else
                {
                    model.Paging.SetPagingData(EddItemsPerPage, pageVal, result.TotalResults);
                    model.Paging.BaseUrl = Url.Action("EddHistory", new { @dfn = dfn, @pregIen = pregIen, @page = "" });

                    if (result.Observations != null)
                        foreach (Observation dsioObservation in result.Observations)
                        {
                            EddHistoryItem eddItem = EddUtility.GetHistoryItem(dsioObservation);

                            model.History.Add(eddItem);
                        }
                }
                returnResult = View(model);
            }
            return returnResult;
        }

        //[HttpGet]
        //public ActionResult AddEditEdd(string dfn, string pregIen, string obsIen)
        //{
        //    EddObservationModel model = new EddObservationModel();

        //    model.Patient = this.CurrentPatient; 

        //    int obsIenVal = -1;
        //    int.TryParse(obsIen, out obsIenVal);

        //    if (obsIenVal > 0)
        //    {
        //    }
        //    else 
        //    {
        //        // *** Create new observation ***
        //        model.Observation = new EditableEddHistoryItem(); 
        //        model.Observation.PatientDfn = dfn;
        //        model.Observation.PregnancyIen = pregIen;
        //    }

        //    return View(model);
        //}

        //[HttpPost]
        //public ActionResult AddEditEdd(EddObservationModel model)
        //{
        //    ActionResult returnResult = null; 

        //    DsioObservation dsioObservation = EddUtility.GetDsioObservation(model.Observation);

        //    if (string.IsNullOrWhiteSpace(dsioObservation.Value))
        //    {
        //        this.Error("Please enter observation value");
        //        this.CurrentPatientDfn = model.Patient.Dfn;
        //        model.Patient = this.CurrentPatient;
        //        returnResult = View(model); 
        //    }
        //    else
        //    {
        //        dsioObservation.Category = "EDD";

        //        IenResult result = this.DashboardRepository.Observations.SaveObservation(dsioObservation);

        //        if (!result.Success)
        //            this.Error(result.Message);

        //        returnResult = RedirectToAction("EddHistory", new { @dfn = model.Patient.Dfn, @pregIen = model.Observation.PregnancyIen, @page = "1" });
        //    }

        //    return returnResult; 
        //}

        [HttpGet]
        public ActionResult Status(string dfn)
        {
            PregnancyStatusModel model = new PregnancyStatusModel();

            model.Patient = this.CurrentPatient;

            if (TempData.ContainsKey(ReturnUrl))
                model.ReturnUrl = TempData.Peek(ReturnUrl).ToString();
            else
                model.ReturnUrl = Url.Action("Patient", "Summary", new { dfn = dfn });

            return View(model);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Status(PregnancyStatusModel model)
        {
            ActionResult returnResult;

            bool success = false;
            bool goToOutcome = false;
            string pregIen = "";

            if (model.NewPregnancyStatusVal.HasValue)
            {
                if (model.Patient.Pregnant != model.NewPregnancyStatusVal.Value)
                {
                    if (model.Patient.Pregnant)
                    {
                        PregnancyResult pregResult = this.DashboardRepository.Pregnancy.GetCurrentPregnancy(model.Patient.Dfn);
                        if (!pregResult.Success)
                        {
                            this.Error(pregResult.Message);
                        }
                        else
                        {
                            PregnancyDetails updatedPreg = pregResult.Pregnancy;
                            // *** Update end date ***
                            model.OutcomeDate = VistaDates.StandardizeDateFormat(model.OutcomeDate);
                            updatedPreg.EndDate = VistaDates.ParseDateString(model.OutcomeDate, VistaDates.VistADateOnlyFormat);
                            bool pregnancyValue = model.NewPregnancyStatusVal.Value;
                            string patientDfn = model.Patient.Dfn;

                            if (string.IsNullOrWhiteSpace(model.OutcomeDate))
                            {
                                this.Error("Please enter a valid outcome date");
                            }
                            else
                            {
                                goToOutcome = true;
                                pregIen = updatedPreg.Ien;
                                success = true;
                                BrokerOperationResult saveResult2 = this.DashboardRepository.Pregnancy.SavePregnancyToDifferentNamespace(updatedPreg, patientDfn, pregnancyValue);
                                if (!saveResult2.Success)
                                {
                                    this.Error(saveResult2.Message);
                                }
                                else
                                {
                                    BrokerOperationResult saveResult = this.DashboardRepository.Pregnancy.SavePregnancy(updatedPreg);
                                    if (!saveResult.Success)
                                    {
                                        this.Error(saveResult.Message);
                                    }
                                }
                            }
                        }
                    }
                    else
                    {
                        PregnancyDetails newPreg = new PregnancyDetails();
                        newPreg.PatientDfn = model.Patient.Dfn;
                        newPreg.EDD = DateTime.Parse(model.EDD);
                        newPreg.Lmp = model.LMP;
                        newPreg.RecordType = PregnancyRecordType.Current;
                        bool pregnancyValue = model.NewPregnancyStatusVal.Value;
                        string patientDfn = model.Patient.Dfn;
                        BrokerOperationResult result2 = this.DashboardRepository.Pregnancy.SavePregnancyToDifferentNamespace(newPreg, patientDfn, pregnancyValue);
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
                                success = true;

                                // *** Update next checklist due ***
                                BrokerOperationResult nextResult = this.DashboardRepository.Patients.SaveNextChecklistDue(model.Patient.Dfn, DateTime.MinValue);
                                if (!result.Success)
                                {
                                    this.Error("Could not update next checklist due date");
                                }
                            }
                        }
                    }
                }
                else
                {
                    success = true;
                }

            }
            else
            {
                success = true;
            }

            if (!success)
            {
                this.CurrentPatientDfn = model.Patient.Dfn;
                model.Patient = this.CurrentPatient;
                returnResult = View(model);
            }
            else
            {
                if (goToOutcome)
                {
                    returnResult = RedirectToAction("AddEdit", "Outcome", new { @dfn = model.Patient.Dfn, @pregIen = pregIen });
                }
                else
                {
                    returnResult = RedirectToAction("Summary", "Patient", new { @dfn = model.Patient.Dfn });
                }
            }
            return returnResult;
        }

        [HttpGet]
        public ActionResult EddCalculator(string dfn, string pregIen)
        {
            ActionResult returnResult;

            EddCalculatorModel model = new EddCalculatorModel();

            if (string.IsNullOrWhiteSpace(pregIen))
            {
                this.Error("Invalid Pregnancy Identifier");
                returnResult = RedirectToAction("Summary", "Patient", new { @dfn = dfn });
            }
            else
            {
                model.Patient = this.CurrentPatient;
                model.PregnancyIen = pregIen;

                // *** Set return url ***
                if (TempData.ContainsKey(ReturnUrl))
                {
                    model.ReturnUrl = TempData.Peek(ReturnUrl).ToString();
                }
                else
                {
                    model.ReturnUrl = Url.Action("EddHistory", "Pregnancy", new { dfn = dfn, @pregIen = pregIen });
                }

                returnResult = View(model);
            }

            return returnResult;
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult EddCalculator(EddCalculatorModel model)
        {
            ActionResult returnResult;

            bool okToContinue = model.IsValid();

            if (!okToContinue)
            {
                this.Error(model.ValidationMessage);
            }
            else
            {
                List<Observation> observationList = this.GetEddObservations(model);

                BrokerOperationResult result = this.DashboardRepository.Observations.SaveObservations(observationList);

                if (!result.Success)
                {
                    okToContinue = false;
                    this.Error(result.Message);
                }
                else
                {
                    // *** Update pregnancy with new Edd ***
                    PregnancyListResult pregListResult = this.DashboardRepository.Pregnancy.GetPregnancies(model.Patient.Dfn, model.PregnancyIen);

                    if (!pregListResult.Success)
                    {
                        okToContinue = false;
                        this.Error(pregListResult.Message);
                    }
                    else
                    {
                        PregnancyDetails currentPregnancy = pregListResult.Pregnancies[0];
                        currentPregnancy.EDD = VistaDates.ParseDateString(model.FinalEdd, VistaDates.VistADateOnlyFormat);

                        // *** Update estimated "start" of pregnancy ***
                        currentPregnancy.StartDate = currentPregnancy.EDD.Subtract(new TimeSpan(280, 0, 0, 0));

                        BrokerOperationResult savePregResult = this.DashboardRepository.Pregnancy.SavePregnancy(currentPregnancy);

                        if (!savePregResult.Success)
                        {
                            okToContinue = false;
                            this.Error(savePregResult.Message);
                        }
                        else
                        {
                            this.Information("Estimated delivery date information saved successfully");
                        }
                    }
                }
            }

            if (!okToContinue)
            {
                this.CurrentPatientDfn = model.Patient.Dfn;
                model.Patient = this.CurrentPatient;
                returnResult = View(model);
            }
            else
            {
                if (TempData.ContainsKey(ReturnUrl))
                {
                    returnResult = Redirect(TempData[ReturnUrl].ToString());
                }
                else
                {
                    returnResult = RedirectToAction("EddHistory", new { @dfn = model.Patient.Dfn, @pregIen = model.PregnancyIen });
                }
            }

            return returnResult;
        }

        [HttpGet]
        public ActionResult BabyAddEdit(string dfn, string pregIen, string babyIen)
        {
            BabyAddEdit model = this.GetBabyAddEditModel(dfn, pregIen, babyIen);

            //model.Patient = this.CurrentPatient;
            //model.PregnancyIen = pregIen; 

            //// *** Get the observation category ***
            //string cat = new BabyDetails().ObservationCategory;

            //// *** Get observations ***
            //ObservationListResult obsResult = this.DashboardRepository.Observations.GetObservationListByCategory(dfn, pregIen, cat);

            //// *** Check for success ***
            //if (obsResult.Success)
            //{
            //    // *** If no babyNum then adding new ***
            //    if (string.IsNullOrWhiteSpace(babyNum))
            //    {
            //        // *** Create a list of in-use baby nums ***
            //        List<string> inUse = new List<string>();

            //        // *** Loop through the observations, adding babyNum if needed ***
            //        if (obsResult.Observations != null)
            //            foreach (DsioObservation obs in obsResult.Observations)
            //                if (!inUse.Contains(obs.BabyNum))
            //                    inUse.Add(obs.BabyNum);

            //        int newBabyNum;

            //        // *** Now look for an available babyNum ***
            //        for (newBabyNum = 1; newBabyNum < 10; newBabyNum++)
            //            if (!inUse.Contains(newBabyNum.ToString()))
            //                break;

            //        if (newBabyNum < 10)
            //            model.Details.BabyNum = newBabyNum.ToString();
            //        else
            //            this.Error("This pregnancy already has 9 babies.  You cannot add more than 9 babies to a pregnancy."); 

            //    }
            //    else // BabyNum passed in...
            //    {
            //        // *** Create a list of observations for this babyNum ***
            //        List<DsioObservation> babyObservations = new List<DsioObservation>();

            //        if (obsResult.Observations != null)
            //            foreach (DsioObservation obs in obsResult.Observations)
            //                if (obs.BabyNum == babyNum)
            //                    babyObservations.Add(obs); 

            //        // *** Construct baby details ***
            //        model.Details = new BabyDetails(babyObservations);

            //        model.Details.BabyNum = babyNum; 

            //    }
            //}
            //else
            //    this.Error(obsResult.Message);

            return View(model);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult BabyAddEdit(BabyAddEdit model)
        {
            ActionResult returnResult;

            bool ok = true;
            string errorMessage = "";

            // *** Validate model data ***
            if (model.IsValid())
            {
                // *** Check if the baby exists yet ***
                if (model.Details.Ien == "-1")
                {
                    // *** Baby does not exist yet, Add ***
                    AddBabyResult addResult = this.DashboardRepository.Pregnancy.AddBabyToPregnancy(model.Patient.Dfn, model.PregnancyIen);

                    // *** Check result ***
                    if (!addResult.Success)
                    {
                        errorMessage = addResult.Message;
                        ok = false;
                    }
                    else
                    {
                        // *** Add numbers to model details ***
                        model.Details.Ien = addResult.NewBabyIen;
                        model.Details.BabyNum = addResult.NewBabyNumber;
                    }
                }

                // *** Check if ok still ***
                if (ok)
                {
                    // *** Get the observations ***
                    List<Observation> babyObservations = model.Details.GetObservations(model.Patient.Dfn, model.PregnancyIen, model.Details.Ien);

                    // *** Save observations ***
                    BrokerOperationResult obsResult = this.DashboardRepository.Observations.SaveSingletonObservations(babyObservations);

                    // *** Check for success ***
                    if (!obsResult.Success)
                    {
                        errorMessage = obsResult.Message;
                        ok = false;
                    }
                }
            }
            else
            {
                errorMessage = model.ValidationMessage;
                ok = false;
            }

            // *** Check if ok to prepare return ***
            if (!ok)
            {
                this.CurrentPatientDfn = model.Patient.Dfn;
                model.Patient = this.CurrentPatient;
                this.Error(errorMessage);
                returnResult = View(model);
            }
            else
            {
                returnResult = RedirectToAction("PregnancyView", new { dfn = model.Patient.Dfn, pregIen = model.PregnancyIen });
            }

            return returnResult;
        }

        [HttpGet]
        public ActionResult Delete(string dfn, string pregIen)
        {
            ActionResult returnResult;

            if (!string.IsNullOrWhiteSpace(pregIen))
            {
                BrokerOperationResult opResult = this.DashboardRepository.Pregnancy.Delete(pregIen);

                if (!opResult.Success)
                {
                    this.Error(opResult.Message);
                    returnResult = RedirectToAction("AddEdit", "Pregnancy", new { @dfn = dfn, @pregIen = pregIen });
                }
                else
                {
                    this.Information("Pregnancy Deleted");
                    returnResult = RedirectToAction("Index", "Pregnancy", new { dfn = dfn });
                }
            }
            else
            {
                this.Error("Invalid Pregnancy IEN");
                returnResult = RedirectToAction("AddEdit", "Pregnancy", new { @dfn = dfn, @pregIen = pregIen });
            }

            return returnResult;
        }

        private List<Observation> GetEddObservations(EddCalculatorModel model)
        {
            List<Observation> returnList = new List<Observation>();

            List<EddItem> modelItems = model.ToList();

            foreach (EddItem item in modelItems)
            {
                if (item.HasValue)
                {
                    if (item.ItemType == model.FinalBasedOn)
                        item.IsFinal = true;

                    Observation dsioObs = EddUtility.GetDsioObservation(model.Patient.Dfn, model.PregnancyIen, item);

                    if (dsioObs != null)
                        returnList.Add(dsioObs);

                    // *** Also create LMP observation ***
                    if (item.ItemType == EddItemType.LMP)
                    {
                        dsioObs = ObservationsFactory.CreateLmpObservation(model.Patient.Dfn, model.PregnancyIen, item.EventDate, false);
                        returnList.Add(dsioObs);
                    }

                }
            }

            return returnList;
        }

        private List<Observation> CreatePregnancyObservations(PregnancyAddEdit model)
        {
            List<Observation> returnList = new List<Observation>();

            Observation tempObs;

            // *** Don't create observation unless something has changed ***
            if (model.OriginalLmp != model.Item.Lmp)
            {
                if (model.Item.LmpDateType == ClinicalDateType.Unknown)
                    model.Item.Lmp = "";

                bool approx = (model.Item.LmpDateType == ClinicalDateType.Approximate);

                tempObs = ObservationsFactory.CreateLmpObservation(model.Patient.Dfn, model.Item.Ien, model.Item.Lmp, approx);

                if (tempObs != null)
                    returnList.Add(tempObs);
            }

            if (model.OriginalFetusBabyCount != model.Item.FetusBabyCount)
            {
                tempObs = ObservationsFactory.CreateFetusBabyCountObservation(model.Patient.Dfn, model.Item.Ien, model.Item.FetusBabyCount);

                if (tempObs != null)
                    returnList.Add(tempObs);
            }

            return returnList;
        }

        private PregnancyOutcomeType GetPregnancyOutcome(string patientDfn, string pregIen)
        {
            PregnancyOutcomeType returnVal = PregnancyOutcomeType.Unknown;

            ObservationListResult obsResult = this.DashboardRepository.Observations.GetObservations(patientDfn, pregIen, "", "", "", "", "Outcome", 0, 0);

            if (obsResult.Success)
                if (obsResult.Observations != null)
                    foreach (Observation obs in obsResult.Observations)
                        if (obs.Code == ObservationsFactory.OutcomeTypeCode)
                        {
                            PregnancyOutcomeType outType = PregnancyOutcomeType.Unknown;
                            if (Enum.TryParse<PregnancyOutcomeType>(obs.Value, true, out outType))
                                returnVal = outType;
                        }

            return returnVal;
        }

        private List<BabyDetails> GetBabyDetails(string dfn, string pregIen)
        {
            List<BabyDetails> returnList = new List<BabyDetails>();

            Dictionary<string, List<Observation>> observationsByNum = new Dictionary<string, List<Observation>>();

            // *** Get the observation category ***
            string cat = new BabyDetails().ObservationCategory;

            // *** Get observations ***
            ObservationListResult obsResult = this.DashboardRepository.Observations.GetObservationListByCategory(dfn, pregIen, cat);

            // *** Check for success ***
            if (obsResult.Success)
                if (obsResult.Observations != null)
                    foreach (Observation observation in obsResult.Observations)
                    {
                        if (!string.IsNullOrWhiteSpace(observation.BabyIen))
                        {
                            // *** Make a new list for this baby if needed ***
                            if (!observationsByNum.ContainsKey(observation.BabyIen))
                                observationsByNum.Add(observation.BabyIen, new List<Observation>());

                            // *** Add the observation to the list ***
                            observationsByNum[observation.BabyIen].Add(observation);
                        }
                        else
                            ErrorLogger.Log(string.Format("Baby Observation without an IEN. Observation IEN = {0}", observation.Ien));
                    }

            // *** Loop through list (one for each baby) ***
            foreach (string key in observationsByNum.Keys)
            {
                foreach (var temp in observationsByNum[key])
                    Debug.WriteLine("Observation {0} {1} {2}", temp.EntryDate, temp.Code, temp.Narrative);

                // *** Create a baby details ***
                BabyDetails tempDetails = new BabyDetails(observationsByNum[key]);

                // *** Add to return ***
                returnList.Add(tempDetails);
            }

            returnList.Sort(delegate (BabyDetails x, BabyDetails y)
            {
                return x.BabyNum.CompareTo(y.BabyNum);
            });

            return returnList;
        }

        private PregnancyIndex GetPregnancyIndexModel(string dfn)
        {
            // *** Create the model for showing a list of pregnancies ***

            PregnancyIndex model = new PregnancyIndex();

            // *** First, get a list of pregnancies ***
            PregnancyListResult result = this.DashboardRepository.Pregnancy.GetPregnancies(dfn, "");

            if (!result.Success)
                this.Error(result.Message);
            else
            {
                if (result.Pregnancies != null)
                {
                    // *** If we have something to work with, create a dictionary ***

                    Dictionary<string, PastPregnancy> pastPregnancies = new Dictionary<string, PastPregnancy>();

                    foreach (var preg in result.Pregnancies)
                    {
                        // *** Check type of prgnancy ***

                        if (preg.RecordType == PregnancyRecordType.Current)
                            model.CurrentPregnancy = preg;
                        else if (preg.RecordType == PregnancyRecordType.Historical)
                        {
                            // *** Add new past pregnancy to dictionary and populate data ***

                            PastPregnancy pastPreg = new PastPregnancy();

                            pastPreg.Ien = preg.Ien;

                            if (preg.EndDate != DateTime.MinValue)
                                pastPreg.PregnancyDate = preg.EndDate;

                            pastPreg.PlaceOfDelivery = preg.PlannedLaborDeliveryFacility;

                            if ((preg.EndDate != DateTime.MinValue) && (preg.EDD != DateTime.MinValue))
                                pastPreg.GestationalAge = EddUtility.GetGestationalAgeOn(preg.EDD, preg.EndDate);

                            pastPreg.HighRisk = preg.HighRisk;
                            pastPreg.HighRiskDetails = preg.HighRiskDetails;

                            pastPreg.Created = preg.Created;

                            // *** Add it to dictionary ***
                            pastPregnancies.Add(preg.Ien, pastPreg);
                        }
                    }

                    // *** Get all of this patient's observations ***
                    ObservationListResult patientObservations = this.DashboardRepository.Observations.GetObservations(dfn, "", "", "", "", "", "", 0, 0);

                    if (patientObservations.Success)
                        if (patientObservations.Observations != null)
                        {
                            // *** Get codes for birth weight, gender ***
                            PropertyInfo pi = typeof(BabyDetails).GetProperty("BirthWeight");
                            CdaCodingInfo codingInfo = pi.GetCustomAttribute<CdaCodingInfo>();
                            string birthWeightCode = codingInfo.Code;

                            pi = typeof(BabyDetails).GetProperty("Gender");
                            codingInfo = pi.GetCustomAttribute<CdaCodingInfo>();
                            string genderCode = codingInfo.Code;

                            pi = typeof(DeliveryDetails).GetProperty("GestationalAge");
                            codingInfo = pi.GetCustomAttribute<CdaCodingInfo>();
                            string gaCode = codingInfo.Code;

                            pi = typeof(DeliveryDetails).GetProperty("DeliveryHospital");
                            codingInfo = pi.GetCustomAttribute<CdaCodingInfo>();
                            string place = codingInfo.Code;

                            // *** Sort Observations ***
                            patientObservations.Observations = patientObservations.Observations
                                .OrderBy(o => o.EntryDate)
                                .ToList();

                            foreach (var obs in patientObservations.Observations)
                            {
                                // *** Looking for elements ***

                                BabyDetails bd = new BabyDetails();
                                DeliveryDetails dd = new DeliveryDetails();

                                if (model.CurrentPregnancy != null)
                                    if (model.CurrentPregnancy.Ien == obs.PregnancyIen)
                                    {
                                        if (obs.Code == "FetusBabyCount")
                                        {
                                            int count = -1;
                                            if (int.TryParse(obs.Value, out count))
                                                model.CurrentPregnancy.FetusBabyCount = count;
                                        }
                                        else if (obs.Code == EddUtility.LmpDateCode)
                                        {
                                            object[] returnVal = PregnancyUtilities.ParseLmp(obs.Value);

                                            model.CurrentPregnancy.Lmp = returnVal[0].ToString();

                                            if (returnVal[1] is ClinicalDateType)
                                                model.CurrentPregnancy.LmpDateType = (ClinicalDateType)returnVal[1];
                                        }
                                    }

                                // *** Look for observations that correspond with past pregnancy ***
                                if (!string.IsNullOrWhiteSpace(obs.PregnancyIen))
                                {
                                    if (pastPregnancies.ContainsKey(obs.PregnancyIen))
                                    {
                                        if (string.Equals(obs.Category, bd.ObservationCategory, StringComparison.OrdinalIgnoreCase))
                                        {

                                            // *** BirthWeight - Array ***
                                            // *** Sex - Array ***
                                            if (obs.Code == birthWeightCode)
                                                pastPregnancies[obs.PregnancyIen].BirthWeight.Add(BabyUtilities.GetBabyDisplayWeight(obs.Value));
                                            else if (obs.Code == genderCode)
                                                pastPregnancies[obs.PregnancyIen].Sex.Add(obs.Value);
                                        }
                                        else if (string.Equals(obs.Category, dd.ObservationCategory, StringComparison.OrdinalIgnoreCase))
                                        {
                                            // *** Delivery Type - Array ***
                                            // *** Preterm Labor ***
                                            switch (obs.Code)
                                            {
                                                case "NormalSpontaneousVaginalDelivery":
                                                case "ForcepVacuumDelivery":
                                                case "FailedForcepVacuumDelivery":
                                                case "CesareanDelivery":
                                                case "OtherDelivery":
                                                    bool deliveryVal = false;
                                                    if (bool.TryParse(obs.Value, out deliveryVal))
                                                        if (deliveryVal)
                                                        {
                                                            string desc = DeliveryDetails.GetDeliveryTypeDescription(obs.Code);
                                                            pastPregnancies[obs.PregnancyIen].DeliveryType.Add(desc);
                                                        }
                                                    break;

                                            }

                                            // *** Overwrite gestational age if entered ***
                                            if (obs.Code == gaCode)
                                                pastPregnancies[obs.PregnancyIen].GestationalAge = EddUtility.GetShortGestationalAge(obs.Value);
                                            else if (obs.Code == place)
                                                if (!string.IsNullOrWhiteSpace(obs.Value))
                                                    pastPregnancies[obs.PregnancyIen].PlaceOfDelivery = obs.Value;

                                        }
                                        else if (string.Equals(ObservationsFactory.OutcomeCategory, obs.Category, StringComparison.OrdinalIgnoreCase))
                                        {
                                            if (string.Equals(ObservationsFactory.OutcomeTypeCode, obs.Code, StringComparison.OrdinalIgnoreCase))
                                            {
                                                PregnancyOutcomeType outType;
                                                if (Enum.TryParse<PregnancyOutcomeType>(obs.Value, true, out outType))
                                                    if (pastPregnancies.ContainsKey(obs.PregnancyIen))
                                                        pastPregnancies[obs.PregnancyIen].Outcome = PregnancyOutcomeUtility.GetDescription(outType);
                                            }
                                        }
                                    }
                                }
                            }
                        }

                    // *** Add the working dictionary pregnancies to the model ***
                    model.PastPregnancies.AddRange(pastPregnancies.Values);

                    // *** Sort ***
                    model.PastPregnancies.Sort(delegate (PastPregnancy x, PastPregnancy y)
                    {
                        return y.PregnancyDate.CompareTo(x.PregnancyDate);
                    });

                }
            }

            return model;
        }

        //private BabyAddEdit GetBabyAddEditModel(string dfn, string pregIen, string babyNum)
        //{
        //    BabyAddEdit model = new BabyAddEdit();

        //    model.Patient = this.CurrentPatient;
        //    model.PregnancyIen = pregIen;

        //    // *** Get the observation category ***
        //    string cat = new BabyDetails().ObservationCategory;

        //    // *** Get observations ***
        //    ObservationListResult obsResult = this.DashboardRepository.Observations.GetObservationListByCategory(dfn, pregIen, cat);

        //    // *** Check for success ***
        //    if (obsResult.Success)
        //    {
        //        // *** If no babyNum then adding new ***
        //        if (string.IsNullOrWhiteSpace(babyNum))
        //        {
        //            // *** Create a list of in-use baby nums ***
        //            List<string> inUse = new List<string>();

        //            // *** Loop through the observations, adding babyNum if needed ***
        //            if (obsResult.Observations != null)
        //                foreach (DsioObservation obs in obsResult.Observations)
        //                    if (!inUse.Contains(obs.BabyNum))
        //                        inUse.Add(obs.BabyNum);

        //            int newBabyNum;

        //            // *** Now look for an available babyNum ***
        //            for (newBabyNum = 1; newBabyNum < 10; newBabyNum++)
        //                if (!inUse.Contains(newBabyNum.ToString()))
        //                    break;

        //            if (newBabyNum < 10)
        //                model.Details.BabyNum = newBabyNum.ToString();
        //            else
        //                this.Error("This pregnancy already has 9 babies.  You cannot add more than 9 babies to a pregnancy.");

        //        }
        //        else // BabyNum passed in...
        //        {
        //            // *** Create a list of observations for this babyNum ***
        //            List<DsioObservation> babyObservations = new List<DsioObservation>();

        //            if (obsResult.Observations != null)
        //                foreach (DsioObservation obs in obsResult.Observations)
        //                    if (obs.BabyNum == babyNum)
        //                        babyObservations.Add(obs);

        //            // *** Construct baby details ***
        //            model.Details = new BabyDetails(babyObservations);

        //            model.Details.BabyNum = babyNum;

        //        }
        //    }
        //    else
        //        this.Error(obsResult.Message);

        //}

        private BabyAddEdit GetBabyAddEditModel(string dfn, string pregIen, string babyIen)
        {
            BabyAddEdit model = new BabyAddEdit();

            model.Patient = this.CurrentPatient;
            model.PregnancyIen = pregIen;

            // *** Get the observation category ***
            string cat = new BabyDetails().ObservationCategory;

            // *** Get observations ***
            ObservationListResult obsResult = this.DashboardRepository.Observations.GetObservationListByCategory(dfn, pregIen, cat);

            // *** Check for success ***
            if (obsResult.Success)
            {
                // *** If no babyNum then adding new ***
                if (string.IsNullOrWhiteSpace(babyIen))
                {
                    //AddBabyResult addResult = this.DashboardRepository.Pregnancy.AddBabyToPregnancy(dfn, pregIen);

                    //if (!addResult.Success)
                    //    this.Error(addResult.Message);
                    //else
                    //{
                    //    model.Details.BabyNum = addResult.NewBabyNumber;
                    //    model.Details.Ien = addResult.NewBabyIen; 
                    //}

                    model.Details.Ien = "-1";
                }
                else // BabyNum passed in...
                {
                    // *** Create a list of observations for this babyNum ***
                    List<Observation> babyObservations = new List<Observation>();

                    if (obsResult.Observations != null)
                        foreach (Observation obs in obsResult.Observations)
                            if (obs.BabyIen == babyIen)
                                babyObservations.Add(obs);

                    // *** Put in order from oldest to newest ***
                    //babyObservations.Sort((a, b) => string.Compare(a.ObservationDate, b.ObservationDate)); 

                    foreach (var temp in babyObservations)
                        Debug.WriteLine("Observation {0} {1} {2}", temp.EntryDate, temp.Code, temp.Narrative);

                    // *** Construct baby details ***
                    model.Details = new BabyDetails(babyObservations);

                    // *** If no observations, make sure ien is set ***
                    if (string.IsNullOrWhiteSpace(model.Details.Ien))
                        model.Details.Ien = babyIen;
                }
            }
            else
                this.Error(obsResult.Message);

            return model;
        }
    }
}