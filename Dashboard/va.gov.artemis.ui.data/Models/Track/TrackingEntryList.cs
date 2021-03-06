﻿// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.UI.Data.Models.Common;

namespace VA.Gov.Artemis.UI.Data.Models.Track
{
    public class TrackingEntryList
    {
        public List<TrackingEntry> Entries { get; set; }

        public bool ShowPatientLinks { get; set; }

        public Paging Paging { get; set; }

        public TrackingEntryList()
        {
            this.Paging = new Paging(); 
        }

        public string ReturnUrl { get; set; }
    }
}
