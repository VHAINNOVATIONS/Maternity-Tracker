using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.UI.Data.Models.Patient;
using VA.Gov.Artemis.UI.Data.Models.Pregnancy;

namespace VA.Gov.Artemis.UI.Data.Models.Outcomes
{
    public class PatientOutcomeAddEdit: PatientRelatedModel
    {
        public string PregnancyIen { get; set; }
        //public string PregnancyEndDate { get; set; }
        public DateTime Edd { get; set; }

        public OutcomeDetails OutcomeDetails { get; set; }

        public PatientOutcomeAddEdit()
        {
            this.OutcomeDetails = new OutcomeDetails(); 
        }

        public Dictionary<PregnancyOutcomeType, string> OutcomeList
        {
            get
            {
                return PregnancyOutcomeUtility.OutcomeList;
            }
        }

    }
}
