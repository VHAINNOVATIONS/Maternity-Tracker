using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using VA.Gov.Artemis.UI.Data.Brokers.Labs;
using VA.Gov.Artemis.UI.Data.Brokers.Pregnancy;
using VA.Gov.Artemis.UI.Data.Models;
using VA.Gov.Artemis.UI.Data.Models.Labs;
using VA.Gov.Artemis.UI.Data.Models.Patient;
using VA.Gov.Artemis.UI.Data.Models.Pregnancy;
using VA.Gov.Artemis.UI.Filters;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.UI.Controllers
{
    [VerifySession]
    [DisableLocalCache]
    [Authorize]
    public class LabsController : DashboardController
    {
        private const int LabItemsPerPage = 10; 

        [HttpGet]
        public ActionResult Index(string dfn, LabResultType labType, bool pregFilter, string page)
        {
            // *** Create the model ***
            LabModel model = new LabModel();

            // *** Set the patient ***
            model.Patient = this.CurrentPatient;

            // *** Get the page value ***
            int pageVal = this.GetPage(page);

            // *** Create date range dates ***
            DateTime fromDate = DateTime.MinValue; 
            DateTime toDate = DateTime.MinValue;

            // *** Add the filters to the model ***
            model.LabTypeFilter = labType.ToString();
            
            PregnancyDetails pregDetails = null; 

            PregnancyResult pregResult = this.DashboardRepository.Pregnancy.GetCurrentOrMostRecentPregnancy(dfn);

            if (pregResult.Success)
                if (pregResult.Pregnancy != null)
                    pregDetails = pregResult.Pregnancy;

            if (pregDetails != null)
            {
                if (pregDetails.RecordType == Data.Models.Pregnancy.PregnancyRecordType.Current)
                    model.PregnancyFilterDescription = "Current Pregnancy";
                else
                    model.PregnancyFilterDescription = "Most Recent Pregnancy";

                if (pregFilter)
                {
                    // *** Set the date range dates ***
                    fromDate = pregDetails.StartDate;
                    toDate = pregDetails.EndDate;

                    // *** Create an approximate date/time for fromDate if needed ***
                    if (fromDate == DateTime.MinValue)
                        if (toDate != DateTime.MinValue)
                            fromDate = toDate.AddDays(-280); 

                    model.FilteredByPregnancy = true; 
                }

                model.CanFilterByPregnancy = true;
            }
            else
            {
                model.PregnancyFilterDescription = "Current Pregnancy";
                model.CanFilterByPregnancy = false;
                model.FilteredByPregnancy = false; 
            }

            // *** Get the list of labs ***
            LabItemsResult labsResult = this.DashboardRepository.Labs.GetList(dfn, labType,pregFilter, fromDate, toDate , pageVal, LabItemsPerPage);

            if (!labsResult.Success)
                this.Error(labsResult.Message);
            else
                if (labsResult.Labs == null)
                    model.Items = new List<LabItem>();
                else
                {
                    // *** Add lab items ***
                    model.Items = labsResult.Labs;

                    // *** Paging ***
                    model.Paging.SetPagingData(LabItemsPerPage, pageVal, labsResult.TotalResults);                    
                    model.Paging.BaseUrl = Url.Action("Index", new {dfn = dfn, labtype=labType, pregFilter=pregFilter, page = "" });
                }

            return View(model); 
        }

    }
}
