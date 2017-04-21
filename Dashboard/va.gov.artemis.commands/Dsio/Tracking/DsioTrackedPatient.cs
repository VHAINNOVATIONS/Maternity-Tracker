// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.Commands.Dsio.Tracking
{
    public class DsioTrackedPatient: DsioPatient
    {
        public string HomePhone { get; set; }
        public string WorkPhone { get; set; }
        public string MobilePhone { get; set; }

        public string Pregnant { get; set; }

        public string SSN { get; set; }

        public string EDD { get; set; }

        public string Obstetrician { get; set; }
        public string LDFacility { get; set; }


        public string Lactating { get; set; }

        public string NextChecklistDue { get; set; }

        public string NextContactDue { get; set; }

        public string LastContactDate { get; set; }

        public string CurrentPregnancyHighRisk { get; set; }

        public string HighRiskDetails { get; set; }

        public string Text4BabyStatus { get; set; }
    }
}
