using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.CDA.ValueSets;
using VA.Gov.Artemis.UI.Data.Brokers.Common; 

namespace VA.Gov.Artemis.UI.Data.Brokers.Cda
{
    public class CdaValueSetResult: BrokerOperationResult
    {
        public ValueSet ValueSet { get; set; }
    }
}
