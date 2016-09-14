using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.Commands.Vpr.Data
{
    [Serializable]
    public class Patient
    {
        // TODO:...
        // Alias [m]
        // Died
        // Disability [m]
        // Exposure [m]
        // flag [m]
        // race [m]
        // support [m]

        [XmlElement("id")]
        public ValueElement PatientId { get; set; }

        [XmlElement("address")]
        public Address Address { get; set; }

        [XmlElement("bid")]
        public ValueElement Bid { get; set; }

        [XmlElement("dob")]
        public VprDateTime DateOfBirth { get; set; }

        [XmlArray("facilities")]
        [XmlArrayItem("facility")]
        public List<Facility> Facilities { get; set; }

        [XmlElement("familyName")]
        public ValueElement LastName { get; set; }

        [XmlElement("fullName")]
        public ValueElement FullName { get; set; }

        [XmlElement("gender")]
        public ValueElement Gender { get; set; }

        [XmlElement("givenNames")]
        public ValueElement FirstName { get; set; }

        [XmlElement("icn")]
        public ValueElement Icn { get; set; }

        // TODO: what is this?
        [XmlElement("lrdfn")]
        public ValueElement Lrdfn { get; set; }

        // TODO: make enum?
        [XmlElement("maritalStatus")]
        public ValueElement MaritalStatus { get; set; }

        [XmlElement("religion")]
        public ValueElement Religion { get; set; }

        // *** Service Connected ***
        [XmlElement("sc")]
        public ValueElement Sc { get; set; }

        // *** Service Connected Percent ***
        [XmlElement("scPercent")]
        public ValueElement ScPercent { get; set; }

        [XmlElement("sensitive")]
        public ValueElement Sensitive { get; set; }

        [XmlElement("ssn")]
        public ValueElement SocialSecurityNumber { get; set; }

        [XmlArray("telecomList")]
        [XmlArrayItem("telecom")]
        public List<PhoneNumber> PhoneNumbers { get; set; }

        // TODO: boolean?
        [XmlElement("veteran")]
        public ValueElement Veteran { get; set; }

        [XmlArray("supports")]
        [XmlArrayItem("support")]
        public List<Support> Supports { get; set; }

        [XmlArray("ethnicities")]
        [XmlArrayItem("ethnicity")]
        public List<ValueElement> Ethnicities { get; set; }

        [XmlArray("races")]
        [XmlArrayItem("race")]
        public List<ValueElement> Races { get; set; }

    }

}
