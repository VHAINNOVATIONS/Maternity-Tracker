using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace VA.Gov.Artemis.Commands.Vpr.Data
{
    [Serializable]
    public class Lab : LabBase
    {
        // TODO: Implement...
        // comment
        // labOrderID
        // orderID

        [XmlElement("high")]
        public ValueElement High { get; set; }

        [XmlElement("interpretation")]
        public ValueElement Interpretation { get; set; }

        [XmlElement("localName")]
        public ValueElement LocalName { get; set; }

        [XmlElement("loinc")]
        public ValueElement Loinc { get; set; }

        [XmlElement("low")]
        public ValueElement Low { get; set; }

        [XmlElement("result")]
        public ValueElement Result { get; set; }

        [XmlElement("test")]
        public ValueElement Test { get; set; }

        [XmlElement("units")]
        public ValueElement Units { get; set; }

        [XmlElement("vuid")]
        public ValueElement VuId { get; set; }

    }
}
