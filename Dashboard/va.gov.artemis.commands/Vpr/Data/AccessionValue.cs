using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace VA.Gov.Artemis.Commands.Vpr.Data
{
    [XmlRoot("value")]
    public class AccessionValue
    {
        [XmlAttribute("vuid")]
        public string VuId { get; set; }

        [XmlAttribute("loinc")]
        public string Loinc { get; set; }

        [XmlAttribute("high")]
        public string High { get; set; }

        [XmlAttribute("low")]
        public string Low { get; set; }

        [XmlAttribute("units")]
        public string Units { get; set; }

        [XmlAttribute("interpretation")]
        public string Interpretation { get; set; }
        
        [XmlAttribute("result")]
        public string Result { get; set; }

        [XmlAttribute("test")]
        public string Test { get; set; }

        [XmlAttribute("id")]
        public string Id { get; set; }

    }
}
