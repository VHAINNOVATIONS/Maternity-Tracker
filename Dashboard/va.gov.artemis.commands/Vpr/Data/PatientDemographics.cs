using System;
using System.Xml.Serialization;

namespace VA.Gov.Artemis.Commands.Vpr.Data
{
    [Serializable]
    public class PatientDemographics
    {
        [XmlElement("patient")]
        public Patient Patient { get; set; }

        [XmlAttribute("total")]
        public int Total { get; set; }
    }
}
