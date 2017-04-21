// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using VA.Gov.Artemis.UI.Controllers.Common;
using VA.Gov.Artemis.UI.Data.Brokers.Patient;
using VA.Gov.Artemis.UI.Data.Brokers.Pregnancy;
using VA.Gov.Artemis.UI.Data.Models.PatientList;
using VA.Gov.Artemis.UI.Data.Models.Pregnancy;
using VA.Gov.Artemis.UI.Data.Models.Text4Baby;
using VA.Gov.Artemis.UI.Filters;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.UI.Controllers
{
    [Authorize]
    [VerifySession]
    [DisableLocalCache]
    public class PatientListController : DashboardController
    {
        private const int ItemsPerPage = 10;

        [HttpGet]
        public ActionResult Overview(string page)
        {
            // *** Basic list of tracked patients ***

            ActionResult returnValue;
            TrackedPatients model = new TrackedPatients();

            int pageNum = GetPage(page);

            // *** Get the patients from the repository ***
            //TrackedPatientsResult result = this.DashboardRepository.Patients.GetTrackedPatients(pageNum, ItemsPerPage);
            TrackedPatientsResult result = this.DashboardRepository.Patients.GetTrackedPatients(-1, -1);

            // *** Assign model based on result ***
            if (result.Success)
            {
                model.List.AddRange(result.Patients);

                model.Paging.SetPagingData(ItemsPerPage, pageNum, result.TotalResults);
                model.Paging.BaseUrl = Url.Action("Overview", "PatientList", new { page = "" });

                TempData[LastPatientListUrl] = Url.Action("Overview", "PatientList", new { page = pageNum });
            }
            else
                this.Error(result.Message);

            // *** Set the return value ***
            returnValue = View(model);

            return returnValue;
        }

        [HttpGet]
        public ActionResult Dashboard(Outcomes outcomes)
        {
            DashboardModel model = new DashboardModel();

            // *** Get tracked patients ***
            TrackedPatientsResult trackedResult = this.DashboardRepository.Patients.GetTrackedPatients(1, 9999);

            if (trackedResult.Success)
            {
                // *** Add to the model ***
                model.TrackedPatients = trackedResult.TotalResults;

                // *** Check if we have something to work with ***
                if (trackedResult.Patients != null)
                {
                    // *** Get the day of the week as integer ***
                    int day = (int)DateTime.Now.DayOfWeek; 

                    // *** Calculate Babies Due This Week ***
                    DateTime weekStart = DateTime.Now.Date.AddDays(-1 * day);
                    DateTime weekEnd = DateTime.Now.Date.AddDays(6 - day); 

                    model.DueThisWeek = trackedResult.Patients.Count(p => p.EDD.Date >= weekStart && p.EDD.Date <= weekEnd);

                    // *** Calculate number of high-risk pregnancies ***
                    model.HighRisk = trackedResult.Patients.Count(p => p.CurrentPregnancyHighRisk == true);

                    // *** Get data for trimester pie chart ***
                    model.Tri1 = trackedResult.Patients.Count(p => p.Trimester == 1);
                    model.Tri2 = trackedResult.Patients.Count(p => p.Trimester == 2);
                    model.Tri3 = trackedResult.Patients.Count(p => p.Trimester == 3);
                    model.TriUnknown = trackedResult.Patients.Count(p => p.Trimester == -1);

                    // *** Get data for T4B pie chart ***
                    model.T4BEnrolled = trackedResult.Patients.Count(p => p.Text4BabyStatus == Text4BabyStatus.Enrolled);
                    model.T4BNotInterested = trackedResult.Patients.Count(p => p.Text4BabyStatus == Text4BabyStatus.NotInterested);
                    model.T4BUnknown = trackedResult.Patients.Count(p => p.Text4BabyStatus == Text4BabyStatus.Unknown);

                    // *** Get 10 patients with items due ***
                    model.NextDueList = trackedResult.Patients
                        .Where(p => p.NextChecklistDue != DateTime.MinValue)
                        .OrderBy(p => p.NextChecklistDue)
                        .Take(10)
                        .ToList();

                }
            }

            // *** Get count of flagged patients ***
            FlaggedPatientsResult flaggedResult = this.DashboardRepository.Patients.GetFlaggedPatients(1, 1);

            if (flaggedResult.Success)
                model.FlaggedPatients = flaggedResult.TotalResults;

            // *** Get bar chart data ***
            BarData outcomesBarData = GetOutcomesBarData();
            BarData upcomingBarData = GetUpcomingBarData(trackedResult.Patients);
            //BarData historical = GetHistoricalBarData(); 

            // *** Set up serializer ***
            JsonSerializerSettings settings = new JsonSerializerSettings(); 
            settings.ContractResolver = new LowerCaseContractResolver();

            // *** Serialize as JSON ***
            model.OutcomesJson = JsonConvert.SerializeObject(outcomesBarData, settings); 
            model.UpcomingPregnanciesJson = JsonConvert.SerializeObject(upcomingBarData, settings);

            DateTime fromDate = DateTime.MinValue;
            DateTime toDate = DateTime.Now;

            if (outcomes != null)            
            {
                if (!outcomes.AllDates)
                {
                    model.Outcomes.FromDate = VistaDates.StandardizeDateFormat(outcomes.FromDate);

                    if (!string.IsNullOrWhiteSpace(model.Outcomes.FromDate))
                        fromDate = VistaDates.ParseDateString(model.Outcomes.FromDate, VistaDates.VistADateOnlyFormat);

                    model.Outcomes.ToDate = VistaDates.StandardizeDateFormat(outcomes.ToDate);
                    if (!string.IsNullOrWhiteSpace(model.Outcomes.ToDate))
                        toDate = VistaDates.ParseDateString(model.Outcomes.ToDate, VistaDates.VistADateOnlyFormat);
                }

                model.Outcomes.AllDates = outcomes.AllDates; 
            }

            PregnancyOutcomeResult pregResult = this.DashboardRepository.Pregnancy.GetPregnancyOutcomes(fromDate, toDate, 1, 1000);

            if (pregResult.Success)
                model.Outcomes.PregnancyOutcomes = pregResult.PregnancyOutcomes;

            return View(model); 
        }

        private BarData GetUpcomingBarData(List<TrackedPatient> trackedPatients)
        {
            BarData barData = new BarData();

            BarDataSet babiesDue = new BarDataSet() { Label = "Babies Due" };

            barData.Datasets.Add(babiesDue);

            // *** Set the starting working date ***
            DateTime workingDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);

            // *** Do six months work ***
            for (int i = 0; i < 6; i++)
            {
                // *** Get the name of the month ***
                string monthName = CultureInfo.CurrentCulture.DateTimeFormat.GetMonthName(workingDate.Month);

                // *** Add the name to the barData ***
                barData.Labels.Add(monthName);

                // *** Initialize count ***
                int count = 0;

                // *** If we have some tracked patients, count the ones that match month/year ***
                if (trackedPatients != null)
                    count = trackedPatients.Count(t => t.EDD.Year == workingDate.Year && t.EDD.Month == workingDate.Month);

                // *** Add the count ***
                babiesDue.Data.Add(count);

                // *** Go to the next month ***
                workingDate = workingDate.AddMonths(1); 
            }

            return barData; 
        }

        private BarData GetOutcomesBarData()
        {
            BarData barData = new BarData();

            BarDataSet liveDataSet = new BarDataSet() { Label = "Live Deliveries" };
            BarDataSet otherDataSet = new BarDataSet() { Label = "Other Outcomes" };

            barData.Datasets.Add(liveDataSet);
            barData.Datasets.Add(otherDataSet);

            // *** Create From Date ***
            DateTime fromDate = DateTime.Now.AddMonths(-6);
            fromDate = new DateTime(fromDate.Year, fromDate.Month, 1);
            fromDate = fromDate.AddDays(-1);

            // *** Create To Date ***
            DateTime toDate = DateTime.Now.AddDays(1);

            // *** Get data from VistA ***
            PregnancyOutcomeResult outcomeResult = this.DashboardRepository.Pregnancy.GetPregnancyOutcomes(fromDate, toDate, 1, 100);

            // *** Set the starting working date ***
            DateTime workingDate = fromDate.AddDays(1);

            // *** Do six months work ***
            for (int i = 0; i < 7; i++)
            {
                // *** Get the name of the month ***
                string monthName = CultureInfo.CurrentCulture.DateTimeFormat.GetMonthName(workingDate.Month);

                // *** Add the name to the barData ***
                barData.Labels.Add(monthName);

                // *** Initialize counts ***
                int live = 0;
                int other = 0;

                // *** If we have some tracked patients, count the ones that match month/year ***
                if (outcomeResult.Success)
                    if (outcomeResult.PregnancyOutcomes != null)
                    {
                        // *** Get count for live deliveries ***
                        live = outcomeResult.PregnancyOutcomes.Count( p => p.EndDate.Month == workingDate.Month 
                            && ((p.OutcomeType == PregnancyOutcomeType.FullTermDelivery) || 
                            (p.OutcomeType == PregnancyOutcomeType.PretermDelivery)));

                        // *** Get count for all other outcomes ***
                        other = outcomeResult.PregnancyOutcomes.Count( p => p.EndDate.Month == workingDate.Month 
                                && (p.OutcomeType != PregnancyOutcomeType.FullTermDelivery) && 
                                (p.OutcomeType != PregnancyOutcomeType.PretermDelivery));
                    }

                // *** Add the counts ***
                liveDataSet.Data.Add(live);
                otherDataSet.Data.Add(other);

                // *** Go to the next month ***
                workingDate = workingDate.AddMonths(1);
            }

            return barData; 
        }        
    }
}
