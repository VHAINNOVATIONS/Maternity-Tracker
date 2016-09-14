using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace VA.Gov.Artemis.Commands.Vpr.Data
{
    [Serializable]
    [XmlRoot("procedure")]
    public class ClinicalProcedure: ClinicalItem
    {
        // TODO: Implement...
        // consult
        // interpretation
        // order
        // requested

        [XmlElement("case")]
        public ValueElement Case { get; set; }

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

        [XmlElement("hasImages")]
        public ValueElement HasImages { get; set; }

        [XmlElement("imagingType")]
        public CodeElement ImagingType { get; set; }


    }
}
