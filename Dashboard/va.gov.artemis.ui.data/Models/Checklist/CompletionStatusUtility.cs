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
    public static class CompletionStatusUtility
    {
        // { Unknown, NotComplete, Complete, MarkedComplete, NotNeededOrApplicable }
        private static string[] completionStatusDescriptions = new string[] { "", "Not Complete", "Complete", "", "Canceled" };

        public static Dictionary<DsioChecklistCompletionStatus, string> GetSelection()
        {
            Dictionary<DsioChecklistCompletionStatus, string> returnVal = new Dictionary<DsioChecklistCompletionStatus, string>();

            foreach (object status in Enum.GetValues(typeof(DsioChecklistCompletionStatus)))
                if (!string.IsNullOrWhiteSpace(completionStatusDescriptions[(int)status]))
                    returnVal.Add((DsioChecklistCompletionStatus)status, completionStatusDescriptions[(int)status]); 

            return returnVal;
        }

        public static string GetStatusDescription(DsioChecklistCompletionStatus status)
        {
            return completionStatusDescriptions[(int)status];
        }

    }
}
