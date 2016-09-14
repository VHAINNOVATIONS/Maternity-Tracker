using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace VA.Gov.Artemis.Commands.Vpr.Data
{
    [Serializable]
    public class Support
    {
        [XmlAttribute(AttributeName = "name")]
        public string Name { get; set; }

        [XmlAttribute(AttributeName = "relationship")]
        public string Relationship { get; set; }

        [XmlAttribute(AttributeName = "contactType")]
        public string ContactType { get; set; }

        [XmlElement(ElementName = "address")]
        public Address Address { get; set; }

        [XmlArray("telecomList")]
        [XmlArrayItem("telecom")]
        public List<PhoneNumber> PhoneNumbers { get; set; }

    }
}
