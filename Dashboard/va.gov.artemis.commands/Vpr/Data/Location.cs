using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace VA.Gov.Artemis.Commands.Vpr.Data
{
    [Serializable]
    [XmlRoot("location")]
    public class Location
    {
        [XmlAttribute("name")]
        public string LocationName { get; set; }

        [XmlAttribute("value")]
        public string Value { get; set; }

        [XmlAttribute("code")]
        public string Code { get; set; }
    }
}
