// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.UI.Data.Models.Edd
{
    public class EddItem
    {
        public EddItemType ItemType { get; set; }

        private string[] itemTypeDescription = new string[]{ "Unknown", "Last Menstrual Period", "Estimated Conception Date", "Ultrasound", "Embryo Transfer", "Other", "Unknown"};

        private string otherDescription { get; set; }

        public string Criteria
        {
            get
            {
                string returnVal = "";

                if (this.ItemType == EddItemType.Other)
                    returnVal = otherDescription; 
                else 
                    returnVal = itemTypeDescription[(int)this.ItemType];

                return returnVal; 
            }
            set
            {
                this.otherDescription = value; 
            }
        }
        
        [Display(Name = "Event Date")]
        public string EventDate { get; set; }

        [Display(Name = "Today's Gestational Age")]
        public string GestationalAgeWeeks { get; set; }
        public string GestationalAgeDays { get; set; }

        public int GestationalAgeTotalDays
        {
            get
            {
                int returnVal = -1;

                int weeks = -1;
                if (int.TryParse(this.GestationalAgeWeeks, out weeks))
                    returnVal = weeks * 7;

                int days = -1;
                if (int.TryParse(this.GestationalAgeDays, out days))
                    returnVal += days; 

                return returnVal;
            }
        }

        public string EDD { get; set; }
        
        [Display(Name = "Final EDD")]
        public bool IsFinal { get; set; }

        public bool HasValue
        {
            get
            {
                return !string.IsNullOrWhiteSpace(this.EDD); 
            }
        }


    }
}
