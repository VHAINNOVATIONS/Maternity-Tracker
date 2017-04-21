// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.UI.Data.Models.Patient;

namespace VA.Gov.Artemis.UI.Data.Models.Outcomes
{
    public class PatientStillbirthOutcome: PatientRelatedModel
    {
        public StillbirthOutcome Details { get; set; }

        public string PregnancyIen { get; set; }

        public PatientStillbirthOutcome()
        {
            this.Details = new StillbirthOutcome(); 
        }
    }
}
