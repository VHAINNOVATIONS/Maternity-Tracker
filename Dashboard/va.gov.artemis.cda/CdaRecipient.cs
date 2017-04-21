// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.CDA.Common;

namespace VA.Gov.Artemis.CDA
{
    public class CdaRecipient
    {
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Organization { get; set; }

        public CdaRecipient()
        {

        }

        public CdaRecipient(string first, string last, string org)
        {
            this.FirstName = first;
            this.LastName = last;
            this.Organization = org; 
        }

        public override string ToString()
        {
            string returnVal = "";

            if (!string.IsNullOrWhiteSpace(this.Organization))
                returnVal = this.Organization;
            else
                returnVal = string.Format("{0}, {1}", this.LastName, this.FirstName);

            return returnVal; 
        }

        public POCD_MT000040InformationRecipient[] ToPocdRecipient()
        {
            List<POCD_MT000040InformationRecipient> returnList = new List<POCD_MT000040InformationRecipient>();

            POCD_MT000040InformationRecipient pocdRecip = new POCD_MT000040InformationRecipient();

            pocdRecip.templateId = new II[] { new II() { root = "1.3.6.1.4.1.19376.1.3.3.1.4" } };
                   
            pocdRecip.intendedRecipient = new POCD_MT000040IntendedRecipient();
            
            // *** Add Organization ***
            if (!string.IsNullOrWhiteSpace(this.Organization))
            {
                pocdRecip.intendedRecipient.receivedOrganization = new POCD_MT000040Organization();
                pocdRecip.intendedRecipient.receivedOrganization.name = new ON[] { new ON { Text = new string[] { this.Organization } } };
                pocdRecip.intendedRecipient.receivedOrganization.addr = new AD[] { new AD { nullFlavor = "UNK" } };
                pocdRecip.intendedRecipient.receivedOrganization.telecom = new TEL[] { new TEL { nullFlavor = "UNK" } };
            }

            // *** Add Name ***
            if (!string.IsNullOrWhiteSpace(this.LastName))
            {
                //POCD_MT000040IntendedRecipient 
                CdaName tempName = new CdaName() { First = this.FirstName, Last = this.LastName };

                pocdRecip.intendedRecipient.informationRecipient = new POCD_MT000040Person(); 
                pocdRecip.intendedRecipient.informationRecipient.name = new PN[] { tempName.ToPN() };
            }

            returnList.Add(pocdRecip);

            return returnList.ToArray();
        }
    }
}
