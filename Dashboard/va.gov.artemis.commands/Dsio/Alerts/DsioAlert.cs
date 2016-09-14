using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.Commands.Dsio.Alerts
{
    public class DsioAlert
    {
        public string Info { get; set; }
        public string Patient { get; set; }
        public string Location { get; set; }
        public string Urgency { get; set; }
        public string AlertDateTime { get; set; }
        public string Message { get; set; }
        //public string ForwardedByWhen { get; set; }

        public string Identifier { get; set; }
        public string ForwardIen { get; set; }
        public string When { get; set; }

    }
}
