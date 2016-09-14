using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using VA.Gov.Artemis.UI.Data.Models.Common;

namespace VA.Gov.Artemis.UI.Data.Models.PatientList
{
    public class TrackedPatients
    {
        public Paging Paging { get; set; }

        public List<TrackedPatient> List { get; set; }

        public TrackedPatients() 
        {
            this.List = new List<TrackedPatient>();
            this.Paging = new Paging();
        }
    }
}