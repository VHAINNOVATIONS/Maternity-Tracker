// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using VA.Gov.Artemis.UI.Data.Brokers.Alerts;
using VA.Gov.Artemis.UI.Data.Models.Alerts;
using VA.Gov.Artemis.UI.Filters;

namespace VA.Gov.Artemis.UI.Controllers
{

    [DisableLocalCache]
    [VerifySession]
    [Authorize]
    public class AlertsController : DashboardController
    {
        private const int AlertsPerPage = 10;

        [HttpGet]
        public ActionResult Index(string page)
        {
            AlertListModel model = new AlertListModel(); 

            int pageVal = this.GetPage(page);

            AlertListResult result  = this.DashboardRepository.Alerts.GetAlerts(pageVal, AlertsPerPage);

            if (!result.Success)
                this.Error(result.Message);
            else
            {
                if (result.Alerts != null)
                    model.Alerts = result.Alerts;

                model.Paging.SetPagingData(AlertsPerPage, pageVal, result.TotalResults);
                model.Paging.BaseUrl = Url.Action("Index", "Alerts", new { @page = "" });
            }

            return View(model);
        }
    }
}
