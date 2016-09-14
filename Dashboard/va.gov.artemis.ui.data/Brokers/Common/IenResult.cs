using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.UI.Data.Brokers.Common; 

namespace VA.Gov.Artemis.UI.Data.Brokers.Common
{
    /// <summary>
    /// Broker Operation Result which returns an IEN
    /// Typically from a create, save, or update operation
    /// </summary>
    public class IenResult: BrokerOperationResult
    {
        public string Ien { get; set; }
    }
}
