using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Commands.Dsio.Observation;
using VA.Gov.Artemis.UI.Data.Brokers.Common;
using VA.Gov.Artemis.UI.Data.Models.Observations;

namespace VA.Gov.Artemis.UI.Data.Brokers.Observations
{
    public class ObservationListResult: BrokerOperationResult
    {
        public int TotalResults { get; set; }

        public List<Observation> Observations { get; set; }

        public ObservationListResult()
        {
            this.Observations = new List<Observation>(); 
        }
    }
}
