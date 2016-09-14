using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.UI.Data.Models.Pregnancy
{
    public class PregnancyOutcome
    {
        public DateTime EndDate { get; set; }
        public PregnancyOutcomeType OutcomeType { get; set; }
    }
}
