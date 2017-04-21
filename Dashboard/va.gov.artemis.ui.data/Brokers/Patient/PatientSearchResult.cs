// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.UI.Data.Models;
using VA.Gov.Artemis.UI.Data.Models.PatientSearch;
using VA.Gov.Artemis.UI.Data.Brokers.Common; 

namespace VA.Gov.Artemis.UI.Data.Brokers.Patient
{
    public class PatientSearchResult: BrokerOperationResult
    {
        public int TotalResults { get; set; }

        public List<SearchPatient> Patients { get; set; }

        public PatientSearchResult()
        {
            this.Patients = new List<SearchPatient>();
        }
    }
}
