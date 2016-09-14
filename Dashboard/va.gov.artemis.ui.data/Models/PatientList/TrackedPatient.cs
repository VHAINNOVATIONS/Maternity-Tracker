using System;
using System.ComponentModel.DataAnnotations;
using VA.Gov.Artemis.UI.Data.Models.Common;
using VA.Gov.Artemis.UI.Data.Models.Edd;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.UI.Data.Models.PatientList
{
    public class TrackedPatient: BasePatient
    {
        //[Display(Name="Phone")]
        //public string PhoneNumber { get; set; }

        [Display(Name="Non-VA OB")]
        public string NonVaObstetrician { get; set; }

        [Display(Name="L&D")]
        public string PlannedDeliveryFacility { get; set; }

        public DateTime EDD { get; set; }

        [Display(Name="EDD")]
        public string EDDDisplay
        {
            get
            {
                string returnVal = "";
                if (this.EDD != DateTime.MinValue)
                    returnVal = this.EDD.ToString(VistaDates.VistADateOnlyFormat);
                return returnVal;
            }
        }

        [Display(Name="GA")]
        public string GestationalAge
        {
            get
            {
                return EddUtility.GetGestationalAge(this.EDD);
            }
        }

        public int GestationalAgeDays
        {
            get
            {
                return EddUtility.GetGestationalAgeInDays(this.EDD);
            }
        }

        [Display(Name="Tri")]
        public int Trimester
        {
            get
            {
                return EddUtility.GetTrimester(this.EDD);
            }
        }

        [Display(Name = "Tri")]
        public string TrimesterDisplay
        {
            get
            {
                string returnVal = "";

                int tri = this.Trimester;

                if (tri > 0)
                    returnVal = tri.ToString(); 

                return returnVal;
            }
        }

        public string TrimesterSuffix
        {
            get
            {
                string returnVal = "";

                string[] suffixes = new string[] { "", "st", "nd", "rd" };

                int tri = this.Trimester;

                if (tri > 0)
                    returnVal = suffixes[tri];

                return returnVal;
            }
        }

        [Display(Name="Pregnant")]
        public string PregnantDisplay
        {
            get
            {
                return (this.Pregnant) ? "Yes" : "No";
            }
        }
    }
}