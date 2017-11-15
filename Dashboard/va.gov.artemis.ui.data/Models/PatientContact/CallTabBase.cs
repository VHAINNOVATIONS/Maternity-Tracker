// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.UI.Data.Models.Patient;

namespace VA.Gov.Artemis.UI.Data.Models.PatientContact
{
    public abstract class CallTabBase: PatientRelatedModel
    {
        // *** Patient ***
        //public BasePatient Patient { get; set; }

        // *** Call Template ***
        public string CallTemplateName { get; set; }
        public MccPatientCallType CallType { get; set; }

        // *** All Tabs ***
        public int TabCount { get; set; }
        public List<CallTab> TabList { get; set; }

        // *** Current Tab ***
        public int TabIndex { get; set; }
        public CallTab CurrentTab { get; set; } 
       
        // *** Data ***
        public string NoteIen { get; set; }
        public string Comment { get; set; }

        // *** Which button to post ***
        public int NavigateToTab { get; set; }

        // *** Return the index of the "next" tab ***
        //public int NextTabIndex { get { return ((this.TabIndex + 1) < this.TabCount) ? this.TabIndex + 1 : -1; } }
        public int NextTabIndex { get { return this.TabIndex + 1; } }

        // *** Return the index of the "last" tab ***
        public int LastTabIndex { get { return TabCount - 1; } }

        // *** Return the index of the "previous" tab ***
        public int PrevTabIndex { get { return (this.TabIndex > 0) ? this.TabIndex -1 : -1; } }

        // *** Checklist item to update ***
        public string ChecklistIen { get; set; }

        public bool DeleteNote { get; set; }

        public bool IsFirst
        {
            get
            {
                return (TabIndex == 0);
            }
        }

        public bool IsLast
        {
            get
            {
                return (TabIndex == TabCount - 1);
            }
        }

        protected void CopyBase(CallTabBase tabBase)
        {
            this.CallTemplateName = tabBase.CallTemplateName;
            this.CallType = tabBase.CallType;
            this.Patient = tabBase.Patient;
            this.TabCount = tabBase.TabCount;
            this.TabIndex = tabBase.TabIndex;
            this.CurrentTab = tabBase.CurrentTab;
            this.TabList = tabBase.TabList; 

        }

        public void AddData(Dictionary<string, string> data)
        {
            if (data != null)
                if (data.Count > 0)
                    foreach (string key in data.Keys)
                        AddDataElement(key, data[key]);

        }

        public abstract void AddDataElement(string key, string value);

        public abstract Dictionary<string, string> GetTabDataElements();

        public abstract string GetNoteText();

        protected abstract bool AnyValues();

        public Dictionary<string, string> Pregnancies { get; set; }

        public string PregnancyIen { get; set; }

        public CallTabBase()
        {
            this.Pregnancies = new Dictionary<string, string>(); 
        }
    }
}
