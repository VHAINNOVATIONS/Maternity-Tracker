using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.UI.Data.Brokers.Common;
using VA.Gov.Artemis.UI.Data.Models.Checklist;

namespace VA.Gov.Artemis.UI.Data.Brokers.Checklist
{
    public class PregnancyChecklistItemResult: BrokerOperationResult
    {
        public PregnancyChecklistItem Item { get; set; }
    }
}
