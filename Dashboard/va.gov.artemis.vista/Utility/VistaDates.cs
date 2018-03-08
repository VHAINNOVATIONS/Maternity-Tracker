// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Globalization;

namespace VA.Gov.Artemis.Vista.Utility
{
    public class VistaDates
    {
        //public const string VistADateFormatOne = "MMM d, yyyy@HH:mm:ss";
        public const string VistADateFormatTwo = "M/d/yyyy@HH:mm:ss";
        //public const string VistADateFormatThree = "MMM d, yyyy@HH:mm";
        public const string VistADateFormatFour = "MM/dd/yyyy@HH:mm:ss";
        public const string VistADateFormatFive = "MM/dd/yyyy HH:mm";
        public const string VistADateFormatSix = "MMM d, yyyy";
        public const string VistADateFormatSeven = "MMM dd, yyyy@HH:mm";
        public const string VistADateFormatEight = "MM/dd/yyyy@HH:mm";

        //SEP 01, 2014@08:59:07
        public const string VistADateFormatOne = "MMM dd, yyyy@HH:mm:ss";

        public const string VistADateOnlyFormat = "MM/dd/yyyy";

        public const string UserDateFormat = "M/d/yyyy";
        public const string UserDateTimeFormat = "M/d/yyyy HH:mm";

        //public const string UserDateFormatWithTime = "M/d/yy HH:mm"; 

        /// <summary>
        /// Date formatting utlity for VistA dates 
        /// </summary>
        /// <param name="originalDate">The date as it comes from VistA</param>
        /// <param name="dateFormat">The date format of the date</param>
        /// <returns></returns>
        public static DateTime ParseDateString(string originalDate, string dateFormat)
        {
            DateTime returnVal = DateTime.MinValue;

            CultureInfo enUS = new CultureInfo("en-US");

            DateTime.TryParseExact(originalDate, dateFormat, enUS, DateTimeStyles.None, out returnVal);

            return returnVal;
        }

        public static string StandardizeDateFormat(string originalDate)
        {
            string returnVal = "";

            DateTime tempDate;

            CultureInfo enUS = new CultureInfo("en-US");

            if (DateTime.TryParse(originalDate, out tempDate))
                returnVal = tempDate.ToString(VistADateOnlyFormat);

            return returnVal;
        }

        public static string CenturyDateFormat(string originalDate)
        {
            string returnVal = "";

            DateTime tempDate;

            if (DateTime.TryParse(originalDate, out tempDate))
            {
                string yyMMdd = tempDate.ToString("yyMMdd");
                string yyyyMMdd = tempDate.ToString("yyyyMMdd");
                string firstTwoDigits = yyyyMMdd.Substring(0, 2);
                //compute how many centuries have past since 1700
                int century = Convert.ToInt32(firstTwoDigits) - 17;
                returnVal = century + yyMMdd;
            }

            return returnVal;
        }

        public static DateTime FlexParse(string originalDate)
        {
            DateTime returnVal = DateTime.MinValue;

            // Try formats date only, with seconds, without
            string[] tryFormats = new string[] { VistADateOnlyFormat, VistADateFormatEight, VistADateFormatFour, VistADateFormatTwo };

            foreach (var format in tryFormats)
            {
                CultureInfo enUS = new CultureInfo("en-US");

                if (DateTime.TryParseExact(originalDate, format, enUS, DateTimeStyles.None, out returnVal))
                    break;
            }

            return returnVal;
        }
    }
}
