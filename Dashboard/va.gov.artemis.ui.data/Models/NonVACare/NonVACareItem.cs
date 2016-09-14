using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.UI.Data.Models.NonVACare
{
    public class NonVACareItem
    {
        public string Ien { get; set; }

        [Required]
        public NonVACareItemType ItemType { get; set; }

        // *** RPC needs original name as key ***
        public string OriginalName { get; set; }

        [Required]
        public string Name { get; set; }

        [Display(Name = "Address")]
        public string AddressLine1 { get; set; }

        [Display(Name = "Address Line 2")]
        public string AddressLine2 { get; set; }

        public string City { get; set; }
        public string State { get; set; }
        public string ZipCode { get; set; }

        [Display(Name = "Primary Contact")]
        public string PrimaryContact { get; set; }

        [Display(Name = "Phone Number")]
        public string PhoneNumber { get; set; }

        [Display(Name = "Fax Number")]
        public string FaxNumber { get; set; }

        public bool Inactive { get; set; }

        public string ReturnUrl { get; set; }

        public string Csz
        {
            get
            {
                string returnVal = ""; 

                if ((!string.IsNullOrWhiteSpace(this.City)) && (!string.IsNullOrWhiteSpace(this.State)))
                    returnVal = string.Format("{0}, {1} {2}", this.City, this.State, this.ZipCode);
                else
                    returnVal = string.Format("{0} {1} {2}", this.City, this.State, this.ZipCode);

                return returnVal; 
            }
        }

    }
    
}
