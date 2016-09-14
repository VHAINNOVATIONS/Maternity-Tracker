using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.UI.Data.Models.Patient;
using VA.Gov.Artemis.UI.Data.Models.Pregnancy;
using VA.Gov.Artemis.UI.Data.Brokers.Common; 

namespace VA.Gov.Artemis.UI.Data.Brokers.Pregnancy
{
    public class PregnancyHistoryResult: BrokerOperationResult
    {
        public PregnancyHistory PregnancyHistory { get; set; }

        public PregnancyHistoryResult()
        {
            this.PregnancyHistory = new PregnancyHistory(); 
        }
    }
}
