using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.UI.Data.Models.Track;
using VA.Gov.Artemis.UI.Data.Brokers.Common;

namespace VA.Gov.Artemis.UI.Data.Brokers.TrackingHistory
{
    public class TrackingHistoryResult: BrokerOperationResult
    {
        public List<TrackingEntry> TrackingEntries { get; set; }
        public int TotalEntries { get; set; }
    }
}
