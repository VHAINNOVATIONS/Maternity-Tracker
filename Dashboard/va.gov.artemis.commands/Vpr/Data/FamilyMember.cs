// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Serialization;

namespace VA.Gov.Artemis.Commands.Vpr.Data
{
    [Serializable]
    public class FamilyMember
    {
        [XmlAttribute("name")]
        public string Name { get; set; }

        [XmlAttribute("relationship")]
        public virtual string Relationship { get; set; }

        [XmlElement("address")]
        public Address Address { get; set; }

        [XmlArray("telecomList")]
        [XmlArrayItem("telecom")]
        public List<PhoneNumber> PhoneNumbers { get; set; }

    }
}
