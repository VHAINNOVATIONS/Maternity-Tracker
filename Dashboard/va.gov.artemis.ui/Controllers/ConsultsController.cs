using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using VA.Gov.Artemis.UI.Data.Brokers.Consults;
using VA.Gov.Artemis.UI.Data.Models.Consults;
using VA.Gov.Artemis.UI.Filters;

namespace VA.Gov.Artemis.UI.Controllers
{
    [DisableLocalCache]
    [VerifySession]
    [Authorize]
    public class ConsultsController : DashboardController
    {
        private int ItemsPerPage = 10; 

        [HttpGet]
        public ActionResult Index(string dfn, string page)
        {
            ConsultIndex model = new ConsultIndex();

            model.Patient = this.CurrentPatient;

            ConsultListResult result = this.DashboardRepository.Consults.GetList(dfn);

            if (!result.Success)
                this.Error(result.Message);
            else
            {
                if (result.Consults != null)
                {
                    int pageVal = this.GetPage(page);

                    for (int i = 0; i < result.Consults.Count; i++)
                    {
                        int fromIdx = ((pageVal - 1) * this.ItemsPerPage);
                        int toIdx = fromIdx + this.ItemsPerPage - 1;

                        if ((i >= fromIdx) && (i <= toIdx))
                            model.Items.Add(result.Consults[i]);
                    }

                    model.Paging.SetPagingData(this.ItemsPerPage, pageVal, result.Consults.Count);
                    model.Paging.BaseUrl = Url.Action("Index", new { dfn = dfn, page = "" });
                }
            }

            return View(model); 
        }

        [HttpGet]
        public ActionResult Detail(string dfn, string ien)
        {
            ConsultDetail model = new ConsultDetail();

            model.Patient = this.CurrentPatient;

            ConsultDetailResult result = this.DashboardRepository.Consults.GetDetail(ien);

            if (!result.Success)
                this.Error(result.Message);
            else
                model.DetailText = result.ConsultDetail; 

            return View(model); 
        }
    }
}
