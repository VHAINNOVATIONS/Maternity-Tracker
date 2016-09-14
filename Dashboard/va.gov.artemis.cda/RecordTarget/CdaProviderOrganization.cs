using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.CDA.Common;

namespace VA.Gov.Artemis.CDA.RecordTarget
{
    public class CdaProviderOrganization
    {
        public CdaNpi NPI { get; set; }
        //public string Id { get; set; }
        public string Name { get; set; }
        public CdaAddressList AddressList { get; set; }
        public CdaTelephoneList TelephoneList { get; set; }

        public CdaProviderOrganization()
        {
            this.AddressList = new CdaAddressList();
            this.TelephoneList = new CdaTelephoneList();
        }

        internal POCD_MT000040Organization ToPocdOrganization()
        {
            POCD_MT000040Organization returnOrg = new POCD_MT000040Organization();

            ON orgName = new ON(); 
            orgName.Text = new string[]{this.Name};

            returnOrg.name = new ON[] { orgName };

            returnOrg.addr = this.AddressList.ToADArray();
            returnOrg.telecom = this.TelephoneList.ToTelArray();

            returnOrg.id = this.NPI.ToIIArray(); 

            return returnOrg; 
        }
    }
}
