// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using VA.Gov.Artemis.UI.Data.Brokers.Reminders;
using VA.Gov.Artemis.UI.Data.Models.Patient;
using VA.Gov.Artemis.UI.Data.Models.Reminders;
using VA.Gov.Artemis.UI.Filters;

namespace VA.Gov.Artemis.UI.Controllers
{
    [DisableLocalCache]
    [VerifySession]
    [Authorize]
    public class RemindersController : DashboardController
    {
        private const int RemindersPerPage = 10;

        [HttpGet]
        public ActionResult Index(string dfn, string page)
        {
            // *** Show a list of reminders ***

            ReminderListModel model = new ReminderListModel();

            // *** Add patient to model ***
            model.Patient = this.CurrentPatient;

            // *** Get proper page ***
            int pageVal = this.GetPage(page);

            // *** Get list ***
            ReminderListResult result = this.DashboardRepository.Reminders.GetList(dfn, pageVal, RemindersPerPage);

            // *** Check result ***
            if (result.Success)
            {
                // *** Add reminders to model ***
                model.Reminders = result.Reminders;

                // *** Set paging data ***
                model.Paging.SetPagingData(RemindersPerPage, pageVal, result.TotalResults);

                // *** Set paging base url ***
                model.Paging.BaseUrl = Url.Action("Index", new { @dfn = dfn, @page = "" });
            }
            else
                this.Error(result.Message); 

            //TempData[ReturnUrl] = Url.Action("Index", new { dfn = dfn, page = page });

            // *** Return the view ***
            return View(model); 

        }

        [HttpGet]
        public ActionResult Detail(string dfn, string ien)
        {
            ReminderDetailModel model = new ReminderDetailModel();
            
            model.Patient = this.CurrentPatient;

            ReminderDetailResult result = this.DashboardRepository.Reminders.GetDetail(dfn, ien);

            if (!result.Success)
                this.Error(result.Message);
            else
                model.ReminderDetail = result.ReminderDetail;

            return View(model);
        }
    }
}
