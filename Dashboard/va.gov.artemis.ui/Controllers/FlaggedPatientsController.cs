using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using VA.Gov.Artemis.UI.Data.Brokers.Notes;
using VA.Gov.Artemis.UI.Data.Brokers.Patient;
using VA.Gov.Artemis.UI.Data.Brokers.TrackingHistory;
using VA.Gov.Artemis.UI.Data.Models;
using VA.Gov.Artemis.UI.Data.Models.FlaggedPatients;
using VA.Gov.Artemis.UI.Data.Models.Notes;
using VA.Gov.Artemis.UI.Filters;

namespace VA.Gov.Artemis.UI.Controllers
{
    [Authorize]
    [VerifySession]
    [DisableLocalCache]
    public class FlaggedPatientsController: DashboardController
    {
        private const int ItemsPerPage = 10;
        private const int ProgNotesPerPage = 5; 

        [HttpGet]
        public ActionResult Index(string page)
        {
            // *** Show the flagged patient index ***

            FlaggedPatientList model = new FlaggedPatientList();

            int pageNum = GetPage(page); 

            // *** Get flagged patients ***
            FlaggedPatientsResult result = this.DashboardRepository.Patients.GetFlaggedPatients(pageNum, ItemsPerPage);

            if (result.Success)
            {
                // *** Add current page's patients ***
                //int startIdx = (pageNum - 1) * ItemsPerPage;
                //int endIdx = startIdx + ItemsPerPage - 1;
                //if (endIdx >= result.Patients.Count)
                //    endIdx = result.Patients.Count - 1;

                //for (int i = startIdx; i <= endIdx; i++)
                //    model.Patients.Add(result.Patients[i]);
                
                model.Patients.AddRange(result.Patients); 

                // *** Set paging info ***
                model.Paging.SetPagingData(ItemsPerPage, pageNum, result.TotalResults);
                //model.Paging.SetPagingData(ItemsPerPage, pageNum, result.Patients.Count);

                model.Paging.BaseUrl = Url.Action("Index", "FlaggedPatients", new { page=""});

                TempData[ReturnUrl] = Url.Action("Index", "FlaggedPatients", new { page = pageNum });
            }

            return View(model);
        }

        [HttpGet]
        public ActionResult Details(string dfn, string page)
        {
            // *** Show details of a flagged patient ***

            FlaggedPatientDetail model = new FlaggedPatientDetail();

            // *** Get patient demographics ***
            model.Patient = this.CurrentPatient;

            // *** Check for success ***
            if (!model.Patient.NotFound)
            {                
                // *** Get patient flags ***
                TrackingHistoryResult trackingResult = this.DashboardRepository.TrackingHistory.GetPatientEntries(dfn);

                // *** Set tracking entries if successful ***
                if (trackingResult.Success)
                    model.TrackingEntries = trackingResult.TrackingEntries;

                NoteListResult notesResult = this.DashboardRepository.Notes.GetList(dfn);

                int pageNum = this.GetPage(page); 

                if (notesResult.Success)
                {
                    // *** Add current page's patients ***
                    int startIdx = (pageNum - 1) * ProgNotesPerPage;
                    int endIdx = startIdx + ProgNotesPerPage - 1;
                    if (endIdx >= notesResult.Notes.Count)
                        endIdx = notesResult.Notes.Count - 1;

                    for (int i = startIdx; i <= endIdx; i++)
                        model.ProgressNotes.Add(notesResult.Notes[i]);

                    model.ProgressNotePaging.SetPagingData(ProgNotesPerPage, pageNum, notesResult.Notes.Count);
                    model.ProgressNotePaging.BaseUrl = Url.Action("Details", "FlaggedPatients", new { dfn=dfn, page = "" });

                }
                else
                    model.ProgressNotes = new List<TiuNote>();

            }

            // *** Set return url ***
            if (TempData.ContainsKey(ReturnUrl))
            {
                model.ReturnUrl = TempData[ReturnUrl].ToString();
                TempData[ReturnUrl] = TempData[ReturnUrl];
            }

            // *** Indicate proper action for details link ***
            model.DetailAction = "ProgressNote"; 

            return View(model);
        }

        //[HttpGet]
        //public ActionResult LastProgressNote(string dfn)
        //{
        //    // *** Show last progress note ***

        //    ActionResult returnValue;
        //    TiuNoteModel model = new TiuNoteModel();

        //    // *** Get patient demographics ***
        //    model.Patient = this.CurrentPatient; 

        //    // *** Check for success ***
        //    if (!model.Patient.NotFound)
        //    {                
        //        // *** Get latest progress note ***
        //        TiuNoteResult noteResult = this.DashboardRepository.Notes.GetLatestProgressNote(dfn);

        //        if (noteResult.Success)
        //            model.Detail = noteResult.Note.NoteText;
        //        else
        //            model.Detail = "No Progress Notes";
        //    }

        //    // *** Set return url so next page knows how to get back ***
        //    //TempData[ReturnUrl] = "/FlaggedPatients/Index"; 
        //    TempData[ReturnUrl] = Url.Action("Index", "FlaggedPatients"); 

        //    returnValue = View(model); 

        //    return returnValue; 
        //}

        [HttpGet]
        public ActionResult ProgressNote(string dfn, string ien)
        {
            // *** Show last progress note ***

            ActionResult returnValue;
            TiuNoteModel model = new TiuNoteModel();

            // *** Get patient demographics ***
            model.Patient = this.CurrentPatient;

            // *** Check for success ***
            if (!model.Patient.NotFound)
            {                
                // *** Get latest progress note ***
                //TiuNoteResult noteResult = this.DashboardRepository.Notes.GetProgressNote(ien);
                TiuNoteResult noteResult = this.DashboardRepository.Notes.GetNote(ien); 

                if (noteResult.Success)
                    model.Note = noteResult.Note;
                else
                    model.Note.NoteText = "Not Found";
            }

            // *** Set return url ***
            if (TempData.ContainsKey(ReturnUrl))
            {
                model.ReturnUrl = TempData[ReturnUrl].ToString();
                TempData[ReturnUrl] = TempData[ReturnUrl];
            }

            // *** Set return url so next page knows how to get back ***
            //TempData[ReturnUrl] = Url.Action("Details", "FlaggedPatients", new {@dfn=dfn });
                        
            returnValue = View(model);

            return returnValue;
        }
    }
}