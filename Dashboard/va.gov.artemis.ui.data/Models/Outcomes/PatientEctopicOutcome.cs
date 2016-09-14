using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.UI.Data.Models.Patient;

namespace VA.Gov.Artemis.UI.Data.Models.Outcomes
{
    public class PatientEctopicOutcome: PatientRelatedModel
    {
        public EctopicOutcome Details { get; set; }

        public string PregnancyIen { get; set; }

        public PatientEctopicOutcome()
        {
            this.Details = new EctopicOutcome(); 
        }
    }
}
