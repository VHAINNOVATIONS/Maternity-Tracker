using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.CDA.Common;

namespace VA.Gov.Artemis.CDA
{
    public class CdaAssignedPerson : CdaAssignedAuthor
    {
        public CdaNpi NPI { get; set; }
        public string TaxonomyCode { get; set; }
        //public CdaName Name { get; set; }
        public CdaPerson Person { get; set; } 

        public CdaAssignedPerson()
        {
            this.Person = new CdaPerson(); 
            this.NPI = new CdaNpi(); 
        }

        public POCD_MT000040AssignedAuthor ToPocdAssignedAuthor()
        {
            POCD_MT000040AssignedAuthor returnAuthor = new POCD_MT000040AssignedAuthor();

            // *** Set the realm to US ***
            returnAuthor.realmCode = new CS[] { new CS() { code = "US" } };

            returnAuthor.addr = new AD[] { this.Address.ToAD() };

            returnAuthor.Item = this.Person.ToPocdPerson();

            returnAuthor.id = this.NPI.ToIIArray();

            returnAuthor.telecom = this.TelephoneList.ToTelArray(); 

            return returnAuthor;
        }
    }
}
