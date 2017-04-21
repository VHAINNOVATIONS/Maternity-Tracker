// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Commands.Dsio.Tracking;

namespace VA.Gov.Artemis.Commands.Dsio
{
    public class DsioSearchPatient: DsioPatient
    {
        public string Gender { get; set; }

        public string Veteran { get; set; }

        public string Location { get; set; }

        public string RoomBed { get; set; }

        public string ServiceConnected { get; set; }

        public string TrackingStatus { get; set; }

        public string SSN { get; set; }
        public string City { get; set; }
        public string State { get; set; }
        public string Zip { get; set; }


        public string Sensitive { get; set; }
    }
}
