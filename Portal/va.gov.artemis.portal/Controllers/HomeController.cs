using System;
using System.Configuration;
using System.Web.Mvc;

namespace VA.Gov.Artemis.UI.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            //PatientSummary model = new PatientSummary()
            //{
            //    Patient = new BasePatient() { FirstName = "Abcdef", LastName = "Hijkl", FullSSN = "123456789", DateOfBirth = new DateTime(1990, 12, 12) }
            //};

            //return View(model);
            return View();
        }
    }
}
