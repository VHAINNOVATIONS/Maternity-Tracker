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
    [Serializable]
    public class Measurement
    {
        // TODO: Implement...
        // vuid

        [XmlAttribute("id")]
        public string Id { get; set; }

        [XmlAttribute("name")]
        public string Name { get; set; }

        [XmlAttribute("value")]
        public string Value { get; set; }

        [XmlAttribute("high")]
        public string High { get; set; }

        [XmlAttribute("low")]
        public string Low { get; set; }

        [XmlAttribute("units")]
        public string Units { get; set; }

        [XmlAttribute("metricValue")]
        public string MetricValue { get; set; }

        [XmlAttribute("metricUnits")]
        public string MetricUnits { get; set; }

        [XmlArray("qualifiers")]
        [XmlArrayItem("qualifier")]
        public List<Qualifier> Qualifiers { get; set; }
    }
}
