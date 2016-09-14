using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.CDA.Common
{
    public class CdaTelephone
    {
        public string Number { get; set; }
        public Hl7TelephoneUsage Usage { get; set; }
        public string NullFlavor { get; set; }

        public TEL ToTEL()
        {
            TEL tempTel = new TEL();

            if (string.IsNullOrWhiteSpace(this.NullFlavor))
            {
                tempTel.value = this.Number;
                tempTel.use = new string[] { this.UsageCode };
            }
            else
                tempTel.nullFlavor = this.NullFlavor; 
            
            return tempTel;
        }

        private string UsageCode
        {
            get
            {
                string returnVal = "";

                //Unknown, PrimaryHome, WorkPlace, MobileContact, VacationHome
                string[] codes = new string[] { "", "HP", "WP", "MC", "HV" };

                returnVal = codes[(int)this.Usage];

                return returnVal;
            }
        }

    }
}
