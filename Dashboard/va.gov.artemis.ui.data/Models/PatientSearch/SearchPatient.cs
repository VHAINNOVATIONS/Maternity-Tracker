using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.UI.Data.Models.Common;
using VA.Gov.Artemis.UI.Data.Models.Patient;

namespace VA.Gov.Artemis.UI.Data.Models.PatientSearch
{
    public class SearchPatient: BasePatient
    { 
        public string Veteran { get; set; }

        public string Location { get; set; }

        [Display(Name="Room/Bed")]
        public string RoomBed { get; set; }

        [Display(Name="Svc. Connected")]
        public string ServiceConnected { get; set; }

        [Display(Name = "Tracking")]
        public CurrentTrackingStatus CurrentlyTracking { get; set; }

        public bool Sensitive { get; set; }

    }   

}
