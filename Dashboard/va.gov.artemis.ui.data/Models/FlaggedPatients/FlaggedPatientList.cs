using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.UI.Data.Models.Common;

namespace VA.Gov.Artemis.UI.Data.Models.FlaggedPatients
{
    public class FlaggedPatientList
    {
        public List<FlaggedPatient> Patients { get; set; }

        public Paging Paging { get; set; }

        public FlaggedPatientList()
        {
            this.Paging = new Paging();
            this.Patients = new List<FlaggedPatient>();
        }
    }
}
