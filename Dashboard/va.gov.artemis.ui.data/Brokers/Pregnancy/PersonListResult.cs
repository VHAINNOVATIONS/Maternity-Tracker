// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.UI.Data.Brokers.Common;
using VA.Gov.Artemis.UI.Data.Models.Common;

namespace VA.Gov.Artemis.UI.Data.Brokers.Pregnancy
{
    /// <summary>
    /// Broker operation result which returns a list of persons
    /// </summary>
    public class PersonListResult: BrokerOperationResult
    {
        public int TotalResults { get; set; }

        public List<Person> PersonList { get; set; }

        public PersonListResult()
        {
            this.PersonList = new List<Person>(); 
        }
    }
}
