// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using VA.Gov.Artemis.UI.Data.Models.History;
using VA.Gov.Artemis.UI.Filters;

namespace VA.Gov.Artemis.UI.Controllers
{
    [VerifySession]
    [DisableLocalCache]
    [Authorize]
    public class HistoryController : DashboardController
    {
        [HttpGet]
        public ActionResult Index(string dfn)
        {
            HistoryModel model = new HistoryModel();

            // *** Set the patient ***
            model.Patient = this.CurrentPatient;

            return View(model);
        }

    }
}
