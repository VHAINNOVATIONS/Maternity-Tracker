using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.UI.Data.Models.Patient;

namespace VA.Gov.Artemis.UI.Data.Models.Pregnancy
{
    public class PregnancyAddEdit: PatientRelatedModel
    {
        public PregnancyDetails Item { get; set; }

        public PregnancyOutcomeType OutcomeType { get; set; }

        public string ReturnUrl { get; set; }

        public Dictionary<PregnancyOutcomeType, string> OutcomeList
        {
            get
            {
                return PregnancyOutcomeUtility.OutcomeList;
            }
        }

        public Dictionary<string, string> ObList {get; set; }
        public Dictionary<string, string> LDList {get; set; }
        public Dictionary<string, string> FofList {get; set; }
        public Dictionary<int, string> MultipleList {get; set; }

        public Dictionary<ClinicalDateType, string> LmpList; 

        public PregnancyAddEdit()
        {
            this.Item = new PregnancyDetails();
            this.ObList = new Dictionary<string, string>();
            this.LDList = new Dictionary<string, string>();
            this.FofList = new Dictionary<string, string>();

            this.MultipleList = new Dictionary<int, string>();
            this.MultipleList.Add(-1, "Unknown");
            this.MultipleList.Add(1, "No - Singleton");
            for (int i = 2; i < 10; i++)
                this.MultipleList.Add(i, string.Format("Yes - {0}", i));

            this.LmpList = new Dictionary<ClinicalDateType, string>();
            this.LmpList.Add(ClinicalDateType.Unknown, "Unknown");
            this.LmpList.Add(ClinicalDateType.Known, "Known");
            this.LmpList.Add(ClinicalDateType.Approximate, "Approximate"); 
        }

        // *** Keep track of original values ***
        public string OriginalLmp { get; set; }
        public int OriginalFetusBabyCount { get; set; }
    }
}
