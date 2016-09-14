using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.Commands.Dsio.Tracking
{
    public class DsioTrackingItem
    {
        public string Id { get; set; }
        public string TrackingItemDateTime { get; set; }
        public string Dfn { get; set; }
        public string PatientName { get; set; }
        public string User { get; set; }
        public string TrackingType { get; set; }
        public string Source { get; set; }
        public string Reason { get; set; }
        public string Comment { get; set; }

    }
}
