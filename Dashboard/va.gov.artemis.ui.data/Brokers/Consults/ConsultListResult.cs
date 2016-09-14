using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.UI.Data.Models.Consults;
using VA.Gov.Artemis.UI.Data.Brokers.Common; 

namespace VA.Gov.Artemis.UI.Data.Brokers.Consults
{
    public class ConsultListResult: BrokerOperationResult
    {
        public List<Consult> Consults { get; set; }

        public ConsultListResult()
        {
            this.Consults = new List<Consult>(); 
        }
    }
}
