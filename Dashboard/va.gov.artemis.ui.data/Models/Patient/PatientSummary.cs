using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.UI.Data.Models.Checklist;
using VA.Gov.Artemis.UI.Data.Models.Patient;
using VA.Gov.Artemis.UI.Data.Models.Pregnancy;

namespace VA.Gov.Artemis.UI.Data.Models.Patient
{
    public class PatientSummary: PatientRelatedModel
    {        
        public string ReturnUrl { get; set; }

        public PregnancyDetails CurrentPregnancy { get; set; }

        public PregnancyHistory PregnancyHistory { get; set; }

        public PregnancyChecklistItemList PregnancyChecklistItems { get; set; }

        public string MoreChecklistItems { get; set; }

        public string ChecklistLink { get; set; }

        public PatientSummary()
        {
            this.CurrentPregnancy = new PregnancyDetails();
            this.PregnancyChecklistItems = new PregnancyChecklistItemList(); 
        }

    }
}
