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
    public class CurrentUser
    {
        [XmlElement("address")]
        public Address Address { get; set; }

        [XmlArray("facilities")]
        [XmlArrayItem("facility")]
        public List<Facility> Facilities { get; set; }

        [XmlElement("name")]
        public ValueElement Name { get; set; }

        [XmlElement("npi")]
        public ValueElement Npi { get; set; }

        [XmlArray("telecomList")]
        [XmlArrayItem("telecom")]
        public List<PhoneNumber> PhoneNumbers { get; set; }
    }
}
