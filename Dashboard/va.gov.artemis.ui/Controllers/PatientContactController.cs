using System;
using System.Collections;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using VA.Gov.Artemis.UI.Data.Brokers.Common;
using VA.Gov.Artemis.UI.Data.Brokers.NonVACare;
using VA.Gov.Artemis.UI.Data.Brokers.Notes;
using VA.Gov.Artemis.UI.Data.Brokers.Pregnancy;
using VA.Gov.Artemis.UI.Data.Models;
using VA.Gov.Artemis.UI.Data.Models.PatientContact;
using VA.Gov.Artemis.UI.Data.Models.NonVACare;
using VA.Gov.Artemis.UI.Data.Models.Notes;
using VA.Gov.Artemis.UI.Data.Models.Patient;
using VA.Gov.Artemis.UI.Data.Models.Pregnancy;
using VA.Gov.Artemis.UI.Filters;
using VA.Gov.Artemis.UI.Data.Brokers.Checklist;
using VA.Gov.Artemis.UI.Data.Models.Checklist;
using VA.Gov.Artemis.Commands.Dsio.Checklist;

namespace VA.Gov.Artemis.UI.Controllers
{
    [Authorize]
    [VerifySession]
    [DisableLocalCache]
    public class PatientContactController :DashboardController
    {
        private const int NotesPerPage = 10; 

        [HttpGet]
        public ActionResult Index(string dfn, string filter)
        {
            // *** Show list of patient contact notes and checklist items ***

            PatientContactIndex model = new PatientContactIndex();

            model.Patient = this.CurrentPatient;

            // *** Get the pregnancies ***
            List<PregnancyDetails> pregList = PregnancyUtilities.GetPregnancies(this.DashboardRepository, dfn);

            // *** Get the selection ***
            model.PregnancyFilters = PregnancyUtilities.GetPregnanciesSelection(pregList, true);

            // *** Get valid filter ***
            model.CurrentPregnancyFilter = PregnancyUtilities.GetValidatedPregnancyFilter(pregList, filter);

            // *** Get the checklist items matching pregnancies ***
            model.Checklist = this.GetChecklistNotes(pregList, model.CurrentPregnancyFilter, dfn);  

            // *** List of notes that have been added ***
            List<string> noteIensAdded = new List<string>();

            // *** Make a list ***
            foreach (var item in model.Checklist) 
                if (!noteIensAdded.Contains(item.CompletionLink))
                    noteIensAdded.Add(item.CompletionLink);

            // *** Set up pregIen for repo ***
            string pregIen = "";
            int tempIen = -1;
            if (int.TryParse(model.CurrentPregnancyFilter, out tempIen))
                pregIen = model.CurrentPregnancyFilter;

            // *** Get call notes ***
            NoteListResult notesResult = this.DashboardRepository.Notes.GetCallNotes(dfn, pregIen);

            if (notesResult.Success)
                if (notesResult.Notes != null)
                    foreach (TiuNote note in notesResult.Notes)
                        if (!noteIensAdded.Contains(note.Ien))
                        {
                            // *** If we find a note that has not already been added, add it ***

                            // *** Create a checklist item to show this note ***
                            PregnancyChecklistItem checklistItem = new PregnancyChecklistItem();

                            TiuNoteTitle tempTitle = TiuNoteTitleInfo.GetTitle(note.Title);
                            checklistItem.Description = MccPatientCallTypeUtility.GetDescription(tempTitle);

                            checklistItem.CompletionLink = note.Ien;
                            checklistItem.CompletedBy = note.Author;
                            checklistItem.PatientDfn = dfn;
                            checklistItem.DueCalculationType = DsioChecklistCalculationType.None;

                            // *** Show unsigned notes as incomplete/in-progress ***
                            if (note.SignatureStatus == TiuNoteSignatureStatus.Completed)
                            {
                                checklistItem.CompletionStatus = DsioChecklistCompletionStatus.Complete;
                                checklistItem.CompleteDate = note.DocumentDateTime;
                            }
                            else
                            {
                                checklistItem.CompletionStatus = DsioChecklistCompletionStatus.NotComplete;
                                checklistItem.InProgress = true;
                            }

                            model.Checklist.Add(checklistItem);
                            noteIensAdded.Add(note.Ien);
                        }

            // *** Finally, sort the list ***
            model.Checklist.Sort(delegate(PregnancyChecklistItem x, PregnancyChecklistItem y)
            {
                int returnVal = 0;

                if (x.Description == y.Description)
                {
                    DateTime xDate = (x.DueDate == DateTime.MinValue) ? x.CompleteDate : x.DueDate;
                    DateTime yDate = (y.DueDate == DateTime.MinValue) ? y.CompleteDate : y.DueDate;

                    returnVal = xDate.CompareTo(yDate);
                }
                else
                    returnVal = x.Description.CompareTo(y.Description);

                return returnVal;
            });

            return View(model);
        }

        //private Dictionary<string, string> GetFilterList(List<PregnancyDetails> pregList)
        //{
        //    Dictionary<string, string> returnList = new Dictionary<string, string>(); 

        //    if (pregList != null)
        //        if (pregList.Count > 0)
        //        {
        //            pregList.Sort(delegate(PregnancyDetails x, PregnancyDetails y)
        //            {
        //                return y.StartDate.CompareTo(x.StartDate);
        //            });

        //            int pregIdx = pregList.Count;

        //            foreach (PregnancyDetails pregDetail in pregList)
        //            {
        //                if (pregIdx == pregList.Count)
        //                {
        //                    if (pregDetail.RecordType == PregnancyRecordType.Current)
        //                        returnList.Add("Current Pregnancy", pregDetail.Ien);
        //                    else
        //                        returnList.Add("Most Recent Pregnancy", pregDetail.Ien);

        //                    //if (string.IsNullOrWhiteSpace(pregIen))
        //                    //{
        //                    //    pregIen = pregDetail.Ien;
        //                    //    preg = pregDetail;
        //                    //}
        //                }
        //                //else
        //                //    returnList.Add(string.Format("Pregnancy #{0} ({1})", pregIdx, pregDetail.StartDate.Year), pregDetail.Ien);

        //                //if (pregIen == pregDetail.Ien)
        //                //{
        //                //    model.PregnancyIen = pregDetail.Ien;
        //                //    pregFound = true;
        //                //    preg = pregDetail;
        //                //}

        //                pregIdx -= 1;
        //            }
        //        }
        
        //    returnList.Add("All", "A");

        //    return returnList; 
        //}

        //private string UpdatePregIen(List<PregnancyDetails> pregList, string pregIen) 
        //{
        //    string returnVal = "";
        //    string mostRecent = ""; 

        //    // *** PregIen needs updating if empty or not a valid pregIen for this patient ***

        //    if (pregIen == "A")
        //        returnVal = pregIen; 
        //    else 
        //    {
        //        if (pregList != null)
        //        {
        //            int pregIdx = pregList.Count;

        //            if (pregList != null)
        //                foreach (PregnancyDetails pregDetail in pregList)
        //                {
        //                    if (pregIdx == pregList.Count)
        //                        if (string.IsNullOrWhiteSpace(pregIen))
        //                            mostRecent = pregDetail.Ien;

        //                    if (pregIen == pregDetail.Ien)
        //                        returnVal = pregDetail.Ien;

        //                    pregIdx -= 1;
        //                }
        //        }

        //        // *** If returnVal not set ***
        //        // *** Set to most recent if exists ***
        //        // *** Set to A if not ***

        //        if (returnVal == "")
        //            if (mostRecent == "")
        //                returnVal = "A";
        //            else
        //                returnVal = mostRecent;                    

        //    }

        //    return returnVal; 
        //}

        private PregnancyChecklistItemList GetChecklistNotes(List<PregnancyDetails> pregList, string currentPregFilter, string dfn)
        {
            PregnancyChecklistItemList returnList = new PregnancyChecklistItemList();

            List<PregnancyDetails> workingList;

            // *** Create a working list of pregnancies that are included ***
            if (currentPregFilter == PregnancyUtilities.PregnancyFilterAll)
                workingList = pregList;
            else
            {
                workingList = new List<PregnancyDetails>();
                foreach (PregnancyDetails preg in pregList)
                    if (preg.Ien == currentPregFilter)
                        workingList.Add(preg);
            }

            // *** Get the checklist items matching pregnancies ***
            foreach (PregnancyDetails workingPreg in workingList)
            {
                PregnancyChecklistItemsResult result = this.DashboardRepository.Checklist.GetPregnancyItems(dfn, workingPreg.Ien, "");

                if (!result.Success)
                    this.Error(result.Message);
                else
                {
                    if (result.Items != null)
                        foreach (PregnancyChecklistItem item in result.Items)
                            if (item.ItemType == DsioChecklistItemType.MccCall)
                            {
                                // *** Add each call to the model ***
                                MccPatientCallType tempCallType;

                                if (Enum.TryParse<MccPatientCallType>(item.Link, out tempCallType))
                                    item.Description = MccPatientCallTypeUtility.GetDescription(tempCallType);

                                returnList.Add(item);
                            }

                    // *** Add the dates needed for due calculation ***
                   returnList.AddPregnancyDates(workingPreg.EDD, workingPreg.EndDate);
                }
            }

            return returnList; 
        }

        [HttpGet]
        public ActionResult Create(string dfn, string callType, string checkIen)
        {
            // *** Create a new note ***

            ActionResult returnResult; 

            // *** Parse the call type ***

            MccPatientCallType ct;

            if (Enum.TryParse<MccPatientCallType>(callType, out ct))
            {
                if (ct == MccPatientCallType.AdditionalCall)
                    returnResult = RedirectToAction("AdditionalCall", new { dfn = dfn, noteIen = "" });
                else
                {
                    // *** Get template details ***
                    MccPatientCallTemplate template = MccPatientCallConfiguration.GetCallTemplate(ct);

                    // *** Get result ***
                    returnResult = this.ProcessNavigation(template, 0, "", checkIen);
                }
            }
            else
                returnResult = RedirectToAction("Index", new { dfn = dfn }); 

            return returnResult; 
        }

        [HttpGet]
        public ActionResult Edit(string dfn, string noteIen, string checkIen)
        {
            ActionResult returnResult; 

            // *** Get Note ***
            TiuNoteResult noteResult = this.DashboardRepository.Notes.GetNoteHeader(dfn, noteIen); 

            if (!noteResult.Success)
            {
                returnResult = RedirectToAction("Index", new { dfn = dfn }); 
                this.Error(noteResult.Message);
            }
            else
            {
                if (noteResult.Note != null)
                {
                    if (noteResult.Note.Title != TiuNoteTitleInfo.GetTitleText(TiuNoteTitle.PhoneCallAdditional))
                    {
                        MccPatientCallTemplate template = MccPatientCallConfiguration.GetCallTemplate(noteResult.Note.Title);

                        // *** Call Process Navigation ***
                        returnResult = this.ProcessNavigation(template, 0, noteIen, checkIen);
                    }
                    else
                        returnResult = RedirectToAction("AdditionalCall", new { dfn = dfn, noteIen = noteIen });

                }
                else
                {
                    returnResult = RedirectToAction("Index", new { dfn = dfn });
                    this.Error("Could not find note");
                }
            }

            return returnResult; 
        }

        //[HttpGet]
        //public ActionResult Sign(string dfn, string noteIen, string checkIen)
        //{
        //    ActionResult returnResult;

        //    TempData[ReturnUrl] = Url.Action("Index", new { dfn = dfn }); 

        //    returnResult = RedirectToAction("Sign", "Notes", new { dfn = dfn, ien = noteIen }); 

        //    return returnResult; 
        //}

        [HttpGet]
        public ActionResult ViewNote(string dfn, string noteIen, string checkIen)
        {
            PatientContactView model = new PatientContactView();

            model.Patient = this.CurrentPatient;

            model.ChecklistIen = checkIen;

            TiuNoteResult headerResult = this.DashboardRepository.Notes.GetNoteHeader(dfn, noteIen);

            if (headerResult.Success)
            {
                if (headerResult.Note != null)
                {
                    model.Note = headerResult.Note;

                    TiuNoteResult result = this.DashboardRepository.Notes.GetNote(noteIen);

                    if (!result.Success)
                        this.Error(result.Message);
                    else
                    {
                        if (result.Note != null)
                            model.Note.NoteText = result.Note.NoteText;

                        // *** Get pregnancies ***
                        List<PregnancyDetails> pregList = PregnancyUtilities.GetPregnancies(this.DashboardRepository, dfn);

                        // *** Get pregnancy description ***
                        if (!string.IsNullOrWhiteSpace(model.Note.PregnancyIen))
                            foreach (PregnancyDetails preg in pregList)
                                if (preg.Ien == model.Note.PregnancyIen)
                                {
                                    model.PregnancyDescription = preg.Description;
                                    if (model.Note.SignatureStatus == TiuNoteSignatureStatus.Completed)
                                        model.GestationalAgeMessage = preg.GetGestationalAgeOn(model.Note.DocumentDateTime);
                                    else
                                        model.GestationalAgeMessage = ""; 
                                }

                        // *** Set default description ***
                        if (string.IsNullOrWhiteSpace(model.PregnancyDescription))
                            model.PregnancyDescription = PregnancyUtilities.NotAssociatedMessage;
                    }
                }
            }

            return View(model);
        }

        [HttpGet]
        public ActionResult AdditionalCall(string dfn, string noteIen, string pregIen)
        {
            AdditionalCallNote model = new AdditionalCallNote();

            model.Patient = this.CurrentPatient;
            model.PregnancyIen = pregIen; 

            if (!model.Patient.NotFound)
            {
                if (!string.IsNullOrWhiteSpace(noteIen))
                {
                    TiuNoteResult noteResult = this.DashboardRepository.Notes.GetNoteHeader(dfn, noteIen);

                    if (!noteResult.Success)
                        this.Error(noteResult.Message);
                    else
                    {
                        model.Note = noteResult.Note;

                        noteResult = this.DashboardRepository.Notes.GetNoteBody(noteIen);

                        if (!noteResult.Success)
                            this.Error(noteResult.Message);
                        else
                            model.Note.NoteText = noteResult.Note.NoteText;
                    }
                }

                // *** Get a list of pregnancies ***
                List<PregnancyDetails> pregList = PregnancyUtilities.GetPregnancies(this.DashboardRepository, dfn);

                // *** Get pregnancy selection dictionary ***
                model.Pregnancies = PregnancyUtilities.GetPregnanciesSelection(pregList, false);

                // *** Default to current pregnancy ***
                if (string.IsNullOrWhiteSpace(noteIen))
                    foreach (PregnancyDetails preg in pregList)
                        if (preg.RecordType == PregnancyRecordType.Current)
                            model.PregnancyIen = preg.Ien;
            }

            return View(model);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult AdditionalCall(AdditionalCallNote model)
        {
            ActionResult returnResult;

            this.CurrentPatientDfn = model.Patient.Dfn;
           
            bool ok = false; 

            if (string.IsNullOrWhiteSpace(model.Note.Ien))
            {
                IenResult ienResult = this.DashboardRepository.Notes.CreateNote(TiuNoteTitle.PhoneCallAdditional, model.Patient.Dfn, model.Note.NoteText, model.Note.Subject, new Dictionary<string, string>(), model.PregnancyIen);
                
                if (ienResult.Success)
                    model.Note.Ien = ienResult.Ien; 
                else 
                    this.Error(ienResult.Message);

                ok = ienResult.Success; 
            }
            else
            {
                BrokerOperationResult result = this.DashboardRepository.Notes.UpdateNote(model.Note.Ien, model.Note.NoteText, model.Note.Subject, new Dictionary<string, string>(), model.Note.PregnancyIen);

                if (!result.Success)
                    this.Error(result.Message); 

                ok = result.Success; 
            }

            if (ok)
            {
                MccPatientCallTemplate temp = new MccPatientCallTemplate(MccPatientCallType.AdditionalCall);

                returnResult = this.ProcessNavigation(temp, 0, model.Note.Ien, ""); //RedirectToAction("Index", "PatientContact", new { dfn = model.Patient.Dfn, pregIen = model.PregnancyIen });
            }
            else
            {
                model.Patient = this.CurrentPatient;

                returnResult = View(model);
            }

            return returnResult; 
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Sign(PatientContactView model)
        {
            ActionResult returnResult; 

            this.CurrentPatientDfn = model.Patient.Dfn;

            BrokerOperationResult result = this.DashboardRepository.Notes.SignNote(model.Note.Ien, model.Esig);

            if (!result.Success)
            {
                this.Error(string.Format("The note could not be signed: {0}", result.Message));
                returnResult = RedirectToAction("ViewNote", new {dfn = model.Patient.Dfn, noteIen = model.Note.Ien, checkIen = model.ChecklistIen}); 
            }
            else
            {
                this.Information("The note has been signed");

                CompleteChecklistItem(model.ChecklistIen, model.Note.Ien, model.Patient.Dfn);
                
                // *** Update Last Contact ***
                result = this.DashboardRepository.Observations.UpdateLastContactDate(model.Patient.Dfn, model.Note.DocumentDateTime);

                if (!result.Success)
                    this.Error("Error updating last contact date: " + result.Message); 

                returnResult = RedirectToAction("Index", new {dfn = model.Patient.Dfn}); 
            }

            return returnResult;
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Delete(PatientContactView model)
        {
            return DeleteNote(model.Patient.Dfn, model.Note.Ien, model.ChecklistIen); 
        }

        private ActionResult DeleteNote(string patientDfn, string noteIen, string checklistIen)
        {
            ActionResult returnResult = null;

            if (string.IsNullOrWhiteSpace(noteIen))
            {
                this.Error("No note to delete");
                returnResult = RedirectToAction("Index", new { dfn = CurrentPatientDfn });
            }
            else
            {
                BrokerOperationResult result = this.DashboardRepository.Notes.DeleteNote(noteIen, "User Request");

                if (!result.Success)
                {
                    this.Error(result.Message);

                    returnResult = RedirectToAction("ViewNote", new { dfn = patientDfn, noteIen = noteIen, checklistIen });
                }
                else
                {
                    this.Information("The note was deleted successfullly");

                    // *** Update Checklist ***
                    UpdateChecklistLink(checklistIen, "", patientDfn);

                    returnResult = RedirectToAction("Index", new { dfn = CurrentPatientDfn });
                }
            }

            return returnResult;
        }

        [HttpGet]
        public ActionResult Intro()
        {
            ActionResult returnResult; 

            IntroductionCallTab model = this.TempData["tabModel"] as IntroductionCallTab;

            if (model != null)
                returnResult = View(model);
            else
                returnResult = RedirectToAction("Overview", "PatientList");

            return returnResult; 
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Intro(IntroductionCallTab model)
        {
            return ProcessPostNavigation(model); 
        }

        [HttpGet]
        public ActionResult Coverage()
        {
            ActionResult returnResult;

            CoverageCallTab model = this.TempData["tabModel"] as CoverageCallTab;

            if (model != null)
            {
                // *** Get NonVA Care list ***
                NonVACareItemsResult result = this.DashboardRepository.NonVACare.GetAll(1, 1000);

                if (result.Success)
                {
                    // *** Create lists for selection ***

                    List<NonVACareItem> ObList = new List<NonVACareItem>();
                    List<NonVACareItem> FacilityList = new List<NonVACareItem>();

                    foreach (NonVACareItem item in result.Items)
                        if (item.ItemType == NonVACareItemType.Facility)
                            FacilityList.Add(item);
                        else
                            ObList.Add(item); 

                    SelectList obSelectList = new SelectList(ObList, "Ien", "Name", "");
                    SelectList facSelectList = new SelectList(FacilityList, "Ien", "Name", "");

                    this.ViewData["obList"] = obSelectList;
                    this.ViewData["facList"] = facSelectList;                    
                }

                returnResult = View(model);
            }
            else
                returnResult = RedirectToAction("Overview", "PatientList");

            return returnResult;
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Coverage(CoverageCallTab model)
        {
            return ProcessPostNavigation(model);
        }

        [HttpGet]
        public ActionResult Health()
        {
            ActionResult returnResult;

            HealthCallTab model = this.TempData["tabModel"] as HealthCallTab;

            if (model != null)
                returnResult = View(model);
            else
                returnResult = RedirectToAction("Overview", "PatientList");

            return returnResult;
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Health(HealthCallTab model)
        {
            return ProcessPostNavigation(model);
        }

        [HttpGet]
        public ActionResult Smoking()
        {
            ActionResult returnResult;

            SmokingCallTab model = this.TempData["tabModel"] as SmokingCallTab;

            if (model != null)
                returnResult = View(model);
            else
                returnResult = RedirectToAction("Overview", "PatientList");

            return returnResult;
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Smoking(SmokingCallTab model)
        {
            return ProcessPostNavigation(model);
        }

        [HttpGet]
        public ActionResult Alcohol()
        {
            ActionResult returnResult;

            AlcoholCallTab model = this.TempData["tabModel"] as AlcoholCallTab;

            if (model != null)
                returnResult = View(model);
            else
                returnResult = RedirectToAction("Overview", "PatientList");

            return returnResult;
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Alcohol(AlcoholCallTab model)
        {
            return ProcessPostNavigation(model);
        }

        [HttpGet]
        public ActionResult Depression()
        {
            ActionResult returnResult;

            DepressionCallTab model = this.TempData["tabModel"] as DepressionCallTab;

            if (model != null)
                returnResult = View(model);
            else
                returnResult = RedirectToAction("Overview", "PatientList");

            return returnResult;
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Depression(DepressionCallTab model)
        {
            return ProcessPostNavigation(model);
        }

        [HttpGet]
        public ActionResult IPV()
        {
            ActionResult returnResult;

            IpvCallTab model = this.TempData["tabModel"] as IpvCallTab;

            if (model != null)
                returnResult = View(model);
            else
                returnResult = RedirectToAction("Overview", "PatientList");

            return returnResult;
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult IPV(IpvCallTab model)
        {
            return ProcessPostNavigation(model);
        }

        [HttpGet]
        public ActionResult Classes()
        {
            ActionResult returnResult;

            ClassesCallTab model = this.TempData["tabModel"] as ClassesCallTab;

            if (model != null)
                returnResult = View(model);
            else
                returnResult = RedirectToAction("Overview", "PatientList");

            return returnResult;
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Classes(ClassesCallTab model)
        {
            return ProcessPostNavigation(model);
        }

        [HttpGet]
        public ActionResult Breastfeeding()
        {
            ActionResult returnResult;

            BreastfeedingCallTab model = this.TempData["tabModel"] as BreastfeedingCallTab;

            if (model != null)
                returnResult = View(model);
            else
                returnResult = RedirectToAction("Overview", "PatientList");

            return returnResult;
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Breastfeeding(BreastfeedingCallTab model)
        {
            return ProcessPostNavigation(model);
        }

        [HttpGet]
        public ActionResult WIC()
        {
            ActionResult returnResult;

            WicCallTab model = this.TempData["tabModel"] as WicCallTab;

            if (model != null)
                returnResult = View(model);
            else
                returnResult = RedirectToAction("Overview", "PatientList");

            return returnResult;
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult WIC(WicCallTab model)
        {
            return ProcessPostNavigation(model);
        }

        [HttpGet]
        public ActionResult Contraception()
        {
            ActionResult returnResult;

            ContraceptionCallTab model = this.TempData["tabModel"] as ContraceptionCallTab;

            if (model != null)
                returnResult = View(model);
            else
                returnResult = RedirectToAction("Overview", "PatientList");

            return returnResult;
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Contraception(ContraceptionCallTab model)
        {
            return ProcessPostNavigation(model);
        }

        [HttpGet]
        public ActionResult PostpartumVisit()
        {
            ActionResult returnResult;

            PostpartumVisitCallTab model = this.TempData["tabModel"] as PostpartumVisitCallTab;

            if (model != null)
                returnResult = View(model);
            else
                returnResult = RedirectToAction("Overview", "PatientList");

            return returnResult;
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult PostpartumVisit(PostpartumVisitCallTab model)
        {
            return ProcessPostNavigation(model);
        }

        [HttpGet]
        public ActionResult VaPcp()
        {
            ActionResult returnResult;

            VaPcpCallTab model = this.TempData["tabModel"] as VaPcpCallTab;

            if (model != null)
                returnResult = View(model);
            else
                returnResult = RedirectToAction("Overview", "PatientList");

            return returnResult;
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult VaPcp(VaPcpCallTab model)
        {
            return ProcessPostNavigation(model);
        }

        [HttpGet]
        public ActionResult End()
        {
            ActionResult returnResult;

            EndCallTab model = this.TempData["tabModel"] as EndCallTab;

            if (model != null)
                returnResult = View(model);
            else
                returnResult = RedirectToAction("Overview", "PatientList");

            return returnResult;
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult End(EndCallTab model)
        {
            return ProcessPostNavigation(model);
        }

        //[HttpGet]
        //public ActionResult ContactNote(string dfn, string ien)
        //{
        //    PatientContactNoteModel model = new PatientContactNoteModel();

        //    // *** Get patient demographics ***
        //    model.Patient = this.CurrentPatient;

        //    // *** Check for success ***
        //    if (!model.Patient.NotFound)
        //    {                
        //        //TiuNoteResult noteResult = this.DashboardRepository.Notes.GetProgressNote(ien);
        //        TiuNoteResult noteResult = this.DashboardRepository.Notes.GetNote(ien);

        //        if (noteResult.Success)
        //        {
        //            model.ContactItem = new PatientContactItem();
        //            model.ContactItem.ProgressNoteText = noteResult.Note.NoteText;
        //        }
        //    }

        //    model.ReturnUrl = Url.Action("Index",new {id=dfn});

        //    return View(model);
        //}

        private ActionResult ProcessPostNavigation(CallTabBase model)
        {
            ActionResult returnResult = null;

            if (model.DeleteNote)
                returnResult = DeleteNote(model.Patient.Dfn, model.NoteIen, model.ChecklistIen);
            else
            {
                bool okToContinue = false;

                // *** Get call template ***
                MccPatientCallTemplate template = MccPatientCallConfiguration.GetCallTemplate(model.CallType);

                // *** Create the note generator ***
                CallNoteGenerator generator = new CallNoteGenerator();

                // *** Add the tabs to the generator ***
                foreach (MccPatientCallTab callTab in template.TabList)
                {
                    // *** Get a tab ***
                    CallTabBase tempTabModel = CallTabModelFactory.CreateNewCallTab(callTab);

                    // *** Add it to generator ***
                    generator.CallTabs.Add(tempTabModel);
                }

                // *** Absence of Ien means this is a new note ***
                if (!string.IsNullOrWhiteSpace(model.NoteIen))
                {
                    // *** Get existing note ***
                    TiuNoteResult existingResult = this.DashboardRepository.Notes.GetNoteWithData(model.NoteIen);

                    // *** Check if ok ***
                    okToContinue = existingResult.Success;

                    // *** Add data to generator if ok ***
                    if (!okToContinue)
                        this.Error(existingResult.Message);
                    else
                        generator.AddDataToTabs(existingResult.Note.NoteData);
                }
                else
                    okToContinue = true;

                if (okToContinue)
                {
                    // *** Save ob/l&d ***
                    if (template.TabList[model.TabIndex] == MccPatientCallTab.VACoverage)
                        okToContinue = ProcessNonVA(model);

                    if (okToContinue)
                    {
                        // *** Add new model data to generator ***
                        generator.AddDataToTabs(model.GetTabDataElements());

                        // *** Get the note text from the generator ***
                        string noteText = generator.GetNoteText();

                        // *** Get all the data ***
                        Dictionary<string, string> newData = generator.GetAllDataFromTabs();

                        // *** Determine if new or not ***
                        if (string.IsNullOrWhiteSpace(model.NoteIen))
                        {
                            // *** If new, create a new note ***
                            IenResult createResult = this.DashboardRepository.Notes.CreateNote(template.NoteTitle, model.Patient.Dfn, noteText, "", newData, model.PregnancyIen);

                            // *** Check result ***
                            okToContinue = createResult.Success;

                            // *** Set note ien if ok ***
                            if (okToContinue)
                                model.NoteIen = createResult.Ien;
                            else
                                this.Error(createResult.Message);
                        }
                        else
                        {
                            // *** If not new, update the note ***
                            BrokerOperationResult updateResult = this.DashboardRepository.Notes.UpdateNote(model.NoteIen, noteText, "", newData, model.PregnancyIen);

                            // *** Check result ***
                            okToContinue = updateResult.Success;

                            if (!okToContinue)
                                this.Error(updateResult.Message);
                        }
                    }
                }

                // *** Set patient ***
                this.CurrentPatientDfn = model.Patient.Dfn;

                // *** Update checklist, if we have one ***
                if (okToContinue)
                    if (!string.IsNullOrWhiteSpace(model.ChecklistIen))
                        UpdateChecklistLink(model.ChecklistIen, model.NoteIen, model.Patient.Dfn);

                // *** Get action result ***
                if (okToContinue)
                    returnResult = ProcessNavigation(template, model.NavigateToTab, model.NoteIen, model.ChecklistIen);
                else
                    returnResult = ProcessNavigation(template, model.TabIndex, model.NoteIen, model.ChecklistIen);
            }

            return returnResult;
        }

        private void UpdateChecklistLink(string checklistIen, string noteIen, string patientDfn)
        {
            PregnancyChecklistItemsResult getResult = this.DashboardRepository.Checklist.GetPregnancyItems(patientDfn, "", checklistIen); 

            if (getResult.Success) 
            {
                if (getResult.Items != null) 
                    if (getResult.Items.Count == 1) 
                    {
                        PregnancyChecklistItem item = getResult.Items[0]; 

                        item.CompletionLink = noteIen;

                        if (string.IsNullOrWhiteSpace(noteIen))
                            item.InProgress = false; 
                        else 
                            item.InProgress = true;

                        IenResult saveResult = this.DashboardRepository.Checklist.SavePregnancyItem(item);

                        if (!saveResult.Success)
                            this.Error(string.Format("Could not update checklist item: {0}", saveResult.Message));

                    }
            }
            else
                this.Error(string.Format("Could not find checklist item to update: {0}", getResult.Message));            
        }

        private void CompleteChecklistItem(string checklistIen, string noteIen, string patientDfn)
        {
            // *** Complete the checklist item for a note ***

            // *** If we don't have a checklist item, find one ***
            if (string.IsNullOrWhiteSpace(checklistIen)) 
                checklistIen = FindMatchingChecklistItem(patientDfn, noteIen); 
             
            // *** Get the item ***
            PregnancyChecklistItemsResult getResult = this.DashboardRepository.Checklist.GetPregnancyItems(patientDfn, "", checklistIen);

            // *** Check result ***
            if (getResult.Success)
                if (getResult.Items != null)
                    if (getResult.Items.Count == 1)
                    {
                        // *** Get the item ***
                        PregnancyChecklistItem item = getResult.Items[0];

                        // *** Modify it ***

                        item.CompletionLink = noteIen;

                        item.InProgress = false;

                        item.CompletionStatus = DsioChecklistCompletionStatus.Complete;

                        // *** Save it ***

                        IenResult saveResult = this.DashboardRepository.Checklist.SavePregnancyItem(item);

                        // *** Check it ***

                        if (!saveResult.Success)
                            this.Error(string.Format("Could not update checklist item: {0}", saveResult.Message));
                        else
                        {
                            // *** Update the next checklist date ***
                            BrokerOperationResult updResult = ChecklistUtility.UpdateNextDates(this.DashboardRepository, patientDfn, item.PregnancyIen);

                            if (!updResult.Success)
                                this.Error("Error updating next dates: " + updResult.Message);
                        }   
                    }

        }

        private string FindMatchingChecklistItem(string patientDfn, string noteIen)
        {
            // *** Try to find a checklist item that matches note ***

            string returnVal = "";

            // *** Get the note ***
            TiuNoteResult noteResult = this.DashboardRepository.Notes.GetNoteHeader(patientDfn, noteIen); 

            if (noteResult.Success)
            {
                // *** Get the call type ***
                if (noteResult.Note != null)
                {
                    TiuNoteTitle noteTitle = TiuNoteTitleInfo.GetTitle(noteResult.Note.Title);
                    if (MccPatientCallTypeUtility.IsCall(noteTitle)) 
                    {
                    MccPatientCallType callType = MccPatientCallTypeUtility.GetCallType(noteTitle); 

                    // *** Get pregnancy ***
                    PregnancyResult pregResult = this.DashboardRepository.Pregnancy.GetCurrentOrMostRecentPregnancy(patientDfn);

                    if (pregResult.Success)
                        if (pregResult.Pregnancy != null)
                        {
                            // *** Get current checklist items ***
                            PregnancyChecklistItemsResult chkResult = this.DashboardRepository.Checklist.GetPregnancyItems(patientDfn, pregResult.Pregnancy.Ien, "");

                            if (chkResult.Success)
                                if (chkResult.Items != null)
                                {
                                    // *** See if any match ***
                                    foreach (PregnancyChecklistItem item in chkResult.Items)
                                        if (item.ItemType == DsioChecklistItemType.MccCall) 
                                            if (item.CompletionStatus == DsioChecklistCompletionStatus.NotComplete )
                                                if (string.IsNullOrWhiteSpace(item.CompletionLink))
                                                    if (!string.IsNullOrWhiteSpace(item.Link))
                                                    {
                                                        MccPatientCallType tempCallType;

                                                        if (Enum.TryParse<MccPatientCallType>(item.Link, out tempCallType))
                                                            if (tempCallType == callType)
                                                                returnVal = item.Ien;
                                                    }
                                }
                        }
                    }
                }
            }

            return returnVal;
        }

        private ActionResult ProcessNavigation(MccPatientCallTemplate template, int index, string noteIen, string checklistIen)
        {
            ActionResult returnResult = null;

            // *** Get tab type ***
            Nullable<MccPatientCallTab> tab = GetTab(template, index);

            if (tab.HasValue)
            {
                // *** Get the appropriate model for this tab **
                CallTabBase tempModel = this.GetNewTabModel(template, index);

                List<PregnancyDetails> pregList = new List<PregnancyDetails>(); 

                // *** Populate model if data exists ***
                if (!string.IsNullOrWhiteSpace(noteIen))
                {
                    tempModel.NoteIen = noteIen;
                    
                    tempModel = this.AddNoteData(tempModel);

                    tempModel.PregnancyIen = this.GetPregnancyIen(noteIen);

                    tempModel.ChecklistIen = checklistIen; 

                    // *** Load ob/l&d from current pregnancy ***
                    if (tab == MccPatientCallTab.VACoverage)
                        LoadNonVA(tempModel);
                }
                else if (!string.IsNullOrWhiteSpace(checklistIen))
                {
                    // *** Add checklist ien ***
                    tempModel.ChecklistIen = checklistIen;

                    // *** Get preg belonging to checklist ***
                    PregnancyChecklistItemResult checkResult = this.DashboardRepository.Checklist.GetPregnancyItem(this.CurrentPatientDfn, checklistIen);

                    if (checkResult.Success)
                        tempModel.PregnancyIen = checkResult.Item.PregnancyIen;
                }

                if (!string.IsNullOrWhiteSpace(tempModel.PregnancyIen))
                {
                    // *** Get the pregnancy associated with the note ***
                    PregnancyDetails pregDetail = PregnancyUtilities.GetPregnancy(this.DashboardRepository, this.CurrentPatientDfn, tempModel.PregnancyIen);

                    if (pregDetail != null)
                        pregList.Add(pregDetail);
                }
                else  // *** Get a list of pregnancies ***
                    pregList = PregnancyUtilities.GetPregnancies(this.DashboardRepository, this.CurrentPatientDfn);

                // *** Get pregnancy selection dictionary ***
                tempModel.Pregnancies = PregnancyUtilities.GetPregnanciesSelection(pregList, false);
                
                // *** Default to current pregnancy if we don't have one already ***
                if (string.IsNullOrWhiteSpace(tempModel.PregnancyIen))
                    if (string.IsNullOrWhiteSpace(noteIen))
                        foreach (PregnancyDetails preg in pregList)
                            if (preg.RecordType == PregnancyRecordType.Current)
                                tempModel.PregnancyIen = preg.Ien;

                // *** Temporarily place in TempData ***
                this.TempData["tabModel"] = tempModel;

                // *** Redirect to tab action ***
                returnResult = RedirectToAction(tempModel.CurrentTab.ViewName);
            }
            else if (index == template.TabList.Count)
            {
                //if (template.CallType == MccPatientCallType.AdditionalCall)
                //    returnResult = RedirectToAction("AdditionalCall", new { dfn = this.CurrentPatientDfn, noteIen = noteIen, checkIen = checklistIen });
                //else 
                    returnResult = RedirectToAction("ViewNote", new { dfn = this.CurrentPatientDfn, noteIen = noteIen, checkIen = checklistIen });
            }

            ModelState.Clear();

            return returnResult;
        }

        private string GetPregnancyIen(string noteIen)
        {
            string pregIen = "";

            TiuNoteResult noteResult = this.DashboardRepository.Notes.GetNoteHeader(this.CurrentPatientDfn, noteIen);

            if (noteResult.Success)
                if (noteResult.Note != null)
                    pregIen = noteResult.Note.PregnancyIen; 

            return pregIen; 
        }

        private Nullable<MccPatientCallTab> GetTab(MccPatientCallTemplate template, int index)
        {
            // *** Get the tab using the index and template ***

            Nullable<MccPatientCallTab> returnVal = null;

            if (template != null)
                if (template.TabList != null)
                    if (template.TabList.Count > 0)
                        if (index >= 0)
                            if (index < template.TabList.Count)
                                returnVal = template.TabList[index];

            return returnVal;
        }

        private CallTabBase GetNewTabModel(MccPatientCallTemplate template, int index)
        {
            // *** Create a new tab model based on template and index ***

            CallTabBase returnModel = null;

            if (template != null)
                if (template.TabList != null)
                    if (template.TabList.Count > 0)
                        if (index >= 0)
                            if (index < template.TabList.Count)
                            {
                                MccPatientCallTab tabType = template.TabList[index];

                                // *** Use factory to get appropriate type ***
                                returnModel = CallTabModelFactory.CreateNewCallTab(tabType); 

                                // *** Populate common data ***
                                returnModel.Patient = this.CurrentPatient;
                                returnModel.CallTemplateName = template.Name;
                                returnModel.CallType = template.CallType;
                                returnModel.TabIndex = index;
                                returnModel.TabCount = template.TabList.Count;
                                returnModel.CurrentTab = new CallTab(tabType);

                                returnModel.TabList = new List<CallTab>(); 

                                // *** Add the list of tabs to the model ***
                                foreach (MccPatientCallTab tempTab in template.TabList) 
                                    returnModel.TabList.Add(new CallTab(tempTab));
                            }

            return returnModel;
        }

        private TiuNote GetTiuNote(string noteIen)
        {
            TiuNote returnVal = null;

            if (!string.IsNullOrWhiteSpace(noteIen))
            {
                TiuNoteResult result = this.DashboardRepository.Notes.GetNoteWithData(noteIen);

                if (result.Success)
                    if (result.Note != null)
                        returnVal = result.Note;
            }

            return returnVal; 
        }

        private CallTabBase AddNoteData(CallTabBase model, TiuNote note)
        {
            CallTabBase returnModel = model as CallTabBase;

            if (note != null)
                if (note.NoteData != null)
                    if (note.NoteData.Count > 0)
                        model.AddData(note.NoteData);

            return returnModel; 
        }
        
        private CallTabBase AddNoteData(CallTabBase model)
        {
            CallTabBase returnModel = model as CallTabBase;

            if (!string.IsNullOrWhiteSpace(model.NoteIen))
            {
                TiuNoteResult result = this.DashboardRepository.Notes.GetNoteWithData(model.NoteIen);

                if (result.Success)
                    if (result.Note != null)
                        if (result.Note.NoteData != null)
                            if (result.Note.NoteData.Count > 0)
                                model.AddData(result.Note.NoteData);
            }

            return returnModel; 
        }

        private bool ProcessNonVA(CallTabBase model)
        {
            // *** The Non-VA OB,L&D require special processing ***

            bool okToContinue = true; 

            CoverageCallTab covTab = model as CoverageCallTab;

            // *** Process OB ***
            okToContinue = ProcessOb(covTab);

            // *** Process Hospital ***
            if (okToContinue)
                ProcessHospital(covTab);

            return okToContinue; 
        }

        private bool ProcessOb(CoverageCallTab covTab)
        {
            // *** Save New OB, Get Existing OB Name, Save to current pregnancy ***

            bool okToContinue = true; 

            string exObIen = "";
            string exObName = ""; 

            if (covTab.LocatedOB.HasValue)
                if (covTab.LocatedOB.Value)
                    if (covTab.CreateNewOb.HasValue)
                    {
                        if (covTab.CreateNewOb.Value)
                        {
                            if (!string.IsNullOrWhiteSpace(covTab.NewOb.Name))
                            {
                                // *** Creating New ***
                                IenResult obResult = this.DashboardRepository.NonVACare.SaveItem(covTab.NewOb);

                                if (obResult.Success)
                                {
                                    exObIen = obResult.Ien;
                                    exObName = covTab.NewOb.Name;
                                }
                                else
                                    this.Error(obResult.Message);

                                okToContinue = obResult.Success;
                            }
                        }
                        else
                        {
                            // *** Selecting Existing ***
                            NonVACareItemsResult getResult = this.DashboardRepository.NonVACare.GetItem(covTab.ExistingObIen);

                            if (getResult.Success)
                            {
                                exObIen = getResult.Items[0].Ien;
                                exObName = getResult.Items[0].Name;
                            }
                            else
                                this.Error(getResult.Message);

                            okToContinue = getResult.Success;
                        }

                        if (okToContinue)
                        {
                            // *** Save to current pregnancy ***
                            // PregnancyResult pregResult = this.DashboardRepository.Pregnancy.GetCurrentPregnancy(covTab.Patient.Dfn);
                            PregnancyListResult pregResult = this.DashboardRepository.Pregnancy.GetPregnancies(covTab.Patient.Dfn, covTab.PregnancyIen);

                            if (pregResult.Success)
                                if (pregResult.Pregnancies != null)
                                    if (pregResult.Pregnancies.Count == 1)
                                    {
                                        PregnancyDetails tempPreg = pregResult.Pregnancies[0];

                                        tempPreg.ObstetricianIen = exObIen;

                                        BrokerOperationResult opResult = this.DashboardRepository.Pregnancy.SavePregnancy(tempPreg);

                                        if (!opResult.Success)
                                        {
                                            okToContinue = false;
                                            this.Error(opResult.Message);
                                        }
                                    }
                        }
                    }


            // *** Make sure these are blank unless valid/saved selection
            covTab.ExistingObIen = exObIen;
            covTab.ExistingObName = exObName; 

            return okToContinue; 
        }

        private bool ProcessHospital(CoverageCallTab covTab)
        {
            // *** Save new hospital, get existing hospital name, update current pregnancy ***

            bool okToContinue = true;

            string exHospIen = "";
            string exHospName = "";

            if (covTab.LocatedHospital.HasValue)
                if (covTab.LocatedHospital.Value)
                    if (covTab.CreateNewHospital.HasValue)
                    {
                        if (covTab.CreateNewHospital.Value)
                        {
                            if (!string.IsNullOrWhiteSpace(covTab.NewHospital.Name))
                            {
                                // *** Creating New ***
                                IenResult saveResult = this.DashboardRepository.NonVACare.SaveItem(covTab.NewHospital);

                                if (saveResult.Success)
                                {
                                    exHospIen = saveResult.Ien;
                                    exHospName = covTab.NewHospital.Name;
                                }
                                else
                                    this.Error(saveResult.Message);

                                okToContinue = saveResult.Success;
                            }
                        }
                        else
                        {
                            // *** Selecting Existing ***
                            NonVACareItemsResult getResult = this.DashboardRepository.NonVACare.GetItem(covTab.ExistingHospitalIen);

                            if (getResult.Success)
                            {
                                exHospIen = getResult.Items[0].Ien;
                                exHospName = getResult.Items[0].Name;
                            }
                            else
                                this.Error(getResult.Message);

                            okToContinue = getResult.Success;
                        }

                        if (okToContinue)
                        {
                            // *** Save to current pregnancy ***
                            //PregnancyResult pregResult = this.DashboardRepository.Pregnancy.GetCurrentPregnancy(covTab.Patient.Dfn);

                            PregnancyListResult pregResult = this.DashboardRepository.Pregnancy.GetPregnancies(covTab.Patient.Dfn, covTab.PregnancyIen);

                            if (pregResult.Success)
                                if (pregResult.Pregnancies != null)
                                    if (pregResult.Pregnancies.Count == 1)
                                    {
                                        PregnancyDetails tempPreg = pregResult.Pregnancies[0];

                                        tempPreg.PlannedLaborDeliveryFacilityIen = exHospIen;

                                        BrokerOperationResult opResult = this.DashboardRepository.Pregnancy.SavePregnancy(tempPreg);

                                        if (!opResult.Success)
                                        {
                                            okToContinue = false;
                                            this.Error(opResult.Message);
                                        }
                                    }

                        }
                    }

            // *** Make sure these are blank unless valid/saved selection
            covTab.ExistingHospitalIen = exHospIen;
            covTab.ExistingHospitalName = exHospName;

            return okToContinue;
        }

        private void LoadNonVA(CallTabBase model)
        {
            // *** Load existing OB, L&D from current pregnancy ***

            CoverageCallTab coverageTab = (CoverageCallTab)model;

            //PregnancyResult pregResult = this.DashboardRepository.Pregnancy.GetCurrentPregnancy(coverageTab.Patient.Dfn);

            //if (pregResult.Success)
            //    if (pregResult.Pregnancy != null)
            //    {
            PregnancyListResult pregResult = this.DashboardRepository.Pregnancy.GetPregnancies(model.Patient.Dfn, model.PregnancyIen);

            if (pregResult.Success)
                if (pregResult.Pregnancies != null)
                    if (pregResult.Pregnancies.Count == 1)
                    {
                        PregnancyDetails tempPreg = pregResult.Pregnancies[0];

                        if (!string.IsNullOrWhiteSpace(tempPreg.ObstetricianIen))
                    {
                        // ** Set data and radios properly ***
                        coverageTab.ExistingObIen = tempPreg.ObstetricianIen;
                        coverageTab.ExistingObName = tempPreg.Obstetrician;
                        coverageTab.LocatedOB = true;
                        coverageTab.CreateNewOb = false; 
                    }

                        if (!string.IsNullOrWhiteSpace(tempPreg.PlannedLaborDeliveryFacilityIen))
                    {
                        // *** Set data and radios properly ***
                        coverageTab.ExistingHospitalIen = tempPreg.PlannedLaborDeliveryFacilityIen;
                        coverageTab.ExistingHospitalName = tempPreg.PlannedLaborDeliveryFacilityIen;
                        coverageTab.LocatedHospital = true;
                        coverageTab.CreateNewHospital = false; 
                    }
                }
        }

    }
}
