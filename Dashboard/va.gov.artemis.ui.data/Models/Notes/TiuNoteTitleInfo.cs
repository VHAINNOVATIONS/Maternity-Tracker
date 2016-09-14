using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.UI.Data.Models.Notes
{
    public static class TiuNoteTitleInfo
    {
        public static string[] TiuNoteTitleText = new string[] { 
            "",
            "MCC DASHBOARD NOTE", 
            "DASHBOARD CDA INCOMING", 
            "OB H&P CONSULT",
            "PHONE CALL #1 (FIRST CONTACT)",
            "PHONE CALL #2 (12 WEEKS)",
            "PHONE CALL #3 (20 WEEKS)",
            "PHONE CALL #4 (28 WEEKS)",
            "PHONE CALL #5 (36 WEEKS)",
            "PHONE CALL #6A (41 WEEKS NOT DELIVERED)",
            "PHONE CALL #6B (41 WEEKS DELIVERED) TOPICS",
            "PHONE CALL #7 (6 WEEKS POSTPARTUM) TOPICS", 
            "PHONE CALL - ADDITIONAL", 
            "OB FOLLOWUP NOTE", 
            "NURSE POSTPARTUM NOTE", 
            "MD POSTPARTUM FOLLOWUP VISIT", 
            "OB H&P INITIAL",
            "OB HISTORY NOTE", 
            "NURSE POSTPARTUM - DELIVERY", 
            "NURSE POSTPARTUM - MATERNAL",
            "MCC PROVIDER CONTACT"
        };

        public static string GetTitleText(TiuNoteTitle title)
        {
            return TiuNoteTitleText[(int)title];
        }

        public static TiuNoteTitle GetTitle(string titleText)
        {
            TiuNoteTitle returnVal = TiuNoteTitle.Unknown; 

            int temp = Array.IndexOf(TiuNoteTitleText, titleText);

            if (temp >= 0)
                returnVal = (TiuNoteTitle)temp; 

            return returnVal; 
        }
    }
}
