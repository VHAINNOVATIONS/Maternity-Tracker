// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.CDA.Common;

namespace VA.Gov.Artemis.CDA.RecordTarget
{
    public class CdaGuardian
    {
        public Hl7Relationship RelationshipToPatient { get; set; } // 1 Required
        public List<CdaAddress> AddressList { get; set; }
        public List<CdaTelephone> TelephoneList { get; set; }
        public CdaName Name { get; set; }

        public CdaGuardian()
        {
            this.AddressList = new List<CdaAddress>();
            this.TelephoneList = new List<CdaTelephone>();
            this.Name = new CdaName();
        }
    }
}
