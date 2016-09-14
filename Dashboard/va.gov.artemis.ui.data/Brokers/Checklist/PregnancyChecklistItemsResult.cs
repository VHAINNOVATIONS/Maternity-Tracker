using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.UI.Data.Models.Checklist;
using VA.Gov.Artemis.UI.Data.Brokers.Common; 

namespace VA.Gov.Artemis.UI.Data.Brokers.Checklist
{
    public class PregnancyChecklistItemsResult: BrokerOperationResult
    {
        public List<PregnancyChecklistItem> Items { get; set; }

        public int TotalResults { get; set; }

        public PregnancyChecklistItemsResult()
        {
            this.Items = new List<PregnancyChecklistItem>(); 
        }
    }
}
