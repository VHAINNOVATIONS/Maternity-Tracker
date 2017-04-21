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
    /// <summary>
    /// Class which simplifies the creation of the CDA Custodion section of the header 
    /// </summary>
    public class CdaCustodian
    {
        public CdaNpi Npi { get; set; }
        public string OrganizationName { get; set; }
        public CdaTelephone PhoneNumber { get; set; }
        public CdaAddress Address { get; set; }

        public CdaCustodian()
        {
            this.Npi = new CdaNpi();
            this.PhoneNumber = new CdaTelephone();
            this.Address = new CdaAddress();
        }

        /// <summary>
        /// Creates a raw custodian class which can be serialized to CDA
        /// </summary>
        /// <returns>A raw custodian object</returns>
        public POCD_MT000040Custodian ToPocdCustodian()
        {
            POCD_MT000040Custodian returnVal = new POCD_MT000040Custodian(); 

            // *** Create empty objects ***
            returnVal.assignedCustodian = new POCD_MT000040AssignedCustodian();
            returnVal.assignedCustodian.representedCustodianOrganization = new POCD_MT000040CustodianOrganization();

            // *** Set the NPI ***
            returnVal.assignedCustodian.representedCustodianOrganization.id = this.Npi.ToIIArray();

            // *** Set the Organization Name ***
            returnVal.assignedCustodian.representedCustodianOrganization.name = new ON() { Text = new string[] { this.OrganizationName } }; 

            // *** Set the address ***
            returnVal.assignedCustodian.representedCustodianOrganization.addr = this.Address.ToAD();

            // *** Set the telephone ***
            returnVal.assignedCustodian.representedCustodianOrganization.telecom = this.PhoneNumber.ToTEL();

            return returnVal; 
        }
    }
}
