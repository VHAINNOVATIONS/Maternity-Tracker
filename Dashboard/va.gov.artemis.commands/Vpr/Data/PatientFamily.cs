using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Serialization;

namespace VA.Gov.Artemis.Commands.Vpr.Data
{
    [Serializable]
    public class PatientFamily
    {
        [XmlArray("family_members")]
        [XmlArrayItem("family_member")]
        public List<FamilyMember> FamilyMembers { get; set; }

        [XmlArray("father_of_fetuses")]
        [XmlArrayItem("father_of_fetus")]
        public List<FatherOfFetus> FathersOfFetus { get; set; }
    }
}
