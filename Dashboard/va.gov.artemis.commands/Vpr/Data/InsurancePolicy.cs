using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Serialization;

namespace VA.Gov.Artemis.Commands.Vpr.Data
{
    [Serializable]
    public class InsurancePolicy: ClinicalItem
    {
        // TODO...

        // company (id, name, address, telecom) 
        // expirationDate
        // groupName
        // groupNumber
        // insuranceType

        [XmlElement("company")]
        public Company Company { get; set; }

        [XmlElement("effectiveDate")]
        public ValueElement EffectiveDate { get; set; }

        [XmlElement("relationship")]
        public ValueElement Relationship { get; set; }

        [XmlElement("subscriber")]
        public CodeElement Subscriber { get; set; }
    }
}
