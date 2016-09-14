using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.UI.Data.Models.Patient;

namespace VA.Gov.Artemis.UI.Data.Models.Outcomes
{
    public class PatientSpontaneousAbortionOutcome: PatientRelatedModel
    {
        public SpontaneousAbortionOutcome Details { get; set; }

        public string PregnancyIen { get; set; }

        public PatientSpontaneousAbortionOutcome()
        {
            this.Details = new SpontaneousAbortionOutcome(); 
        }        
    }
}
