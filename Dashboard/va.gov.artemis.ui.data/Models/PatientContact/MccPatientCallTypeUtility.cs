using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.UI.Data.Models.Notes;

namespace VA.Gov.Artemis.UI.Data.Models.PatientContact
{
    public class MccPatientCallTypeUtility
    {
        internal static TiuNoteTitle[] titles = new TiuNoteTitle[]{
                    TiuNoteTitle.PhoneCall1, 
                    TiuNoteTitle.PhoneCall2, 
                    TiuNoteTitle.PhoneCall3, 
                    TiuNoteTitle.PhoneCall4, 
                    TiuNoteTitle.PhoneCall5, 
                    TiuNoteTitle.PhoneCall6a, 
                    TiuNoteTitle.PhoneCall6b, 
                    TiuNoteTitle.PhoneCall7, 
                    TiuNoteTitle.PhoneCallAdditional
                };

        internal static string[] MccPatientCallTemplateName = new string[]{
            "Phone Call #1 (Initial Contact)", 
            "Phone Call #2 (12 Weeks)",
            "Phone Call #3 (20 Weeks)",
            "Phone Call #4 (28 Weeks)",
            "Phone Call #5 (36 Weeks)",
            "Phone Call #6a (41 Weeks, Not Delivered)",
            "Phone Call #6b (41 Weeks, Delivered)",
            "Phone Call #7 (6 Weeks Postpartum)", 
            "Additional Call"
        };

        public static bool IsCall(TiuNoteTitle noteTitle)
        {
            return titles.Contains(noteTitle); 
        }

        public static string GetDescription(MccPatientCallType callType)
        {
            return MccPatientCallTemplateName[(int)callType];
        }

        public static MccPatientCallType GetCallType(TiuNoteTitle noteTitle)
        {
            MccPatientCallType returnVal = MccPatientCallType.PhoneCall_1;

            int index = Array.IndexOf(titles, noteTitle);

            if (index >= 0)
                returnVal = (MccPatientCallType)index;

            return returnVal;
        }

        public static string GetDescription(TiuNoteTitle noteTitle)
        {
            string returnVal = "";

            MccPatientCallType callType = GetCallType(noteTitle);

            returnVal = MccPatientCallTemplateName[(int)callType]; 

            return returnVal; 
        }


    }
}
