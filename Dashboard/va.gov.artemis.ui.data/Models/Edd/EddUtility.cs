using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.CDA.Common;
using VA.Gov.Artemis.Commands.Dsio.Observation;
using VA.Gov.Artemis.UI.Data.Brokers;
using VA.Gov.Artemis.UI.Data.Models.Observations;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.UI.Data.Models.Edd
{
    public class EddUtility
    {
        //public static string[] EddObservationTypeDescription = new string[] { "None", "Last Menstrual Period", "Conception Date (IUI, IVF, Spontaneous)", "Gestational Age", "Estimated Delivery Date" };
        //public static string[] EddObservationTypeDescriptionShort = new string[] { "None", "LMP", "Conception", "GA", "EDD" };

        //public static string[] EddBasisDescription = new string[] { "None", "Conception Date (IUI, IVF, Spontaneous)", "Last Menstrual Period", "Last Menstrual Period + Ultrasound", "First Trimester Ultrasound", "Second Trimester Ultrasound", "Third Trimester Ultrasound", "Other" };
        //public static string[] EddBasisDescriptionShort = new string[] { "", "Conception", "LMP", "LMP + US", "US Tri 1", "US Tri 2", "US Tri 3", "Other" };

        public const string LmpDateDescription = "Last Menstrual Period Start Date";
        public const string LmpDateCode = "8665-2";
        public const string LmpDateCodeSnomed = "21840007"; 

        public const string ConceptionDateCode = "33067-0"; // *** Used to Indicate IVF ***

        public const string EstimateGestationalAgeDescription = "Gestational Age Estimated"; 
        public const string EstimatedGestationalAgeCode = "11884-4";
        //private const string EstimatedGestationalAgeFromUltrasoundCode = "11888-5";
        public const string EmbryoTransferCode = "EmbryoTransfer";
        public const string OtherEddCode = "OtherEdd"; 

        public const string EddFromConceptionCode = "53692-0";
        public const string EddFromLMPCode = "11779-6";
        public const string EddFromUltrasoundCompositeCode = "11781-2";

        public const string EddCodeDescription = "Estimated Delivery Date"; 
        public const string EddCode = "11778-8"; 

        public const string EddFromLMPDescription = "Delivery Date Estimated From Last Menstrual Period";

        public const string IheOtherEDDCode = "(xx-EDD-by-PE)"; 

        public static string GetFormattedGestationalAge(string totalDays)
        {
            string returnVal = "N/A";

            int gaInDays = -1;
            
            if (int.TryParse(totalDays, out gaInDays))
            {
                if (gaInDays <= 42 * 7)
                {
                    int wholeWeeks = (int)gaInDays / 7;
                    int remainderDays = gaInDays % 7;

                    returnVal = string.Format("{0} weeks {1} days", wholeWeeks, remainderDays);
                }
            }

            return returnVal;
        }

        public static string GetShortGestationalAge(string totalDays)
        {
            string returnVal = "";

            int gaInDays = -1;

            if (int.TryParse(totalDays, out gaInDays))
            {
                if (gaInDays <= 42 * 7)
                {
                    int wholeWeeks = (int)gaInDays / 7;
                    int remainderDays = gaInDays % 7;

                    returnVal = string.Format("{0}w {1}d", wholeWeeks, remainderDays);
                }
            }

            return returnVal;
        }
        
        public static EddHistoryItem GetHistoryItem(Observation observation)
        {
            EddHistoryItem returnVal = new EddHistoryItem();

            returnVal.Ien = observation.Ien;
            DateTime enteredOnDate = observation.EntryDate; //VistaDates.ParseDateString(dsioObservation.Date, VistaDates.VistADateFormatFour);
            returnVal.EnteredOn = enteredOnDate.ToString(VistaDates.VistADateOnlyFormat);
            returnVal.EnteredBy = observation.EnteredBy;
            returnVal.Imported = (string.IsNullOrWhiteSpace(observation.ExchangeDocumentIen)) ? false : true; 

            returnVal.Criteria = GetEddCriteria(observation); 

            string valPiece1 = Util.Piece(observation.Value, "|", 1);
            string valPiece2 = Util.Piece(observation.Value, "|", 2);
            string valPiece3 = Util.Piece(observation.Value, "|", 3); 

            bool isFinal = false;
            bool.TryParse(valPiece2, out isFinal);
            returnVal.IsFinal = isFinal;

            returnVal.EventDate = valPiece1; 

            EddItemType itemType = GetItemType(observation.Code); 

            switch (itemType)
            {
                case EddItemType.EddOnly:
                    returnVal.Edd = valPiece1;
                    returnVal.EventDate = ""; 
                    break; 
                case EddItemType.Ultrasound:
                case EddItemType.Other:
                    returnVal.GestationalAge = EddUtility.GetFormattedGestationalAge(valPiece3);
                    returnVal.Edd = EddUtility.GetEddFromGA(valPiece1, valPiece3);
                    break; 
                case EddItemType.LMP:
                    returnVal.Edd = valPiece1;
                    returnVal.EventDate = EddUtility.GetLmpFromEdd(valPiece1);
                    returnVal.Criteria = "Last Menstrual Period"; 
                    break; 
                default:
                    returnVal.Edd = EddUtility.GetEddFromDate(itemType, valPiece1);
                    break; 
            }

            return returnVal;
        }

        public static Observation GetDsioObservation(string patientDfn, string pregIen, EddItem item)
        {
            Observation returnVal = new Observation();

            string twoPartFormat = "{0}|{1}";
            string threePartFormat = "{0}|{1}|{2}";

            returnVal.PatientDfn = patientDfn;
            returnVal.PregnancyIen = pregIen;
            //returnVal.Date = DateTime.Now.ToString(VistaDates.VistADateFormatFour);
            returnVal.EntryDate = DateTime.Now; 
            returnVal.Description = item.Criteria;
            returnVal.Category = "EDD";

            item.EventDate = VistaDates.StandardizeDateFormat(item.EventDate);
            item.EDD = VistaDates.StandardizeDateFormat(item.EDD);

            switch (item.ItemType)
            {
                case EddItemType.Conception:
                    returnVal.Code = ConceptionDateCode;
                    returnVal.CodeSystem = CodingSystem.Loinc; //DsioObservation.LoincCodeSystem;
                    returnVal.Value = string.Format(twoPartFormat, item.EventDate, item.IsFinal);
                    break;

                case EddItemType.LMP:
                    // *** Create an EDD from LMP observation ***
                    returnVal.Code = EddFromLMPCode;
                    returnVal.CodeSystem = CodingSystem.Loinc;
                    returnVal.Value = string.Format(twoPartFormat, item.EDD, item.IsFinal);
                    returnVal.Description = EddFromLMPDescription;
                    break;

                case EddItemType.Ultrasound:
                    returnVal.Description = EstimateGestationalAgeDescription; 
                    returnVal.Code = EstimatedGestationalAgeCode;
                    returnVal.CodeSystem = CodingSystem.Loinc;  
                    returnVal.Value = string.Format(threePartFormat, item.EventDate, item.IsFinal, item.GestationalAgeTotalDays);
                    break;

                case EddItemType.Embryo:
                    returnVal.Code = EmbryoTransferCode;
                    returnVal.CodeSystem = CodingSystem.Other;
                    returnVal.Value = string.Format(twoPartFormat, item.EventDate, item.IsFinal);
                    break;

                case EddItemType.Other:
                    returnVal.Code = OtherEddCode;
                    returnVal.CodeSystem = CodingSystem.Other;
                    returnVal.Value = string.Format(threePartFormat, item.EventDate, item.IsFinal, item.GestationalAgeTotalDays);
                    break;

                case EddItemType.EddOnly:
                    returnVal.Description = EddCodeDescription; 
                    returnVal.Code = EddCode;
                    returnVal.CodeSystem = CodingSystem.Loinc; 
                    returnVal.Value = string.Format(twoPartFormat, item.EDD, item.IsFinal);
                    break;
            }

            return returnVal;
        }

        public static string GetGestationalAge(DateTime edd)
        {
            string returnVal = "";

            if (edd != DateTime.MinValue)
            {
                int ga = GetGestationalAgeInDays(edd);

                if (ga <= 42 * 7)
                {
                    int wholeWeeks = (int)ga / 7;
                    int remainderDays = ga % 7;

                    returnVal = string.Format("{0}w {1}d", wholeWeeks, remainderDays);
                }
            }

            return returnVal;
        }

        public static int GetTrimester(DateTime edd)
        {
            int returnVal = -1;

            if (edd != DateTime.MinValue)
            {
                int ga = GetGestationalAgeInDays(edd);

                if (ga > 42 * 7)
                    returnVal = -1;
                else
                {
                    if (ga <= (14 * 7))
                        returnVal = 1;
                    else if (ga <= (28 * 7))
                        returnVal = 2;
                    else
                        returnVal = 3;
                }
            }

            return returnVal;
        }

        public static string GetGestationalAgeOn(DateTime edd, DateTime on)
        {
            string returnVal = "";

            if ((edd != DateTime.MinValue) && (on != DateTime.MinValue))
            {
                DateTime startDate = edd.AddDays(-280);

                TimeSpan difference = on.Subtract(startDate);
                int gaTotalDays = (int)difference.TotalDays;

                int wks = gaTotalDays / 7;
                int dys = gaTotalDays % 7;

                returnVal = string.Format("{0} weeks {1} days", wks, dys); 
            }
            return returnVal; 
        }

        public static string GetEddFromDate(EddItemType itemType, string valPiece1)
        {
            string returnVal = "";

            DateTime tempDate = VistaDates.ParseDateString(valPiece1, VistaDates.VistADateOnlyFormat);

            DateTime edd = DateTime.MinValue;

            if (tempDate != DateTime.MinValue)
            {
                switch (itemType)
                {
                    case EddItemType.LMP:
                        edd = tempDate.AddDays(280);
                        break;
                    case EddItemType.Conception:
                        edd = tempDate.AddDays(266);
                        break;
                    case EddItemType.Embryo:
                        edd = tempDate.AddDays(262);
                        break;
                }

                returnVal = edd.ToString(VistaDates.VistADateOnlyFormat);
            }

            return returnVal; 
        }

        public static string GetLmpFromEdd(string edd)
        {
            string returnVal = "";

            DateTime tempDate = VistaDates.ParseDateString(edd, VistaDates.VistADateOnlyFormat);

            if (tempDate != DateTime.MinValue)
            {
                DateTime lmp = tempDate.AddDays(-280);
                returnVal = lmp.ToString(VistaDates.VistADateOnlyFormat);
            }

            return returnVal; 
        }

        public static string GetEddFromGA(string obsDate, string gaDays)
        {
            string returnVal = ""; 

            DateTime tempDate = VistaDates.ParseDateString(obsDate, VistaDates.VistADateOnlyFormat);

            if (tempDate != DateTime.MinValue)
            {
                int gaTotalDays = -1;
                if (int.TryParse(gaDays, out gaTotalDays))
                {
                    // 40 weeks, 0 days = 280 days
                    // 280 days - GA 
                    int remainDays = 280 - gaTotalDays;

                    // Add remain days to entered date 
                    DateTime edd = tempDate.AddDays(remainDays);

                    returnVal = edd.ToString(VistaDates.VistADateOnlyFormat);
                }
            }

            return returnVal; 
        }

        public static EddItemType GetItemType(string code)
        {
            EddItemType returnVal = EddItemType.Unknown;

            switch (code) 
            {
                case EddFromLMPCode:
                    returnVal = EddItemType.LMP;
                    break; 
                case ConceptionDateCode:
                    returnVal = EddItemType.Conception;
                    break; 
                case EstimatedGestationalAgeCode:
                    returnVal = EddItemType.Ultrasound;
                    break; 
                case EmbryoTransferCode:
                    returnVal = EddItemType.Embryo;
                    break; 
                case OtherEddCode:
                    returnVal = EddItemType.Other;
                    break; 
                case EddCode:
                    returnVal = EddItemType.EddOnly;
                    break;
            }

            return returnVal;
        }

        public static int GetGestationalAgeInDays(DateTime edd)
        {
            int returnVal = -1;

            // *** Count number of days until EDD ***
            TimeSpan difference = edd.Subtract(DateTime.Now);
            int daysUntilEdd = (int)difference.TotalDays + 1;

            // *** 40 Weeks * 7 days/week = total pregnancy days - days left ***
            returnVal = 40 * 7 - daysUntilEdd;

            return returnVal;
        }

        /// <summary>
        /// Get core value when value contains pipe delimited data
        /// </summary>
        /// <param name="observation">The observation to examine</param>
        /// <returns>The core value for this observation</returns>
        public static string GetObservationCoreValue(Observation observation)
        {
            string returnVal = "";

            EddHistoryItem tempItem = GetHistoryItem(observation);

            EddItemType itemType = GetItemType(observation.Code);

            switch (itemType)
            {
                case EddItemType.Ultrasound:
                case EddItemType.Other:
                    int days = -1;
                    string piece3 = Util.Piece(observation.Value, "|", 3);
                    if (int.TryParse(piece3, out days))
                    {
                        int wholeWeeks = (int)days / 7; 
                        returnVal = wholeWeeks.ToString();
                    }
                    break;
                default:
                    returnVal = tempItem.Edd; 
                    break;
            }

            return returnVal; 
        }

        /// <summary>
        /// Gets the EDD criteria for an observation based on code
        /// </summary>
        /// <param name="observation">The observation to use</param>
        /// <returns>The criteria</returns>
        public static string GetEddCriteria(Observation observation)
        {
            string returnVal = "";

            string[] itemTypeDescription = new string[]{ "Unknown", "Last Menstrual Period", "Estimated Conception Date", "Ultrasound", "Embryo Transfer", "Other", "Unknown"};

            // *** Get item type ***
            EddItemType itemType = GetItemType(observation.Code);

            // *** If item type is other, use user-entered description ***
            // *** Otherwise, use text from array above ***
            if (itemType == EddItemType.Other)
                returnVal = observation.Description; 
            else
                returnVal = itemTypeDescription[(int)itemType];

            return returnVal; 
        }

    }
}
