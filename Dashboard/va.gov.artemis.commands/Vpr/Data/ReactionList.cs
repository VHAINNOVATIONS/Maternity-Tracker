// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace VA.Gov.Artemis.Commands.Vpr.Data
{
    // TODO: Remove...

    [Serializable]
    public class ReactionList
    {
        // *** Use actual total from list? ***
        [XmlAttribute("total")]
        public int Total { get; set; }

        // TODO: What does list of allergies look like?
        [XmlElement("allergy")]
        public List<Allergy> Allergies { get; set; }
    }
}
