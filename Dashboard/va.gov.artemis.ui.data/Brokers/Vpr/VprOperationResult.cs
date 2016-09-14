using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Commands.Vpr.Data;
using VA.Gov.Artemis.UI.Data.Brokers.Common; 

namespace VA.Gov.Artemis.UI.Data.Brokers.Vpr
{
    public class VprOperationResult: BrokerOperationResult
    {
        public VprPatientResult VprData { get; set; }
    }
}
