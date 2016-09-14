using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace VA.Gov.Artemis.Commands.Vpr.Data
{
    [Serializable]
    public class Address
    {
        [XmlAttribute("streetLine1")]
        public string StreetLine1 { get; set; }

        [XmlAttribute("streetLine2")]
        public string StreetLine2 { get; set; }

        [XmlAttribute("city")]
        public string City { get; set; }

        [XmlAttribute("stateProvince")]
        public string State { get; set; }

        [XmlAttribute("postalCode")]
        public string ZipCode { get; set; }
    }
}
