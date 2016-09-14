using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using VA.Gov.Artemis.UI.Data.Brokers.Common;
using VA.Gov.Artemis.UI.Data.Models.Pregnancy;

namespace VA.Gov.Artemis.UI.Data.Brokers.Pregnancy
{
    public class PregnancyOutcomeResult: BrokerOperationResult
    {
        public int TotalResults { get; set; }

        public List<PregnancyOutcome> PregnancyOutcomes { get; set; }

        public PregnancyOutcomeResult()
        {
            this.PregnancyOutcomes = new List<PregnancyOutcome>(); 
        }
    }
}
