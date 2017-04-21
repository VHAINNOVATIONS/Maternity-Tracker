// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using VA.Gov.Artemis.Commands.Dsio.Observation;
using VA.Gov.Artemis.UI.Data.Brokers;
using VA.Gov.Artemis.UI.Data.Brokers.Observations;
using VA.Gov.Artemis.UI.Data.Brokers.Pregnancy;
using VA.Gov.Artemis.UI.Data.Models.Edd;
using VA.Gov.Artemis.UI.Data.Models.Observations;
using VA.Gov.Artemis.UI.Data.Models.Outcomes;
using VA.Gov.Artemis.UI.Data.Models.Pregnancy;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.UI.Controllers
{
    public class PregnancyUtilities
    {
        // *** Pregnancy Filter Constants ***
        public const string PregnancyFilterAll = "A";
        public const string PregnancyFilterCurrent = "C";
        public const string NotAssociatedMessage = "Not associated with a pregnancy";

        //private IDashboardRepository DashboardRepository { get; set; }

        //public PregnancyUtilities(IDashboardRepository repo)
        //{
        //    this.DashboardRepository = repo; 
        //}

        public static PregnancyDetails GetWorkingPregnancy(IDashboardRepository repo, string dfn, string pregIen)
        {
            PregnancyDetails returnVal = null;

            // *** First try the pregnancy ien passed in ***
            if (!string.IsNullOrWhiteSpace(pregIen))
            {
                PregnancyListResult pregResult = repo.Pregnancy.GetPregnancies(dfn, pregIen);

                if (pregResult.Success)
                    if (pregResult.Pregnancies != null)
                        if (pregResult.Pregnancies.Count > 0)
                            returnVal = pregResult.Pregnancies[0];
            }

            // *** Then try to get the current/most-recent ***
            if (returnVal == null)
            {
                PregnancyResult pregResult = repo.Pregnancy.GetCurrentOrMostRecentPregnancy(dfn);

                if (pregResult.Success)
                    returnVal = pregResult.Pregnancy;
            }

            return returnVal;
        }

        public static PregnancyOutcomeType GetPregnancyOutcome(IDashboardRepository repo, string patientDfn, string pregIen)
        {
            PregnancyOutcomeType returnVal = PregnancyOutcomeType.Unknown;

            ObservationListResult obsResult = repo.Observations.GetObservations(patientDfn, pregIen, "", "", "", "", "Outcome", 0, 0);

            if (obsResult.Success)
                if (obsResult.Observations != null)
                    foreach (Observation obs in obsResult.Observations)
                        if (obs.Code == ObservationsFactory.OutcomeTypeCode)
                        {
                            PregnancyOutcomeType outType = PregnancyOutcomeType.Unknown;
                            if (Enum.TryParse<PregnancyOutcomeType>(obs.Value, true, out outType))
                                returnVal = outType;
                        }

            return returnVal;
        }

        public static PregnancyDetails GetPregnancy(IDashboardRepository repo, string patientDfn, string pregIen)
        {
            PregnancyDetails returnVal = null;

            // *** Get pregnancy ***
            PregnancyListResult pregResult = repo.Pregnancy.GetPregnancies(patientDfn,pregIen);

            // *** Check result ***
            if (pregResult.Success)
                if (pregResult.Pregnancies != null)
                    if (pregResult.Pregnancies.Count == 1)
                        returnVal = pregResult.Pregnancies[0];

            // *** Also, get lmp, fetus count ***
            if (returnVal != null)
            {
                PregnancyDetails tempPreg = GetPregnancyObservationData(repo, patientDfn, pregIen);

                returnVal.Lmp = tempPreg.Lmp;
                returnVal.LmpDateType = tempPreg.LmpDateType; 
                returnVal.FetusBabyCount = tempPreg.FetusBabyCount; 

                // *** Will return EDD Basis and Is Final ***
                returnVal.EddBasis = tempPreg.EddBasis;
                returnVal.EddIsFinal = tempPreg.EddIsFinal; 
            }

            return returnVal;
        }

        public static PregnancyDetails GetPregnancyObservationData(IDashboardRepository repo, string patientDfn, string pregIen) 
        {
            PregnancyDetails returnVal = new PregnancyDetails(); 

            // NOTE: Only populates LMP and FetusBabyCount ***

            // *** Also, get lmp, fetus count ***
            ObservationListResult obsResult = repo.Observations.GetObservations(patientDfn, pregIen, "", "", "", "", "", 0, 0);

            if (obsResult.Success)
                if (obsResult.Observations != null)
                {
                    //// *** 10/28/2014 Add sort so that newest gets applied last ***
                    //obsResult.Observations.Sort(delegate(DsioObservation o, DsioObservation p)
                    //{
                    //    DateTime oDate = VistaDates.ParseDateString(o.Date, VistaDates.VistADateFormatFour);
                    //    DateTime pDate = VistaDates.ParseDateString(p.Date, VistaDates.VistADateFormatFour);

                    //    return oDate.CompareTo(pDate);
                    //});
                    DateTime newestIsFinalEddDate = DateTime.MinValue; 

                    foreach (Observation tempObs in obsResult.Observations)
                        if ((tempObs.Code == EddUtility.LmpDateCode) || (tempObs.Code == EddUtility.LmpDateCodeSnomed))
                        {
                            if (tempObs.Value.Contains("|"))
                            {
                                returnVal.Lmp = Util.Piece(tempObs.Value, "|", 1);

                                if (Util.Piece(tempObs.Value, "|", 2) == "A")
                                    returnVal.LmpDateType = ClinicalDateType.Approximate;
                                else
                                    returnVal.LmpDateType = ClinicalDateType.Known; 
                            }
                            else if (string.IsNullOrWhiteSpace(tempObs.Value))
                            {
                                returnVal.LmpDateType = ClinicalDateType.Unknown;
                                returnVal.Lmp = "";
                            }
                            else
                            {
                                returnVal.LmpDateType = ClinicalDateType.Known; 
                                returnVal.Lmp = tempObs.Value;
                            }

                            //if (string.IsNullOrWhiteSpace(returnVal.Lmp))
                            //    returnVal.LmpDateType = ClinicalDateType.Unknown; 
                        }
                        else if (tempObs.Code == ObservationsFactory.FetusBabyCountCode)
                        {
                            int count;
                            if (int.TryParse(tempObs.Value, out count))
                                returnVal.FetusBabyCount = count;
                        }
                        else if (string.Equals(tempObs.Category, "EDD", StringComparison.InvariantCultureIgnoreCase))
                        {
                            EddHistoryItem eddItem = EddUtility.GetHistoryItem(tempObs);

                            if (tempObs.EntryDate > newestIsFinalEddDate)
                                if (eddItem.IsFinal)
                                {
                                    returnVal.EddBasis = eddItem.Criteria;
                                    returnVal.EddIsFinal = eddItem.IsFinal;
                                    newestIsFinalEddDate = tempObs.EntryDate;
                                }
                        }
                }

            return returnVal; 
        }

        public static object[] ParseLmp(string value)
        {
            object[] returnVal = { "", "" };

            //if (value.Contains("|"))
            //{
            //    returnVal[0] = Util.Piece(value, "|", 1);

            //    if (Util.Piece(value, "|", 2) == "A")
            //        returnVal[1] = ClinicalDateType.Approximate;
            //    else
            //        returnVal[1] = ClinicalDateType.Known;
            //}
            //else
            //    returnVal[0] = value;

            if (value.Contains("|"))
            {
                returnVal[0] = Util.Piece(value, "|", 1);

                if (Util.Piece(value, "|", 2) == "A")
                    returnVal[1] = ClinicalDateType.Approximate;
                else
                    returnVal[1] = ClinicalDateType.Known;
            }
            else if (string.IsNullOrWhiteSpace(value))
            {
                returnVal[1] = ClinicalDateType.Unknown;
                returnVal[0] = "";
            }
            else
            {
                returnVal[1] = ClinicalDateType.Known;
                returnVal[0] = value;
            }

            return returnVal; 
        }

        //public static List<BabyDetails> GetBabyDetails(IDashboardRepository repo, string patientDfn, string pregIen, string babyNum)
        //{
        //    List<BabyDetails> returnVal = new List<BabyDetails>();

        //    // *** Get the observation category ***
        //    string cat = new BabyDetails().ObservationCategory;

        //    // *** Get observations ***
        //    ObservationListResult obsResult = repo.Observations.GetObservationListByCategory(patientDfn, pregIen, cat);

        //    // *** Check for success ***
        //    if (obsResult.Success)
        //    {
        //        // *** Create a list of observations for this babyNum ***
        //        List<DsioObservation> babyObservations = new List<DsioObservation>();

        //        if (obsResult.Observations != null)
        //            foreach (DsioObservation obs in obsResult.Observations)
        //                if (obs.BabyNum == babyNum)
        //                    babyObservations.Add(obs);

        //        // *** Construct baby details ***
        //        returnVal = new BabyDetails(babyObservations);

        //        returnVal.BabyNum = babyNum; 
        //    }

        //    return returnVal; 
        //}

        public static List<PregnancyDetails> GetPregnancies(IDashboardRepository repo, string dfn)
        {
            List<PregnancyDetails> returnList = new List<PregnancyDetails>();

            // *** Get pregnancies ***
            PregnancyListResult result = repo.Pregnancy.GetPregnancies(dfn, "");

            if (result.Success)
                if (result.Pregnancies != null) 
                    if (result.Pregnancies.Count > 0)
                        returnList.AddRange(result.Pregnancies);

            return returnList;
        }

        public static Dictionary<string, string> GetPregnanciesSelection(IDashboardRepository repo, string dfn)
        {
            Dictionary<string, string> returnVal = new Dictionary<string, string>();

            List<PregnancyDetails> pregList = PregnancyUtilities.GetPregnancies(repo, dfn);

            returnVal = PregnancyUtilities.GetPregnanciesSelection(pregList, false);

            return returnVal;
        }

        public static Dictionary<string, string> GetPregnanciesSelection(List<PregnancyDetails> pregList, bool filterList)
        {
            // *** Get a selection dictionary used to create a SelectList ***

            Dictionary<string, string> returnVal = new Dictionary<string, string>();
                        
            if (!filterList)
                returnVal.Add("", NotAssociatedMessage);

            // *** Get the pregnancies ***
            foreach (PregnancyDetails preg in pregList)
                returnVal.Add(preg.Ien, preg.Description);

            // *** If this is a list for a filter, create all item ***
            if (filterList)
                returnVal.Add(PregnancyFilterAll, "All (Unfiltered)");

            return returnVal;
        }

        public static Dictionary<string, string> GetPregnanciesSelectionPpvs(List<PregnancyDetails> pregList)
        {
            // *** Get a selection dictionary used to create a SelectList ***

            Dictionary<string, string> returnVal = new Dictionary<string, string>();

            if (pregList.Count == 0)
                returnVal.Add("", "No pregnancies found");
            else
            {
                returnVal.Add("", "(Select)");

                // *** Get the pregnancies ***
                foreach (PregnancyDetails preg in pregList)
                    returnVal.Add(preg.Ien, preg.Description);
            }

            return returnVal;
        }

        public static string GetValidatedPregnancyFilter(List<PregnancyDetails> pregList, string originalFilter)
        {
            string returnFilter = "";
            bool specificPreg = false; 

            // *** First, is it even a valid entry ***
            bool valid = false; 
            switch (originalFilter)
            {
                case PregnancyUtilities.PregnancyFilterAll:
                case PregnancyUtilities.PregnancyFilterCurrent:
                    valid = true; 
                    break; 
                default:
                    int tempIen = -1;
                    if (int.TryParse(originalFilter, out tempIen))
                    {
                        valid = true;
                        specificPreg = true;
                    }
                    break;
            }

            if (!valid)
                returnFilter = PregnancyFilterCurrent;
            else
                returnFilter = originalFilter; 
            
            // *** Check that pregnancy exists ***
            if (specificPreg)
            {
                bool match = false;
                foreach (var preg in pregList)
                    if (preg.Ien == returnFilter)
                        match = true;

                if (!match)
                {
                    returnFilter = PregnancyFilterCurrent;
                    specificPreg = false;
                }
            }

            // *** Next see if we have a current ***
            if (returnFilter == PregnancyFilterCurrent)
                foreach (var preg in pregList)
                    if (preg.RecordType == PregnancyRecordType.Current)
                        returnFilter = preg.Ien; 

            // *** If still current, then revert to all ***
            if (returnFilter == PregnancyFilterCurrent)
                returnFilter = PregnancyFilterAll; 
            
            return returnFilter;
        }

        internal static OutcomeDetails GetOutcomeDetails(IDashboardRepository repo, string dfn, string pregIen, PregnancyOutcomeType outcomeType)
        {
            OutcomeDetails returnDetails = new OutcomeDetails(); 

            ObservationListResult obsResult;

            switch (outcomeType)
            {
                case PregnancyOutcomeType.SpontaneousAbortion:
                    obsResult = repo.Observations.GetObservationListByCategory(dfn, pregIen, returnDetails.SpontaneousAbortionDetails.ObservationCategory);

                    if (obsResult.Success)
                        if (obsResult.Observations != null)
                            returnDetails.SpontaneousAbortionDetails = new Data.Models.Outcomes.SpontaneousAbortionOutcome(obsResult.Observations);

                    break;

                case PregnancyOutcomeType.PregnancyTermination:
                    obsResult = repo.Observations.GetObservationListByCategory(dfn, pregIen, returnDetails.TerminationDetails.ObservationCategory);

                    if (obsResult.Success)
                        if (obsResult.Observations != null)
                            returnDetails.TerminationDetails = new Data.Models.Outcomes.PregnancyTerminationOutcome(obsResult.Observations);
                    break;

                case PregnancyOutcomeType.StillBirth:
                    obsResult = repo.Observations.GetObservationListByCategory(dfn, pregIen, returnDetails.StillbirthDetails.ObservationCategory);

                    if (obsResult.Success)
                        if (obsResult.Observations != null)
                            returnDetails.StillbirthDetails = new Data.Models.Outcomes.StillbirthOutcome(obsResult.Observations);
                    break;

                case PregnancyOutcomeType.Ectopic:
                    obsResult = repo.Observations.GetObservationListByCategory(dfn, pregIen, returnDetails.EctopicDetails.ObservationCategory);

                    if (obsResult.Success)
                        if (obsResult.Observations != null)
                            returnDetails.EctopicDetails = new Data.Models.Outcomes.EctopicOutcome(obsResult.Observations);

                    break;

                case PregnancyOutcomeType.PretermDelivery:
                case PregnancyOutcomeType.FullTermDelivery:

                    obsResult = repo.Observations.GetObservationListByCategory(dfn, pregIen, returnDetails.DeliveryDetails.ObservationCategory);

                    if (obsResult.Success)
                        if (obsResult.Observations != null)
                            returnDetails.DeliveryDetails = new Data.Models.Outcomes.DeliveryDetails(obsResult.Observations);
                    break;
            }

            returnDetails.OutcomeType = outcomeType; 

            return returnDetails; 
        }
    }

    
}