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
    public abstract class LabBase: ClinicalItem
    {
        [XmlElement("collected")]
        public VprDateTime Collected { get; set; }

        [XmlElement("groupName")]
        public ValueElement GroupName { get; set; }

        [XmlElement("resulted")]
        public VprDateTime Resulted { get; set; }

        [XmlElement("specimen")]
        public CodeElement Specimen { get; set; }

        [XmlElement("status")]
        public ValueElement Status { get; set; }

        [XmlElement("type")]
        public ValueElement AccessionType { get; set; }

        [XmlElement("sample")]
        public ValueElement Sample { get; set; }

    }
}
