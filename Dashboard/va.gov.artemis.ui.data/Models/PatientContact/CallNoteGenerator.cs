// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.UI.Data.Models.PatientContact
{
    public class CallNoteGenerator
    {
        public List<CallTabBase> CallTabs { get; set; }

        public CallNoteGenerator()
        {
            this.CallTabs = new List<CallTabBase>(); 
        }

        public bool AddDataToTabs(Dictionary<string, string> noteData)
        {
            bool returnVal = false;

            foreach (CallTabBase tab in this.CallTabs)
                tab.AddData(noteData); 

            return returnVal; 
        }

        public string GetNoteText()
        {
            StringBuilder sb = new StringBuilder();

            foreach (CallTabBase tab in this.CallTabs)
                sb.Append(tab.GetNoteText()); 

            return sb.ToString(); 
        }

        public Dictionary<string, string> GetAllDataFromTabs()
        {
            Dictionary<string, string> returnData = new Dictionary<string, string>();

            foreach (CallTabBase tab in this.CallTabs)
            {
                Dictionary<string, string> tabData = tab.GetTabDataElements();

                if (tabData != null)
                    if (tabData.Count > 0)
                        foreach (string key in tabData.Keys)
                            returnData.Add(key, tabData[key]);
            }

            return returnData;
        }

    }
}
