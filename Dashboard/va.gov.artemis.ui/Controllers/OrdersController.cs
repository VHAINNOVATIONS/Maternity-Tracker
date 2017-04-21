// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System.Web.Mvc;
using VA.Gov.Artemis.UI.Data.Brokers.Orders;
using VA.Gov.Artemis.UI.Data.Models;
using VA.Gov.Artemis.UI.Data.Models.Orders;
using VA.Gov.Artemis.UI.Data.Models.Patient;
using VA.Gov.Artemis.UI.Filters;

namespace VA.Gov.Artemis.UI.Controllers
{
    [DisableLocalCache]
    [VerifySession]
    [Authorize]
    public class OrdersController : DashboardController
    {
        private const int OrdersPerPage = 20; 

        [HttpGet]
        public ActionResult Index(string dfn, string page)
        {
            // *** Show a list of orders ***

            OrderListModel model = new OrderListModel();

            // *** Add patient to model ***
            model.Patient = this.CurrentPatient;

            // *** Get proper page ***
            int pageVal = this.GetPage(page);

            // *** Get list ***
            OrderListResult result = this.DashboardRepository.Orders.GetList(dfn, pageVal, OrdersPerPage);

            // *** Check result ***
            if (result.Success)
            {
                // *** Add orders to model ***
                model.Orders = result.OrderList;

                // *** Set paging data ***
                model.Paging.SetPagingData(OrdersPerPage, pageVal, result.TotalResults);

                // *** Set paging base url ***
                model.Paging.BaseUrl = Url.Action("Index", new { @dfn = dfn, @page = "" });
            }
            else
                this.Error(result.Message); 

            TempData[ReturnUrl] = Url.Action("Index", new { dfn = dfn, page = page }); 

            // *** Return the view ***
            return View(model); 
        }

        [HttpGet]
        public ActionResult Detail(string dfn, string ifn)
        {
            OrderDetailModel model = new OrderDetailModel();

            model.Patient = this.CurrentPatient;

            OrderDetailResult result = this.DashboardRepository.Orders.GetDetail(dfn, ifn);

            if (!result.Success)
                this.Error(result.Message);
            else
                model.OrderDetail = result.OrderDetail;

            // *** Set return url ***
            if (TempData.ContainsKey(ReturnUrl))
            {
                model.ReturnUrl = TempData[ReturnUrl].ToString();
                TempData[ReturnUrl] = TempData[ReturnUrl];
            }
            return View(model); 
        }
    }
}
