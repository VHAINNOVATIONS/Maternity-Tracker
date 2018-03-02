// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System.Web.Mvc;
using VA.Gov.Artemis.UI.Data.Brokers.Common;
using VA.Gov.Artemis.UI.Data.Models.Lactation;
using VA.Gov.Artemis.UI.Filters;

namespace VA.Gov.Artemis.UI.Controllers
{
    [DisableLocalCache]
    [VerifySession]
    [Authorize]
    public class LactationController : DashboardController
    {
        [HttpGet]
        public ActionResult Status(string dfn)
        {
            LactationStatus model = new LactationStatus();

            model.Patient = this.CurrentPatient;

            model.CurrentStatus = (this.CurrentPatient.Lactating) ? "Lactating" : "Not Lactating";

            return View(model);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Status(LactationStatus model)
        {
            ActionResult returnResult;

            bool okToContinue = false;

            if (model.NewStatus.HasValue)
            {
                IenResult wvrpcorResult = this.DashboardRepository.Observations.AddWvrpcorLactationObservation(model.Patient.Dfn, model.NewStatus.Value);
                if (!wvrpcorResult.Success)
                {
                    this.Error(wvrpcorResult.Message);
                }
                else
                {
                    IenResult result = this.DashboardRepository.Observations.AddLactationObservation(model.Patient.Dfn, model.NewStatus.Value);

                    if (!result.Success)
                    {
                        this.Error(result.Message);
                    }
                    else
                    {
                        this.Information("Lactation Status Updated");
                        okToContinue = true;
                    }
                }
            }
            else
                this.Error("Please select a lactation status");

            if (okToContinue)
                returnResult = RedirectToAction("Summary", "Patient", new { dfn = model.Patient.Dfn });
            else
            {
                this.CurrentPatientDfn = model.Patient.Dfn;
                model.Patient = this.CurrentPatient;
                model.CurrentStatus = model.CurrentStatus = (this.CurrentPatient.Lactating) ? "Lactating" : "Not Lactating";

                returnResult = View(model);
            }

            return returnResult;
        }
    }
}
