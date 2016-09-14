using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using VA.Gov.Artemis.Commands.Xus;
using VA.Gov.Artemis.UI.Data.Brokers.Common;

namespace VA.Gov.Artemis.UI.Data.Brokers.Division
{
    public class DivisionResult: BrokerOperationResult
    {
        public List<XusDivision> Divisions { get; set; }

        public DivisionResult()
        {
            this.Divisions = new List<XusDivision>(); 
        }
    }
}