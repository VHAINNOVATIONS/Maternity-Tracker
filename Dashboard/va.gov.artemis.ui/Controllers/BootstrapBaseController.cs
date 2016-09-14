using System.Web.Mvc;
using BootstrapSupport;

namespace VA.Gov.Artemis.UI.Controllers
{
    public class BootstrapBaseController: Controller
    {
        public void Attention(string message)
        {
            TempData.Add(Alerts.WARNING, message);
        }

        public void Success(string message)
        {
            TempData.Add(Alerts.SUCCESS, message);
        }

        public void Information(string message)
        {
            TempData.Add(Alerts.INFORMATION, message);
        }

        public void Error(string message)
        {
            if (TempData.ContainsKey(Alerts.DANGER))
                TempData[Alerts.DANGER] = message; 
            else 
                TempData.Add(Alerts.DANGER, message);
        }
    }
}
