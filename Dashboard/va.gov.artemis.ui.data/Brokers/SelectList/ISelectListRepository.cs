using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.UI.Data.Brokers.Common; 

namespace VA.Gov.Artemis.UI.Data.Brokers.SelectList
{
    public interface ISelectListRepository
    {
        SelectListResult GetReasonList();

        SelectListResult GetSourceList();

        BrokerOperationResult AddReason(string newReason);

        BrokerOperationResult AddSource(string newSource); 

    }
}
