// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using VA.Gov.Artemis.UI.Data;
using VA.Gov.Artemis.UI.Data.Brokers.TrackingHistory;
using VA.Gov.Artemis.UI.Data.Models.Track;
using VA.Gov.Artemis.UI.Filters;

namespace VA.Gov.Artemis.UI.Controllers
{
    [Authorize]
    [VerifySession]
    [DisableLocalCache]
    public class TrackingHistoryController : DashboardController
    {
        private const int ItemsPerPage = 10; 

        public ActionResult ByPatient(string dfn, string page)
        {
            // *** Show tracking history by patient and page ***

            ActionResult returnResult;

            // *** Get proper page, default to 1 ***
            //int pageVal;
            //if (!int.TryParse(page, out pageVal))
            //    pageVal = 1;
            int pageNum = this.GetPage(page);

            // *** Create model ***
            TrackingEntryList model = new TrackingEntryList();

            // *** Get current page of data from repository ***
            TrackingHistoryResult result = this.DashboardRepository.TrackingHistory.GetPatientEntries(dfn, pageNum, ItemsPerPage);

            // *** Check result ***
            if (result.Success)
            {
                // *** Old code to manually filter by patient ***
                //model.Entries = new List<TrackingEntry>(); 
                //if (result.TrackingEntries != null)
                //    if (result.TrackingEntries.Count > 0)
                //        foreach (TrackingEntry entry in result.TrackingEntries)
                //            if (entry.PatientDfn == dfn)
                //                model.Entries.Add(entry);

                model.Entries = result.TrackingEntries; 

                // *** Hide patient link ***
                model.ShowPatientLinks = false;

                // *** Set paging data ***
                model.Paging.SetPagingData(ItemsPerPage, pageNum, result.TotalEntries);
                model.Paging.BaseUrl = Url.Action("ByPatient", "TrackingHistory", new { page = "" });

            }
            else
                this.Error(result.Message);

            // *** Set return url ***
            if (TempData.ContainsKey(ReturnUrl))
            {
                model.ReturnUrl = TempData[ReturnUrl].ToString();
                TempData[ReturnUrl] = TempData[ReturnUrl];
            }

            returnResult = View(model);

            return returnResult;
        }

        public ActionResult All(string page)
        {
            ActionResult returnResult;

            // *** Get proper page, default to 1 ***
            //int pageVal;
            //if (!int.TryParse(page, out pageVal))
            //    pageVal = 1; 
            int pageNum = this.GetPage(page);

            // *** Get entries ***
            TrackingHistoryResult result = this.DashboardRepository.TrackingHistory.GetHistoryEntries(pageNum, ItemsPerPage);

            // *** Create model ***
            TrackingEntryList model = new TrackingEntryList();

            // *** Add data to model ***
            model.Entries = result.TrackingEntries;
            model.ShowPatientLinks = true;

            // *** Add paging data ***
            model.Paging.SetPagingData(ItemsPerPage, pageNum, result.TotalEntries);
            model.Paging.BaseUrl = Url.Action("All", "TrackingHistory", new { page = "" });

            TempData[ReturnUrl] = Url.Action("All", "TrackingHistory", new { page = page }); 

            returnResult = View(model);

            return returnResult;
        }
    }
}
