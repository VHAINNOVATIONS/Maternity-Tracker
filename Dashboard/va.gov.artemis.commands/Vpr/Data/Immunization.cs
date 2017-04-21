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
    public class Immunization: ClinicalItem
    {
        // TODO: From docs...

        // comment

        [XmlElement("administered")]
        public ValueElement Administered { get; set; }

        [XmlElement("contraindicated")]
        public ValueElement Contraindicated { get; set; }

        [XmlElement("cpt")]
        public CodeElement Cpt { get; set; }

        [XmlElement("encounter")]
        public ValueElement Encounter { get; set; }

        [XmlElement("provider")]
        public CodeElement Provider { get; set; }

        [XmlElement("reaction")]
        public ValueElement Reaction { get; set; }

        [XmlElement("series")]
        public ValueElement Series { get; set; }

    }
}
