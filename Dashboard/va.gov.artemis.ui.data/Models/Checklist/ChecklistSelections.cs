using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Commands.Dsio.Checklist;
using VA.Gov.Artemis.UI.Data.Models.PatientContact;

namespace VA.Gov.Artemis.UI.Data.Models.Checklist
{
    public static class ChecklistSelections
    {

        public static Dictionary<DsioChecklistCalculationType, string> DueTypeSelection
        {
            get
            {
                Dictionary<DsioChecklistCalculationType, string> returnVal = new Dictionary<DsioChecklistCalculationType, string>();

                returnVal.Add(DsioChecklistCalculationType.Initial, "Immediately");
                returnVal.Add(DsioChecklistCalculationType.TrimesterGa, "Trimester");
                returnVal.Add(DsioChecklistCalculationType.WeeksGa, "Weeks Gestation");
                returnVal.Add(DsioChecklistCalculationType.WeeksPostpartum, "Weeks Postpartum");

                return returnVal;
            }
        }

        public static Dictionary<int, string> TrimesterSelection
        {
            get
            {
                Dictionary<int, string> returnVal = new Dictionary<int, string>();

                returnVal.Add(1, "First Trimester");
                returnVal.Add(2, "Second Trimester");
                returnVal.Add(3, "Third Trimester"); 

                return returnVal;
            }
        }

        //public static Dictionary<DsioChecklistCompletionStatus, string> CompletionStatusSelection
        //{
        //    get
        //    {
        //        Dictionary<DsioChecklistCompletionStatus, string> returnVal = new Dictionary<DsioChecklistCompletionStatus, string>();

                
        //        return returnVal;
        //    }
        //}

        public static Dictionary<MccPatientCallType, string> CallNoteSelection
        {
            get
            {
                Dictionary<MccPatientCallType, string> returnVal = new Dictionary<MccPatientCallType, string>();

                foreach (object callType in Enum.GetValues(typeof(MccPatientCallType)))
                    returnVal.Add((MccPatientCallType)callType, MccPatientCallTypeUtility.GetDescription((MccPatientCallType)callType)); 

                return returnVal;
            }
        }

    }
}
