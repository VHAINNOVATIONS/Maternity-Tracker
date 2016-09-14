using VA.Gov.Artemis.UI.Controllers;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;

namespace VA.Gov.Artemis.UI.Filters
{
    public class VerifySessionAttribute : ActionFilterAttribute
    {
        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            // *** Check that our previous session still exists ***

            if (filterContext.HttpContext.Session.IsNewSession)
            {
                // *** If session is new, then need user needs to login ***

                // *** If still authenticated, sign out ***
                if (filterContext.HttpContext.User.Identity.IsAuthenticated)
                    FormsAuthentication.SignOut();

                // *** Get our dashboard controller ***
                DashboardController tempController = (DashboardController)filterContext.Controller;

                // *** Add an attention message ***
                tempController.Attention("Your session has timed out.  Please log in."); 

                // *** Redirect to login ***
                filterContext.Result = new RedirectToRouteResult(new System.Web.Routing.RouteValueDictionary() { { "controller", "Account" }, { "action", "Login" } });

            }

            base.OnActionExecuting(filterContext);
        }
    }
}