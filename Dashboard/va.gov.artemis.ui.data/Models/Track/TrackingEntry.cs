// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

//using VA.Gov.Artemis.UI.Data.Models.Common;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace VA.Gov.Artemis.UI.Data.Models.Track
{
    public class TrackingEntry
    {
        // *** Don't need to see these ***
        public string EntryId { get; set; }
        public string PatientDfn { get; set; }
        public string UserDuz { get; set; }

        // *** Visible to user ***
        [Display(Name="Date/Time")]
        public DateTime EntryDateTime { get; set; }        

        [Display(Name = "Patient")]
        public string PatientName {get; set; }

        [Display(Name = "User")]
        public string UserName { get; set; }

        public string Source { get; set; }
        //public string Action { get; set; } // *** Started, Stopped

        [Display(Name="Type")]
        public TrackingEntryType EntryType { get; set; }

        public string DisplayEntryType 
        { 
            get 
            { 
                string returnVal;

                string[] displayVals = {"Stop","Start","Flagged", "Reject", "Accept"};

                returnVal = displayVals[(int)this.EntryType];

                return returnVal; 
            }
        }

        [Display(Name = "Reason")]
        public string Reason { get; set; }

        public string Comment { get; set; }

    }

    public enum TrackingEntryType { Stop, Start, Flag, Reject, Accept }
}