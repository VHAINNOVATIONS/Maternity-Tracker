// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System.Configuration;
using System.Web.Mvc;
using VA.Gov.Artemis.UI.Data.Models;
using VA.Gov.Artemis.UI.Data.Models.Home;
using VA.Gov.Artemis.UI.Filters;

namespace VA.Gov.Artemis.UI.Controllers
{
    public class HomeController : DashboardController
    {
        [AllowAnonymous]
        [DisableLocalCache]
        public ActionResult Index()
        {
            HomeData model = new HomeData();

            model.WelcomeMessage = ConfigurationManager.AppSettings["WelcomeMessage"];
            model.ProductDescription = ConfigurationManager.AppSettings["ProductDescription"];
            model.AccessHelpLink  = ConfigurationManager.AppSettings["AccessHelpLink"];

            bool loggedIn = false; 

            if (this.User != null) 
                if (this.User.Identity != null) 
                    if (!string.IsNullOrWhiteSpace(this.User.Identity.Name))
                        loggedIn = true; 

            if (!loggedIn)
            {
                model.LoginMessage = "You may use your VistA credentials to access the system.";
                model.LoginButtonText = "Log In Now";
            }
            else
            {
                model.LoginMessage = "You are currently logged into VistA.";
                model.LoginButtonText = "View Dashboard";
            }

            // *** Don't timeout the home page ***
            ViewBag.NoTimeout = true; 

            return View(model);
        }
    }
}
