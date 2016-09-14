using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.Commands.Dsio.Tracking
{
    public class DsioFlaggedPatientResult
    {
        public Dictionary<string, DsioFlaggedPatient> FlaggedPatients { get; set; }

        public DsioFlaggedPatientResult()
        {
            this.FlaggedPatients = new Dictionary<string, DsioFlaggedPatient>();
        }
    }
}
