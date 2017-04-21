// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

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