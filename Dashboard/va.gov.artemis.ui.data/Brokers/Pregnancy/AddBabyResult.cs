using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.UI.Data.Brokers.Common;

namespace VA.Gov.Artemis.UI.Data.Brokers.Pregnancy
{
    public class AddBabyResult: BrokerOperationResult
    {
        public string NewBabyIen { get; set; }
        public string NewBabyNumber { get; set; }
    }
}
