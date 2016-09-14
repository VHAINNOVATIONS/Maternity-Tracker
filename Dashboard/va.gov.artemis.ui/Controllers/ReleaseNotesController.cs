using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace VA.Gov.Artemis.UI.Controllers
{
    [AllowAnonymous]
    public class ReleaseNotesController: DashboardController
    {
        public ActionResult Index()
        {
            // *** Show basic release notes page ***

            return View();
        }
    }
}