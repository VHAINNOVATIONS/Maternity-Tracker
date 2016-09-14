using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.Commands.Dsio.Patient
{
    /// <summary>
    /// Patient details from VistA
    /// </summary>
    public class DsioPatientInformation
    {
        public string Dfn { get; set; }
        public string PatientName { get; set; }
        public string TrackingStatus { get; set; }
        //public string NextContactDate { get; set; }
        public string SSN { get; set; }
        public string DOB { get; set; }
        public string HomePhone { get; set; }
        public string WorkPhone { get; set; }
        public string MobilePhone { get; set; }
        public string Pregnant { get; set; }
        public string EDD { get; set; }
        public string GravidaPara { get; set; }
        public string LastLiveBirth { get; set; }

        public string Lactating { get; set; }

        public string LastContactDate { get; set; }
        public string NextContactDue { get; set; }
        public string NextChecklistDue { get; set; }

        public string Lmp { get; set; }

        public string CurrentPregnancyHighRisk { get; set; }

        public string HighRiskDetails { get; set; }

        public string ZipCode { get; set; }
        public string Email { get; set; }

        public string Text4BabyStatus { get; set; }
        public string Text4BabyDate { get; set; }
        public string Text4BabyId { get; set; }
    }
}
