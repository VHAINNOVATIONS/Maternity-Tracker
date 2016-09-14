using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.CDA
{
    public class CdaProviderAuthor : CdaAuthor
    {
        public CdaAssignedPerson AssignedPerson { get; set; }

        public CdaProviderAuthor()
        {
            this.AssignedPerson = new CdaAssignedPerson();
        }

        public override POCD_MT000040Author ToPocdAuthor()
        {
            POCD_MT000040Author returnAuthor = new POCD_MT000040Author();

            returnAuthor.assignedAuthor = this.AssignedPerson.ToPocdAssignedAuthor();

            returnAuthor.time = new TS() { value = this.Time.ToString(RawCdaDocument.CdaDateFormat) };

            return returnAuthor; 
        }
    }
}
