using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace VA.Gov.Artemis.Portal.UI.Controllers
{
    public class CurrentPregnancyController : Controller
    {
        //
        // GET: /CurrentPregnancy/

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
