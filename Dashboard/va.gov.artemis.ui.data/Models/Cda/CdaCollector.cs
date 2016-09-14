using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.CDA.ValueSets;
using VA.Gov.Artemis.UI.Data.Brokers;
using VA.Gov.Artemis.UI.Data.Brokers.Cda;
using VA.Gov.Artemis.UI.Data.Brokers.Education;
using VA.Gov.Artemis.UI.Data.Brokers.Observations;
using VA.Gov.Artemis.UI.Data.Brokers.Patient;
using VA.Gov.Artemis.UI.Data.Brokers.Pregnancy;
using VA.Gov.Artemis.UI.Data.Brokers.Radiology;
using VA.Gov.Artemis.UI.Data.Brokers.Vpr;
using VA.Gov.Artemis.UI.Data.Models.Education;
using VA.Gov.Artemis.UI.Data.Models.Radiology;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.UI.Data.Models.Cda
{
    public class CdaCollector
    {
        private IDashboardRepository dashboardRepository { get; set; }

        public CdaCollector(IDashboardRepository repo)
        {
            this.dashboardRepository = repo; 
        }

        public CdaSourceResult GetSource(CdaOptions options)
        {
            // *** Collect the source data in a source object ***

            CdaSourceResult returnVal = new CdaSourceResult();

            // *** Create new document id ***
            returnVal.Source.DocumentId = Guid.NewGuid().ToString("B");

            // *** Get CDA settings ***
            CdaSettingsResult result = this.dashboardRepository.Settings.GetCdaSettings();

            // *** Add results to return ***
            returnVal.Success = result.Success; 
            returnVal.Message = result.Message; 

            if (result.Success)
            {
                // *** Add CDA settings to return ***
                returnVal.Source.ManufacturerModelName = result.ManufacturerModelName;
                returnVal.Source.SoftwareName = result.SoftwareName;
                returnVal.Source.ProviderOrganizationPhone = result.ProviderOrganizationPhone;

                //// *** Get the VPR data ***
                //VprOperationResult vprResult = this.dashboardRepository.Vpr.GetVprData(options);

                //// *** Add results to return ***
                //returnVal.Success = vprResult.Success; 
                //returnVal.Message = vprResult.Message;

                //// *** Add vpr data to return ***
                //if (result.Success)
                //    returnVal.Source.VprData = vprResult.VprData;

                // *** Add options to return ***
                returnVal.Source.Options = options; 

                // *** Add pregnancies ***
                string pregIen = (options.DocumentType == CDA.IheDocumentType.PPVS) ? options.SelectedItemIen : "";

                PregnancyListResult pregResult = this.dashboardRepository.Pregnancy.GetPregnancies(options.Patient.Dfn, pregIen);

                if (pregResult.Success)
                    returnVal.Source.Pregnancies = pregResult.Pregnancies;
                else
                    returnVal.SetResult(false, pregResult.Message); 

                // *** Add pregnancy status ***
                PatientDemographicsResult patResult = this.dashboardRepository.Patients.GetPatientDemographics(options.Patient.Dfn);

                if (patResult.Success)
                    returnVal.Source.Patient = patResult.Patient;
                else if (returnVal.Success)
                    returnVal.SetResult(false, patResult.Message); 

                // *** Get Observations By Date Range ***

                string tiuIen = ""; 
                string fromDate = "";
                string toDate = "";

                if (options.DocumentType == CDA.IheDocumentType.PPVS)
                {
                    // TODO: Add date range when working...

                    // *** Translate a pregnancy into a date range ***
                    // *** The date range should include the postpartum period ***
                    //options.SelectedDateRange = CdaOptions.DateRange.Custom;
                    //options.FromDate = returnVal.Source.Pregnancies[0].EndDate.AddDays(-1);
                    //TimeSpan ts = DateTime.Now - options.FromDate;
                    
                    //if (ts.TotalDays > 60)
                    //    options.ToDate = options.FromDate.AddDays(42);
                    //else
                    //    options.ToDate = DateTime.Now.AddDays(1);

                    //toDate = options.ToDate.ToString(VistaDates.VistADateOnlyFormat);
                    //fromDate = options.FromDate.ToString(VistaDates.VistADateOnlyFormat);

                    // TODO: Clear pregIen ? 
                    //pregIen = ""; 
                                        
                }
                else if (options.SelectedItemIen == "-1")
                {
                    tiuIen = "";
                    if (options.FromDate != DateTime.MinValue)
                        fromDate = options.FromDate.ToString(VistaDates.VistADateOnlyFormat);

                    if (options.ToDate != DateTime.MinValue)
                        toDate = options.ToDate.ToString(VistaDates.VistADateOnlyFormat);                 
                }
                else
                    tiuIen = options.SelectedItemIen; 

                ObservationListResult observationsResult = this.dashboardRepository.Observations.GetObservations(options.Patient.Dfn, pregIen, "", tiuIen, fromDate, toDate, "", -1, -1);

                if (observationsResult.Success)
                {
                    returnVal.Source.Observations = observationsResult.Observations;

                    // *** For PPVS remove observations which belong to pregnancies other than the one chosen by the user ***
                    if (options.DocumentType == CDA.IheDocumentType.PPVS)
                        returnVal.Source.Observations = returnVal.Source.Observations
                            .Where(o => o.PregnancyIen == "" || o.PregnancyIen == options.SelectedItemIen)
                            .ToList();
                }

                // *** Get the VPR data ***
                VprOperationResult vprResult = this.dashboardRepository.Vpr.GetVprData(options);

                // *** Add results to return ***
                returnVal.Success = vprResult.Success;
                returnVal.Message = vprResult.Message;

                // *** Add vpr data to return ***
                if (result.Success)
                    returnVal.Source.VprData = vprResult.VprData;

                ValueSetType[] valueSets = null; 
                 
                if (options.DocumentType == CDA.IheDocumentType.APHP)
                {
                    // *** Get Value Sets Needed for APHP ***
                    valueSets = new ValueSetType[]
                    { 
                        ValueSetType.AntepartumEducation, 
                        ValueSetType.HistoryOfInfection, 
                        ValueSetType.HistoryOfPastIllness, 
                        ValueSetType.AntepartumFamilyHistory, 
                        ValueSetType.MenstrualHistory
                    };

                }
                else if (options.DocumentType == CDA.IheDocumentType.APE)
                {
                    valueSets = new ValueSetType[] { ValueSetType.AntepartumEducation }; 

                    returnVal.Source.EducationItems = this.GetEducationItems(options.Patient.Dfn, options.FromDate, options.ToDate);
                }

                if (valueSets != null)
                    foreach (var valueSetType in valueSets)
                    {
                        CdaValueSetResult vsResult = this.dashboardRepository.CdaDocuments.GetValueSet(valueSetType);
                        if (vsResult.Success)
                            returnVal.Source.ValueSets.Add(valueSetType, vsResult.ValueSet);
                    }

                if (options.DocumentType == CDA.IheDocumentType.XDR_I)
                {
                    // *** Get Radiology Reports ***
                    RadiologyReportsResult radResult = this.dashboardRepository.Radiology.GetReports(options.Patient.Dfn);

                    if (radResult.Success)
                    {
                        if (radResult.Items.Count > 0)
                        {
                            string tempDate = Util.Piece(options.SelectedItemIen, "|", 1);
                            string tempProc = Util.Piece(options.SelectedItemIen, "|", 2); 
                            DateTime selected;
                            if (DateTime.TryParse(tempDate, out selected))
                            {
                                RadiologyReport rpt = radResult.Items.FirstOrDefault(r => r.ExamDateTime == selected && r.Procedure == tempProc);

                                returnVal.Source.ImageReportText = rpt.Detail;
                            }
                        }
                    }
                }
            }
            
            return returnVal;
        }

        private List<PatientEducationItem> GetEducationItems(string dfn, DateTime fromDate, DateTime toDate)
        {
            List<PatientEducationItem> returnList = new List<PatientEducationItem>();

            PatientEducationItemsResult edResult = this.dashboardRepository.Education.GetPatientItems(dfn, "", fromDate , toDate, EducationItemType.Unknown, 1, 1000);

            if (edResult.Success)
                returnList = edResult.Items; 

            return returnList; 
        }
    }
}
