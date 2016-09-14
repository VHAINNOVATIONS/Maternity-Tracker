using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.UI.Data.Models.Radiology;
using VA.Gov.Artemis.UI.Data.Brokers.Common;


namespace VA.Gov.Artemis.UI.Data.Brokers.Radiology
{
    public class RadiologyReportsResult: BrokerOperationResult
    {
        public List<RadiologyReport> Items { get; set; }

        public RadiologyReportsResult()
        {
            this.Items = new List<RadiologyReport>(); 
        }
    }
}
