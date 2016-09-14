using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.UI.Data.Models.Track;
using VA.Gov.Artemis.UI.Data.Brokers.Common; 

namespace VA.Gov.Artemis.UI.Data.Brokers.TrackingHistory
{
    public interface ITrackingHistoryRepository
    {
        BrokerOperationResult Add(string dfn, TrackingEntryType eventType, string reason, string comment);

        TrackingHistoryResult GetHistoryEntries(int page, int itemsPerPage);

        TrackingHistoryResult GetPatientEntries(string dfn, int page, int itemsPerPage);

        TrackingHistoryResult GetPatientEntries(string dfn);

    }
}
