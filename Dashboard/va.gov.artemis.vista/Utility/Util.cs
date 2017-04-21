// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.Vista.Utility
{
    public partial class Util
    {
        public static string[] Split(string s)
        {
            s = s.Replace("\r\n", "\r").Replace("\n", "\r");
            return Split(s, "\r");
        }

        public static string Piece(string s, string delim, int piece)
        {
            // *** Return empty string by default ***
            string returnVal = string.Empty;

            // *** Check for nulls ***
            if (!string.IsNullOrWhiteSpace(s))
            {
                // *** Do the split ***
                string[] pieces = s.Split(new string[] { delim }, StringSplitOptions.None);

                // *** Get the proper piece ***
                if (piece > 0 && piece - 1 < pieces.Length)
                    returnVal = pieces[piece - 1];
            }

            return returnVal;
        }

        public static string GetFileManDate(DateTime originalDate)
        {
            // FileMan date format= yyymmdd.hhmms# 

            string returnVal = "";

            if (originalDate != DateTime.MinValue)
            {
                int year = originalDate.Year - 1700;

                returnVal = string.Format("{0}{1:00}{2:00}", year, originalDate.Month, originalDate.Day);

            }
            return returnVal;
        }

        public static string GetFileManDateAndTime(DateTime originalDate)
        {
            // FileMan date format= yyymmdd.hhmms# 

            string returnVal = "";

            if (originalDate != DateTime.MinValue)
            {
                int year = originalDate.Year - 1700;

                returnVal = string.Format("{0}{1:00}{2:00}.{3:00}{4:00}{5}", year, originalDate.Month, originalDate.Day, originalDate.Hour, originalDate.Minute, originalDate.Second);

            }
            return returnVal;
        }

        public static DateTime GetDateTime(string fileManDateTime)
        {
            DateTime returnVal = DateTime.MinValue;

            try
            {
                if (fileManDateTime.Contains("."))
                    returnVal = GetDateAndTime(fileManDateTime);
                else
                    returnVal = GetDateOnly(fileManDateTime);
            }
            catch
            {
                
            }

            return returnVal;
        }

        private static DateTime GetDateAndTime(string fileManDateTime)
        {
            DateTime returnVal = DateTime.MinValue;

            int[] dateVals = new int[6];

            string year = fileManDateTime.Substring(0, 3);
            string month = fileManDateTime.Substring(3, 2);
            string day = fileManDateTime.Substring(5, 2);

            string[] time = fileManDateTime.Split(".".ToCharArray());

            // *** 03/10/12 Check length before parsing ***
            string hour = (time[1].Length > 1) ?  time[1].Substring(0, 2) : "0";            
            string minute = (time[1].Length > 3) ? time[1].Substring(2, 2) : "0";
            string second = (time[1].Length > 4) ? time[1].Substring(4) : "0";
            
            // *** 12/17/13 Allow missing hours, minutes, or seconds ***

            if (int.TryParse(year, out dateVals[0]))
                if (int.TryParse(month, out dateVals[1]))
                    if (int.TryParse(day, out dateVals[2]))
                    {
                        if (!int.TryParse(hour, out dateVals[3]))
                            dateVals[3] = 0;

                        // *** 07/14/2016 Allow an hours value of 24 ***
                        int addDays = 0;
                        if (dateVals[3] == 24)
                        {
                            addDays = 1;
                            dateVals[3] = 0;
                        }

                        if (!int.TryParse(minute, out dateVals[4]))
                            dateVals[4] = 0;

                        if (!int.TryParse(second, out dateVals[5]))
                            dateVals[5] = 0; 
                                   
                        returnVal = new DateTime(dateVals[0] + 1700, dateVals[1], dateVals[2], dateVals[3], dateVals[4], dateVals[5]);

                        returnVal.AddDays(addDays);
                    }
            return returnVal; 
        }

        private static DateTime GetDateOnly(string fileManDateTime)
        {
            DateTime returnVal = DateTime.MinValue;

            int[] dateVals = new int[6];

            string year = fileManDateTime.Substring(0, 3);
            string month = fileManDateTime.Substring(3, 2);
            string day = fileManDateTime.Substring(5, 2);

            if (int.TryParse(year, out dateVals[0]))
                if (dateVals[0] > 0)
                    if (int.TryParse(month, out dateVals[1]))
                        if (dateVals[1] > 0)
                            if (int.TryParse(day, out dateVals[2]))
                                if (dateVals[2] > 0)
                                    returnVal = new DateTime(dateVals[0] + 1700, dateVals[1], dateVals[2], dateVals[3], dateVals[4], dateVals[5]);

            return returnVal; 

        }

        public static InexactDate GetInexactDateFromFM(string fileManDateTime)
        {
            // *** Get inexact date from fileman date ***

            InexactDate returnVal;

            int[] dateVals = new int[3] { -1, -1, -1 };

            try
            {
                // *** Get string values of date parts ***

                string year = fileManDateTime.Substring(0, 3);
                string month = fileManDateTime.Substring(3, 2);
                string day = fileManDateTime.Substring(5, 2);

                // *** Try to get integer values for each part ***

                if (int.TryParse(year, out dateVals[0]))
                {
                    dateVals[0] += 1700; 
                    if (int.TryParse(month, out dateVals[1]))
                        int.TryParse(day, out dateVals[2]);
                }
            }
            catch 
            {
            }

            // *** Create inexact date based on found values ***
            returnVal = new InexactDate(dateVals[0], dateVals[1], dateVals[2]); 

            return returnVal;
        }

        public static InexactDate GetInexactDate(string dateTime)
        {
            // *** Get inexact date from string formatted as MM/dd/yyyy ***

            // *** Handles zeros in each part and creates inexact ***

            InexactDate returnVal;

            int month = -1;
            int day = -1;
            int year = -1;

            try
            {
                // *** Split by slash ***
                string[] temp = Util.Split(dateTime, "/");

                // *** Check if have result ***
                if (temp != null)
                {
                    // *** Try parse each value ***

                    if (temp.Length > 0)
                        int.TryParse(temp[0], out month);

                    if (temp.Length > 1)
                        int.TryParse(temp[1], out day);

                    if (temp.Length > 2)
                        int.TryParse(temp[2], out year);
                }
            }
            catch { }

            returnVal = new InexactDate(year, month, day); 

            return returnVal; 
        }

        public static string[] Split(string s, string delim)
        {
            if (s == String.Empty) return new string[0];
            if (s.EndsWith(delim))
            {
                s = s.Remove(s.Length - delim.Length);
            }
            return s.Split(new string[] { delim }, StringSplitOptions.None);
        }

        //public static string MixCase(string original)
        //{
        //    string returnVal = "";

        //    string[] pieces = Util.Split(original, " ");

        //    foreach (string piece in pieces)
        //    {
        //        string lower = piece.ToLower();
        //        string first = lower.Substring(0, 1).ToUpper();
        //        string rest = lower.Substring(1);
        //        if (string.IsNullOrWhiteSpace(returnVal))
        //            returnVal = first + rest;
        //        else
        //            returnVal += " " + first + rest; 
        //    }

        //    return returnVal; 
        //}


        public static string[] MakeVistAStringArray(string orig)
        {
            // *** Make an array to work with ***
            List<string> returnList = new List<string>();

            // *** Use standard size of 80 ***
            const int pieceSize = 80; 

            // *** Check that we have something ***
            if (!string.IsNullOrWhiteSpace(orig))
            {
                // *** Add full value to working variable ***
                string remaining = orig;

                // *** Loop while we need to split ***
                while (remaining.Length > pieceSize)
                {
                    // *** Add first <pieceSize> chars ***
                    returnList.Add(remaining.Substring(0, pieceSize));

                    // *** Get remaining ***
                    remaining = remaining.Substring(pieceSize);
                }

                // *** Add last remaining ***
                returnList.Add(remaining);
            }

            return returnList.ToArray(); 
        }
    }
}
