using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace VA.Gov.Artemis.Commands.Vpr.Data
{
    [Serializable]
    public class Order
    {
        // TODO: From docs...

        // acknowledgement
        // service

        [XmlElement("content")]
        public PreserveSpaceElement Content { get; set; }

        [XmlElement("entered")]
        public ValueElement Entered { get; set; }

        [XmlElement("group")]
        public ValueElement Group { get; set; }

        [XmlElement("location")]
        public Location Location { get; set; }

        [XmlElement("provider")]
        public CodeElement Provider { get; set; }

        [XmlElement("start")]
        public ValueElement Start { get; set; }

        [XmlElement("status")]
        public CodeElement Status { get; set; }

        [XmlElement("stop")]
        public ValueElement Stop { get; set; }

        [XmlElement("name")]
        public NameElement OrderName { get; set; }

        [XmlElement("id")]
        public ValueElement Id { get; set; }

        [XmlElement("facility")]
        public CodeElement Facility { get; set; }

    }
}
