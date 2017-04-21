// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

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