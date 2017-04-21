// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.UI.Data.Models.Common;

namespace VA.Gov.Artemis.UI.Data.Models.PatientSearch
{
    public class PatientSearch
    {
        public string SearchCriteria { get; set; }

        public List<SearchPatient> Patients { get; set; }

        public string Message { get; set; }

        public Paging Paging { get; set; }

        public PatientSearch()
        {
            this.Patients = new List<SearchPatient>();
            this.Paging = new Paging(); 
        }
    }

}
