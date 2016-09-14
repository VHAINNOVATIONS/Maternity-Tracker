using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace VA.Gov.Artemis.Commands.Vpr.Data
{
    [Serializable]
    public class FatherOfFetus: FamilyMember
    {
        public override string Relationship
        {
            get
            {
                return "FOF";
            }
        }
    }
}
