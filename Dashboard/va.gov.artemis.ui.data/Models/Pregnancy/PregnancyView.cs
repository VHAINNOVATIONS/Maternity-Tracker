// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.UI.Data.Models.Outcomes;
using VA.Gov.Artemis.UI.Data.Models.Patient;

namespace VA.Gov.Artemis.UI.Data.Models.Pregnancy
{
    public class PregnancyView: PatientRelatedModel
    {
        public PregnancyDetails Pregnancy { get; set; }

        public OutcomeDetails Outcome { get; set; }

        public List<BabyDetails> Babies { get; set; }

        public PregnancyView()
        {
            this.Pregnancy = new PregnancyDetails();
            this.Outcome = new OutcomeDetails();
            this.Babies = new List<BabyDetails>(); 
        }

    }
}
