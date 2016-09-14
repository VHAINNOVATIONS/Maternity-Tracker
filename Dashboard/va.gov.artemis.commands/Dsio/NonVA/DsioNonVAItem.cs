using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Commands.Dsio.Base;

namespace VA.Gov.Artemis.Commands.Dsio.NonVA
{
    public class DsioNonVAItem
    {
        public DsioNonVAItem()
        {
            this.TelephoneList = new List<DsioTelephone>();
            this.Address = new DsioAddress();
        }

        public string Ien { get; set; }
        //public string OriginalEntityName { get; set; }
        public string EntityName { get; set; }
        public string EntityType { get; set; }
        public string Inactive { get; set; }
        //public string AddressLine1 { get; set; }
        //public string AddressLine2 { get; set; }
        //public string City { get; set; }
        //public string State { get; set; }
        //public string Zip { get; set; }
        //public string PhoneNumber { get; set; }
        //public string FaxNumber { get; set; }

        public DsioAddress Address { get; set; }
        public List<DsioTelephone> TelephoneList { get; set; }


        public string PrimaryContact { get; set; }
    }
}
