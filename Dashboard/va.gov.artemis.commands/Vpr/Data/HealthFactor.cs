using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.Commands.Vpr.Data
{
    [Serializable]
    [XmlRoot("factor")]
    public class HealthFactor: ClinicalItem 
    {
        // TODO: From docs...

        // category
        // comment
        // encounter
        // recorded
        // severity

        [XmlElement("category")]
        public CodeElement Category { get; set; }

        [XmlElement("encounter")]
        public ValueElement Encounter { get; set; }

        [XmlElement("recorded")]
        public VprDateTime Recorded { get; set; }
    }
}
