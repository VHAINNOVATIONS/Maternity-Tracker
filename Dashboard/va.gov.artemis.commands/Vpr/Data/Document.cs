using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace VA.Gov.Artemis.Commands.Vpr.Data
{
    [Serializable]
    public class Document: ClinicalItem 
    {
        // TODO: Implement...
        // category
        // content
        // images
        // loinc
        // nationalTitle
        // nationalTitleRole
        // nationalTitleService
        // nationalTitleSetting
        // nationalTitleSubject
        // nationalTitleType
        // parent
        // subject

        //[XmlElement("id")]
        //public ValueElement DocumentId { get; set; }

        [XmlElement("localTitle")]
        public ValueElement LocalTitle { get; set; }

        [XmlElement("status")]
        public ValueElement Status { get; set; }

        [XmlArray("clinicians")]
        [XmlArrayItem("clinician")]
        public List<Clinician> Clinicians { get; set; }

        [XmlElement("documentClass")]
        public ValueElement DocumentClass { get; set; }

        [XmlElement("encounter")]
        public ValueElement Encounter { get; set; }

        [XmlElement("referenceDateTime")]
        public VprDateTime ReferenceDateTime { get; set; }

        [XmlElement("type")]
        public ValueElement DocumentType { get; set; }

    }
}
