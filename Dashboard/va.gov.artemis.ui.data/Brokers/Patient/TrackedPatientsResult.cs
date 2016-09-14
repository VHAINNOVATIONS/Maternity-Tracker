using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.UI.Data.Models.PatientList;
using VA.Gov.Artemis.UI.Data.Brokers.Common; 

namespace VA.Gov.Artemis.UI.Data.Brokers.Patient
{
    public class TrackedPatientsResult: BrokerOperationResult
    {
        public int TotalResults { get; set; }

        public List<TrackedPatient> Patients { get; set; }
    }
}
