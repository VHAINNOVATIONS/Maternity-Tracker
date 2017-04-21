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
    public class Procedure: ClinicalItem
    {
        // TODO: From docs...

        // encounter

        [XmlElement("category")]
        public ValueElement Category { get; set; }

        [XmlElement("dateTime")]
        public VprDateTime ProcedureDateTime { get; set; }
       
        [XmlElement("provider")]
        public CodeElement Provider { get; set; }

        [XmlElement("status")]
        public ValueElement Status { get; set; }

        [XmlElement("type")]
        public CodeElement ProcedureType { get; set; }

        [XmlArray("documents")]
        [XmlArrayItem("document")]
        public List<DocumentHeader> Documents { get; set; }

        [XmlElement("case")]
        public ValueElement Case { get; set; }

        [XmlElement("hasImages")]
        public ValueElement HasImages { get; set; }

        [XmlElement("imagingType")]
        public CodeElement ImagingType { get; set; }

    }
}
