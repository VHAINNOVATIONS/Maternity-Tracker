using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.UI.Data.Brokers.Common;

namespace VA.Gov.Artemis.UI.Data.Brokers.Orders
{
    public class OrderDetailResult: BrokerOperationResult
    {
        public string OrderDetail { get; set; }
    }
}
