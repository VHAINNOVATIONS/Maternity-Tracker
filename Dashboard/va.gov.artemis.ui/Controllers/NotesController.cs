using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using VA.Gov.Artemis.UI.Data.Brokers.Common;
using VA.Gov.Artemis.UI.Data.Brokers.Notes;
using VA.Gov.Artemis.UI.Data.Brokers.Pregnancy;
using VA.Gov.Artemis.UI.Data.Models;
using VA.Gov.Artemis.UI.Data.Models.Notes;
using VA.Gov.Artemis.UI.Data.Models.Patient;
using VA.Gov.Artemis.UI.Data.Models.Pregnancy;
using VA.Gov.Artemis.UI.Filters;

namespace VA.Gov.Artemis.UI.Controllers
{
    [DisableLocalCache]
    [VerifySession]
    [Authorize]
    public class NotesController : DashboardController
    {
        private const int ItemsPerPage = 10;
        
        [HttpGet]
        public ActionResult Index(string dfn, string filter, string page)
        {
            // *** Show list of dashboard notes by patient

            NoteListModel model = new NoteListModel();

            model.Patient = this.CurrentPatient;

            int pageVal = this.GetPage(page); 

            if (!model.Patient.NotFound)
            {
                // *** Set up the pregnancy list filter ***

                // *** Get the pregnancies ***
                List<PregnancyDetails> pregList = PregnancyUtilities.GetPregnancies(this.DashboardRepository, dfn);

                // *** Get the selection ***
                model.PregnancyFilters = PregnancyUtilities.GetPregnanciesSelection(pregList, true);

                // *** Get valid filter ***
                model.CurrentPregnancyFilter = PregnancyUtilities.GetValidatedPregnancyFilter(pregList, filter);

                // *** Set up pregIen for repo ***
                string pregIen = ""; 
                int tempIen = -1;
                if (int.TryParse(model.CurrentPregnancyFilter, out tempIen))
                    pregIen = model.CurrentPregnancyFilter;
                
                // *** Build a list of titles ***
                List<TiuNoteTitle> titlesToInclude = new List<TiuNoteTitle>();
                foreach (object val in Enum.GetValues(typeof(TiuNoteTitle)))
                    titlesToInclude.Add((TiuNoteTitle)val); 

                NoteListResult notesResult = this.DashboardRepository.Notes.GetNotesByTitle(titlesToInclude, dfn, pageVal, ItemsPerPage, pregIen);

                if (!notesResult.Success)
                    this.Error(notesResult.Message);
                else
                {
                    model.ProgressNotes = notesResult.Notes; 

                    model.ProgressNotePaging.SetPagingData(ItemsPerPage, pageVal, notesResult.TotalResults); 

                    model.ProgressNotePaging.BaseUrl = Url.Action("Index", new { dfn = dfn, filter = model.CurrentPregnancyFilter, page = "" });

                    TempData[ReturnUrl] = Url.Action("Index", new { dfn = dfn, filter = model.CurrentPregnancyFilter, page = pageVal });
                }

                model.DetailAction = "Details"; 
            }                   

            return View(model);
        }

        [HttpGet]
        public ActionResult Details(string dfn, string ien)
        {
            // *** Show details of a dashboard note ***
                        
            TiuNoteModel model = new TiuNoteModel();

            model.Patient = this.CurrentPatient;

            if (!model.Patient.NotFound)
            {
                TiuNoteResult headerResult = this.DashboardRepository.Notes.GetNoteHeader(dfn, ien);

                if (headerResult.Success)
                {
                    if (headerResult.Note == null)
                        this.Error("Could not retrieve note data");
                    else
                    {
                        model.Note = headerResult.Note;

                        TiuNoteResult noteResult = this.DashboardRepository.Notes.GetNote(ien);

                        if (!noteResult.Success)
                            this.Error(noteResult.Message);
                        else
                            model.Note.NoteText = noteResult.Note.NoteText;
                    }
                }
                else
                    this.Error(headerResult.Message); 
            }

            // *** Get pregnancies ***
            List<PregnancyDetails> pregList = PregnancyUtilities.GetPregnancies(this.DashboardRepository, dfn);

            // *** Get pregnancy description ***
            if (!string.IsNullOrWhiteSpace(model.Note.PregnancyIen))
                foreach (PregnancyDetails preg in pregList)
                    if (preg.Ien == model.Note.PregnancyIen)
                        model.PregnancyDescription = preg.Description; 

            // *** Set default description ***
            if (string.IsNullOrWhiteSpace(model.PregnancyDescription))
                model.PregnancyDescription = PregnancyUtilities.NotAssociatedMessage; 

            // *** Set return url ***
            if (TempData.ContainsKey(ReturnUrl))
            {
                model.ReturnUrl = TempData[ReturnUrl].ToString();
                TempData[ReturnUrl] = TempData[ReturnUrl];
            }

            return View(model);
        }

        [HttpGet]
        public ActionResult CreateNote(string dfn)
        {
            // *** Create a new dashboard note ***

            TiuNoteModel model = new TiuNoteModel();

            model.Patient = this.CurrentPatient;

            // *** Get a list of pregnancies ***
            List<PregnancyDetails> pregList = PregnancyUtilities.GetPregnancies(this.DashboardRepository , dfn);

            // *** Get pregnancy selection dictionary ***
            model.Pregnancies = PregnancyUtilities.GetPregnanciesSelection(pregList, false);

            // *** Default to current pregnancy ***
            foreach (PregnancyDetails preg in pregList)
                if (preg.RecordType == PregnancyRecordType.Current)
                    model.Note.PregnancyIen = preg.Ien; 

            // *** Set return url ***
            if (TempData.ContainsKey(ReturnUrl))
            {
                model.ReturnUrl = TempData[ReturnUrl].ToString();
                TempData[ReturnUrl] = TempData[ReturnUrl];
            }

            return View(model);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult CreateNote(TiuNoteModel model)
        {
            // *** Post data ***

            ActionResult returnResult;

            bool needPatDemo = false; 

            if (ModelState.IsValid)
            {
                BrokerOperationResult result = this.DashboardRepository.Notes.CreateNote(TiuNoteTitle.MccDashboardNote, model.Patient.Dfn, model.Note.NoteText, model.Note.Subject, new Dictionary<string, string>(), model.Note.PregnancyIen);

                if (!result.Success)
                {
                    this.Error(result.Message);

                    returnResult = View(model);

                    needPatDemo = true; 
                }
                else
                {
                    this.Information("Dashboard Note Created");
                    returnResult = RedirectToAction("Index", new { dfn = model.Patient.Dfn, filter = model.Note.PregnancyIen, page = "1"});
                    needPatDemo = false; 
                }
            }
            else
            {
                this.Error("Please enter note details"); 
                returnResult = View(model);
                needPatDemo = true; 
            }

            // *** Get patient demographics ***
            if (needPatDemo)
            {
                this.CurrentPatientDfn = model.Patient.Dfn;
                model.Patient = this.CurrentPatient;
            }

            // *** Set return url ***
            if (TempData.ContainsKey(ReturnUrl))
            {
                model.ReturnUrl = TempData[ReturnUrl].ToString();
                TempData[ReturnUrl] = TempData[ReturnUrl];
            }

            return returnResult;
        }

        [HttpGet]
        public ActionResult Edit(string dfn, string ien)
        {
            // *** Create a new dashboard note ***

            TiuNoteModel model = new TiuNoteModel();

            model.Patient = this.CurrentPatient;

            if (!model.Patient.NotFound)
            {
                TiuNoteResult headerResult = this.DashboardRepository.Notes.GetNoteHeader(dfn, ien);

                if (headerResult.Success)
                {
                    model.Note = headerResult.Note;
                    TiuNoteResult noteResult = this.DashboardRepository.Notes.GetNoteBody(ien);

                    if (!noteResult.Success)
                        this.Error(noteResult.Message);
                    else
                        model.Note.NoteText = noteResult.Note.NoteText;
                }
                else
                    this.Error(headerResult.Message);
            }

            // *** Get pregnancies ***
            model.Pregnancies = PregnancyUtilities.GetPregnanciesSelection(this.DashboardRepository, dfn); 

            // *** Set return url ***
            if (TempData.ContainsKey(ReturnUrl))
            {
                model.ReturnUrl = TempData[ReturnUrl].ToString();
                TempData[ReturnUrl] = TempData[ReturnUrl];
            }

            return View("CreateNote", model);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(TiuNoteModel model)
        {
            // *** Post data ***

            ActionResult returnResult;

            bool needPatDemo = false;

            if (ModelState.IsValid)
            {
                BrokerOperationResult result = this.DashboardRepository.Notes.UpdateNote(model.Note.Ien, model.Note.NoteText, model.Note.Subject, new Dictionary<string, string>(), model.Note.PregnancyIen);

                if (!result.Success)
                {
                    this.Error(result.Message);

                    returnResult = View("CreateNote", model);

                    needPatDemo = true;
                }
                else
                {
                    this.Information("Dashboard Note Updated");
                    if (TempData.ContainsKey(ReturnUrl))
                        returnResult = Redirect(TempData.Peek(ReturnUrl).ToString());
                    else
                        returnResult = RedirectToAction("Index", new { dfn = model.Patient.Dfn, filter = model.Note.PregnancyIen, page = "1" });

                    needPatDemo = false;
                }
            }
            else
            {
                this.Error("Please enter note details");
                returnResult = View("CreateNote", model);
                needPatDemo = true;
            }

            if (needPatDemo)
            {
                this.CurrentPatientDfn = model.Patient.Dfn; 
                model.Patient = this.CurrentPatient;
            }

            // *** Set return url ***
            if (TempData.ContainsKey(ReturnUrl))
            {
                model.ReturnUrl = TempData[ReturnUrl].ToString();
                TempData[ReturnUrl] = TempData[ReturnUrl];
            }

            return returnResult;
        }

        [HttpGet]
        public ActionResult Delete(string dfn, string ien)
        {
            DeleteNoteModel model = new DeleteNoteModel();

            model.Patient = this.CurrentPatient;

            if (!model.Patient.NotFound)
                model.NoteIen = ien;

            // *** Set return url ***
            if (TempData.ContainsKey(ReturnUrl))
            {
                model.ReturnUrl = TempData[ReturnUrl].ToString();
                TempData[ReturnUrl] = TempData[ReturnUrl];
            }

            return View(model); 
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Delete(DeleteNoteModel model)
        {
            ActionResult returnResult;

            bool needPatDemo = false; 

            if (ModelState.IsValid)
            {
                BrokerOperationResult result = this.DashboardRepository.Notes.DeleteNote(model.NoteIen, model.DeleteReason);

                if (!result.Success)
                {
                    this.Error(result.Message);
                    returnResult = View(model);
                    needPatDemo = true; 
                }
                else
                {
                    this.Information("The note has been deleted.");
                    if (TempData.ContainsKey(ReturnUrl))
                        returnResult = Redirect(TempData.Peek(ReturnUrl).ToString());
                    else
                        returnResult = RedirectToAction("Index", new { dfn = model.Patient.Dfn, filter = PregnancyUtilities.PregnancyFilterCurrent, page = "1" });
                }
            }
            else
            {
                needPatDemo = true; 
                model.NoteIen = model.NoteIen;

                this.Error("Please enter a reason for the deletion");
                returnResult = View(model);
            }

            if (needPatDemo)
            {
                this.CurrentPatientDfn = model.Patient.Dfn;
                model.Patient = this.CurrentPatient;
            }

            // *** Set return url ***
            if (TempData.ContainsKey(ReturnUrl))
            {
                model.ReturnUrl = TempData[ReturnUrl].ToString();
                TempData[ReturnUrl] = TempData[ReturnUrl];
            }

            return returnResult; 
        }

        [HttpGet]
        public ActionResult Sign(string dfn, string ien)
        {
            SignNoteModel model = new SignNoteModel();

            model.Patient = this.CurrentPatient;

            if (!model.Patient.NotFound)
                model.NoteIen = ien;

            // *** Set return url ***
            if (TempData.ContainsKey(ReturnUrl))
            {
                model.ReturnUrl = TempData[ReturnUrl].ToString();
                TempData[ReturnUrl] = TempData[ReturnUrl];
            }

            return View(model);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Sign(SignNoteModel model)
        {
            ActionResult returnResult;

            bool needDemo = false; 

            if (ModelState.IsValid)
            {
                BrokerOperationResult result = this.DashboardRepository.Notes.SignNote(model.NoteIen, model.Esig);

                if (!result.Success)
                {
                    this.Error(result.Message);
                    returnResult = View(model);
                    needDemo = true; 
                }
                else
                {
                    this.Information("The note has been signed.");
                    if (TempData.ContainsKey(ReturnUrl))
                        returnResult = Redirect(TempData.Peek(ReturnUrl).ToString());
                    else
                        returnResult = RedirectToAction("Index", new { dfn = model.Patient.Dfn, filter = model.NoteIen, page = "1" });
                }
            }
            else
            {
                needDemo = true; 
                
                model.NoteIen = model.NoteIen;

                this.Error("Please enter signature code");

                returnResult = View(model);
            }

            if (needDemo)
            {
                this.CurrentPatientDfn = model.Patient.Dfn;
                model.Patient = this.CurrentPatient;
            }

            // *** Set return url ***
            if (TempData.ContainsKey(ReturnUrl))
            {
                model.ReturnUrl = TempData[ReturnUrl].ToString();
                TempData[ReturnUrl] = TempData[ReturnUrl];
            }

            return returnResult;
        }

        [HttpGet]
        public ActionResult CreateAddendum(string dfn, string ien)
        {
            // *** Create addendum to existing dashboard note ***

            TiuNoteModel model = new TiuNoteModel();

            model.Patient = this.CurrentPatient;

            model.Note.Ien = ien;

            // *** Set return url ***
            if (TempData.ContainsKey(ReturnUrl))
            {
                model.ReturnUrl = TempData[ReturnUrl].ToString();
                TempData[ReturnUrl] = TempData[ReturnUrl];
            }

            return View(model);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult CreateAddendum(TiuNoteModel model)
        {
            // *** Post data ***

            ActionResult returnResult;

            bool needPatDemo = false;

            if (ModelState.IsValid)
            {
                BrokerOperationResult result = this.DashboardRepository.Notes.CreateAddendum(model.Note.Ien, model.Note.NoteText, model.Note.Subject, new Dictionary<string, string>() );

                if (!result.Success)
                {
                    this.Error(result.Message);

                    returnResult = View(model);

                    needPatDemo = true;
                }
                else
                {
                    this.Information("Addendum Created");
                    if (TempData.ContainsKey(ReturnUrl))
                        returnResult = Redirect(TempData.Peek(ReturnUrl).ToString());
                    else
                        returnResult = RedirectToAction("Index", new { dfn = model.Patient.Dfn, filter = model.Note.PregnancyIen, page = "1" });

                    needPatDemo = false;
                }
            }
            else
            {
                this.Error("Please enter note details");
                returnResult = View(model);
                needPatDemo = true;
            }

            if (needPatDemo)
            {
                this.CurrentPatientDfn = model.Patient.Dfn;
                model.Patient = this.CurrentPatient;
            }

            // *** Set return url ***
            if (TempData.ContainsKey(ReturnUrl))
            {
                model.ReturnUrl = TempData[ReturnUrl].ToString();
                TempData[ReturnUrl] = TempData[ReturnUrl];
            }

            return returnResult;
        }

        [HttpGet]
        public ActionResult Addenda(string dfn, string ien)
        {
            AddendaModel model = new AddendaModel();

            // *** Set the patient ***
            model.Patient = this.CurrentPatient;

            // *** Get the parent note ***
            TiuNoteResult noteResult = this.DashboardRepository.Notes.GetNoteHeader(dfn, ien);

            if (!noteResult.Success)
                this.Error("The note could not be found");
            else
            {
                if (noteResult.Note != null)
                {
                    // *** Add parent note to model ***
                    model.OriginalNote = noteResult.Note;

                    if (noteResult.Note.AddendaIens.Count > 0)
                    {
                        // *** Get all the addenda ***
                        foreach (string addendaIen in noteResult.Note.AddendaIens)
                        {
                            // *** Get from VistA ***
                            TiuNoteResult addendaResult = this.DashboardRepository.Notes.GetNoteHeader(dfn, addendaIen);

                            // *** Add to list ***
                            if (addendaResult.Success)
                                if (addendaResult.Note != null)
                                    model.Addenda.Add(addendaResult.Note); 
                        }
                    }
                }
            }

            TempData[ReturnUrl] = Url.Action("Addenda", new { dfn = dfn, ien = ien });

            return View(model); 
        }

        //private Dictionary<string, string> GetPregnanciesSelection(string dfn)
        //{
        //    Dictionary<string, string> returnVal = new Dictionary<string, string>(); 

        //    List<PregnancyDetails> pregList = this.GetPregnancies(dfn);

        //    returnVal = this.GetPregnanciesSelection(pregList, false ); 

        //    return returnVal; 
        //}

        //private Dictionary<string, string> GetPregnanciesSelection(List<PregnancyDetails> pregList, bool filterList)
        //{
        //    // *** Get a selection dictionary used to create a SelectList ***

        //    Dictionary<string, string> returnVal = new Dictionary<string, string>();

        //    // *** If this is a list for a filter, use filter constant **
        //    //if (filterList)
        //    //    returnVal.Add(PregnancyFilterUnassociated, NotAssociatedMessage);
        //    //else 
        //    //    returnVal.Add("", NotAssociatedMessage);

        //    if (!filterList)
        //        returnVal.Add("", NotAssociatedMessage);

        //    // *** Get the pregnancies ***
        //    foreach (PregnancyDetails preg in pregList)
        //        returnVal.Add(preg.Ien, preg.Description);

        //    // *** If this is a list for a filter, create all item ***
        //    if (filterList)
        //        returnVal.Add(PregnancyFilterAll, "All (Unfiltered)"); 

        //    return returnVal; 
        //}

        //private List<PregnancyDetails> GetPregnancies(string dfn)
        //{
        //    List<PregnancyDetails> returnList = new List<PregnancyDetails>();

        //    // *** Get pregnancies ***
        //    PregnancyListResult result = this.DashboardRepository.Pregnancy.GetPregnancies(dfn, "");

        //    if (result.Success)
        //        returnList.AddRange(result.Pregnancies); 

        //    return returnList; 
        //}
    }
}
