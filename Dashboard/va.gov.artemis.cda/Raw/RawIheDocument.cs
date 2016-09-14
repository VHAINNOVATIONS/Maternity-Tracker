using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml;
using System.Xml.Serialization;

namespace VA.Gov.Artemis.CDA
{
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.XmlRootAttribute("ClinicalDocument", Namespace = "urn:hl7-org:v3", IsNullable = false)]
    public partial class IheDocument : RawCdaDocument
    {
        public const string MedicalSummaryTemplateId = "1.3.6.1.4.1.19376.1.5.3.1.1.2"; 

        [XmlAttributeAttribute("schemaLocation", AttributeName = "schemaLocation", Namespace = "http://www.w3.org/2001/XMLSchema-instance")]
        public string SchemaLocation = "urn:hl7-org:v3 infrastructure/cda/CDA.xsd";

        public IheDocument()
            : base()
        {
        }
    }
}