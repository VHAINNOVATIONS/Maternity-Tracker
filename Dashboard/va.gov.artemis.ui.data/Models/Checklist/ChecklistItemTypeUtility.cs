// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Commands.Dsio.Checklist;

namespace VA.Gov.Artemis.UI.Data.Models.Checklist
{
    public static class ChecklistItemTypeUtility
    {
        private static string[] itemTypeDescriptions = new string[] { "", "MCC Call", "Education", "Lab", "Ultrasound", "Consult", "Document Exchange", "Visit", "Other" };

        public static Dictionary<DsioChecklistItemType, string> GetItemTypeSelection()
        {
            Dictionary<DsioChecklistItemType, string> returnVal = new Dictionary<DsioChecklistItemType, string>();

            foreach (object itemType in Enum.GetValues(typeof(DsioChecklistItemType))) 
                if (!string.IsNullOrWhiteSpace(itemTypeDescriptions[(int)itemType]))
                    returnVal.Add((DsioChecklistItemType)itemType, itemTypeDescriptions[(int)itemType]); 

            return returnVal;
        }

        public static string GetItemTypeDescription(DsioChecklistItemType itemType) 
        {
            return itemTypeDescriptions[(int)itemType]; 
        }
    }
}
