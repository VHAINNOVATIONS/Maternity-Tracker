using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.Commands.Dsio.Base
{
    public class DsioPerson
    {
        public string Ien { get; set; }

        public string Name { get; set; }
        public DsioAddress Address { get; set; }
        public List<DsioTelephone> TelephoneList { get; set; }

        public DsioPerson()
        {
            this.TelephoneList = new List<DsioTelephone>();
            this.Address = new DsioAddress(); 
        }

    }
}
