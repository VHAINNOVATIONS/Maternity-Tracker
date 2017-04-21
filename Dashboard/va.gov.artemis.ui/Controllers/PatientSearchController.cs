// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using VA.Gov.Artemis.Core;
using VA.Gov.Artemis.UI.Data.Brokers.Patient;
using VA.Gov.Artemis.UI.Data.Models;
using VA.Gov.Artemis.UI.Data.Models.PatientSearch;
using VA.Gov.Artemis.UI.Filters;
using VA.Gov.Artemis.Vista.Broker;

namespace VA.Gov.Artemis.UI.Controllers
{
    [Authorize]
    [DisableLocalCache]
    [VerifySession]
    public class PatientSearchController : DashboardController
    {
        private const int ItemsPerPage = 10; 

        // *** Default constructor used by MVC ***
        public PatientSearchController() : base() { }

        // *** Broker constructor for testing with mock broker ***
        public PatientSearchController(IRpcBroker broker): base(broker) {}

        [HttpGet]
        public ActionResult Search(string criteria, string page)
        {
            // *** Show search page and results ***
            ActionResult returnResult;

            PatientSearch model = new PatientSearch();

            // *** Check if we have criteria ***
            if (string.IsNullOrWhiteSpace(criteria))
                model.Message = "(patient results)"; 
            else
            {
                // *** Require at least two characters ***
                if (criteria.Length < 2)
                    this.Error("Please enter at least two characters");
                else
                {
                    int pageNum = GetPage(page);

                    // *** Do search on repository ***
                    PatientSearchResult result = this.DashboardRepository.Patients.Search(criteria, pageNum, ItemsPerPage);

                    // *** If successful ***
                    if (result.Success)
                    {
                        // *** If we have any patients ***
                        if (result.Patients != null)
                            if (result.Patients.Count > 0)
                            {
                                // *** Set paging data ***
                                model.Paging.SetPagingData(ItemsPerPage, pageNum, result.TotalResults);

                                // *** Set base url for paging ***
                                model.Paging.BaseUrl = Url.Action("Search", "PatientSearch", new { criteria = criteria, page = "" });

                                // *** Set return url for navigation ***
                                TempData[ReturnUrl] = Url.Action("Search", "PatientSearch", new { criteria = criteria, page = pageNum });

                                //// *** Add current page's patients ***
                                //int startIdx = (pageNum - 1) * ItemsPerPage;
                                //int endIdx = startIdx + ItemsPerPage - 1;
                                //if (endIdx >= result.Patients.Count)
                                //    endIdx = result.Patients.Count - 1;

                                //for (int i = startIdx; i <= endIdx; i++)
                                //    model.Patients.Add(result.Patients[i]);

                                model.Patients.AddRange(result.Patients);
                            }
                    }
                    else
                    {
                        ErrorLogger.Log(string.Format("PatientSearchController.Search: {0}", result.Message));
                        this.Error(result.Message);
                    }

                    if (model.Patients.Count == 0)
                        model.Message = "(No Patients Found)";
                }
                
            }

            returnResult = View(model);

            return returnResult; 
        }
    }
}