// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using VA.Gov.Artemis.UI.Data.Brokers.Common;
using VA.Gov.Artemis.UI.Data.Brokers.NonVACare;
using VA.Gov.Artemis.UI.Data.Models.NonVACare;
using VA.Gov.Artemis.UI.Filters;

namespace VA.Gov.Artemis.UI.Controllers
{
    [DisableLocalCache]
    [VerifySession]
    [Authorize]
    public class NonVACareController : DashboardController
    {
        private const int ItemsPerPage = 10; 

        [HttpGet]
        public ActionResult Index(string page, string dfn, string pien, string itemType)
        {
            // *** Show lists of current providers and facilities ***

            NonVACareItemList model = new NonVACareItemList();

            // *** Values used to return after managing ***
            model.CurrentPatientDfn = dfn;
            model.CurrentPregnancyIen = pien;
            model.CurrentItemType = itemType; 

            int pageVal = this.GetPage(page); 

            // *** Get the list of items ***
            NonVACareItemsResult result =  this.DashboardRepository.NonVACare.GetAll(pageVal, ItemsPerPage);

            // *** Check for success ***
            if (!result.Success)
                this.Error(result.Message);
            else
            {
                model.Items = result.Items;
                model.Paging.SetPagingData(ItemsPerPage, pageVal, result.TotalResults);


                if (string.IsNullOrWhiteSpace(dfn))
                    dfn = "-1";

                if (string.IsNullOrWhiteSpace(pien))
                    pien = "-1";

                if (string.IsNullOrWhiteSpace(itemType))
                    itemType = "-1"; 

                model.Paging.BaseUrl = Url.Action("Index", "NonVACare", new {dfn = dfn, pien = pien, itemType = itemType, page = ""});

                if (TempData.ContainsKey(FinishedUrl))
                    model.FinishedLink = TempData.Peek(FinishedUrl).ToString();
                
                TempData[ReturnUrl] = Url.Action("Index", "NonVACare", new { dfn = dfn, pien = pien, itemType = itemType, page = page });

            }

            return View(model);
        }

        [HttpGet]
        public ActionResult AddEdit(string ien, string dfn, string pien, string itemType)
        {
            // *** Edit existing provider or facility ***

            NonVACareItemAddEdit model = new NonVACareItemAddEdit();

            // *** Values used to return after managing ***
            model.CurrentPatientDfn = dfn;
            model.CurrentPregnancyIen = pien;
            model.CurrentItemType = itemType;

            if (!string.IsNullOrWhiteSpace(ien))
            {
                // *** Get the item ***
                NonVACareItemsResult result = this.DashboardRepository.NonVACare.GetItem(ien);

                // *** Check for success ***
                if (result.Success)
                    if (result.Items != null)
                        if (result.Items.Count > 0)
                            model.Item = result.Items[0];
            }

            // *** Set return url ***
            if (TempData.ContainsKey(ReturnUrl))
            {
                model.ReturnUrl = TempData[ReturnUrl].ToString();
                TempData[ReturnUrl] = TempData[ReturnUrl];
            }

            return View(model);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult AddEdit(NonVACareItemAddEdit model)
        {
            ActionResult returnResult; 

            // *** Post data ***

            BrokerOperationResult result;

            // *** Check model state ***
            if (ModelState.IsValid)
            {
                result = this.DashboardRepository.NonVACare.SaveItem(model.Item);

                // *** Check result ***
                if (!result.Success)
                {
                    this.Error(result.Message);
                    returnResult = View("AddEdit", model);
                }
                else 
                    returnResult = RedirectToAction("Index", new { @page = "1", @dfn = model.CurrentPatientDfn, @pien = model.CurrentPregnancyIen, @itemType = model.CurrentItemType });
            }
            else 
                returnResult = View("AddEdit", model);

            // *** Set return url ***
            if (TempData.ContainsKey(ReturnUrl))
            {
                model.ReturnUrl = TempData[ReturnUrl].ToString();
                TempData[ReturnUrl] = TempData[ReturnUrl];
            }

            return returnResult;
        }


    }
}
