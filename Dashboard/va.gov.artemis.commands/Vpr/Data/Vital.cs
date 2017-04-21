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
    public class Vital : ClinicalItem
    {
        // TODO: Implement...
        // removed

        [XmlElement("entered")]
        public VprDateTime Entered { get; set; }

        [XmlArray("measurements")]
        [XmlArrayItem("measurement")]
        public List<Measurement> Measurements { get; set; }

        [XmlElement("taken")]
        public VprDateTime Taken { get; set; }

        [XmlArray("qualifiers")]
        [XmlArrayItem("qualifier")]
        public List<CodeElement> Qualifiers { get; set; }

    }

}
