// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using VA.Gov.Artemis.UI.Data.Brokers.Radiology;
using VA.Gov.Artemis.UI.Data.Models.Radiology;
using VA.Gov.Artemis.UI.Filters;

namespace VA.Gov.Artemis.UI.Controllers
{
    [DisableLocalCache]
    [VerifySession]
    [Authorize]
    public class RadiologyController : DashboardController
    {
        private int ItemsPerPage = 10; 

        [HttpGet]
        public ActionResult Index(string dfn, string page)
        {
            RadiologyIndex model = new RadiologyIndex();

            model.Patient = this.CurrentPatient;

            RadiologyReportsResult result = this.DashboardRepository.Radiology.GetReports(dfn);

            if (!result.Success)
                this.Error(result.Message);
            else
            {
                if (result.Items != null)
                {
                    int pageVal = this.GetPage(page);

                    for (int i = 0; i < result.Items.Count; i++)
                    {
                        int fromIdx = ((pageVal - 1) * this.ItemsPerPage);
                        int toIdx = fromIdx + this.ItemsPerPage - 1;

                        if ((i >= fromIdx) && (i <= toIdx))
                            model.ReportList.Add(result.Items[i]);
                    }

                    model.Paging.SetPagingData(this.ItemsPerPage, pageVal, result.Items.Count);
                    model.Paging.BaseUrl = Url.Action("Index", new { dfn = dfn, page = "" });
                }

            }

            return View(model); 
        }
    }
}
