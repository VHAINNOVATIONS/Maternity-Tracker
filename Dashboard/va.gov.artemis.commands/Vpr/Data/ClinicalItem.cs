using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace VA.Gov.Artemis.Commands.Vpr.Data
{
    [Serializable]
    public abstract class ClinicalItem
    {
        [XmlElement("id")]
        public ValueElement Id { get; set; }

        [XmlElement("location")]
        public Location Location { get; set; }

        [XmlElement("name")]
        public virtual ValueElement ItemName { get; set; }

        [XmlElement("facility")]
        public CodeElement Facility { get; set; }

    }
}
