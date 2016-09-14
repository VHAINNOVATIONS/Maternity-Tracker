using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.CDA.Common;

namespace VA.Gov.Artemis.CDA.Raw
{
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.XmlRootAttribute("ClinicalDocument", Namespace = "urn:hl7-org:v3", IsNullable = false)]
    public class RawXdriDocument: IheDocument
    {
        public const string XdriTemplateId = "1.3.6.1.4.1.19376.1.2.21"; 

        public RawXdriDocument(): base()
        {
            List<II> templateIds = new List<II>();

            // *** XDR-I Id ***
            II templateId = new II() { root = XdriTemplateId };
            templateIds.Add(templateId);

            this.templateId = templateIds.ToArray();

            this.code = new CE()
            {
                code = "11528-7",
                codeSystem = CdaCode.LoincSystemId,
                displayName = "Radiology Report",
                codeSystemName = CdaCode.LoincSystemName
            };

            // *** NOTE: Could be customized locally or by system.
            this.title = new ST() { Text = new string[] { "Cross-Enterprise Document Reliable Interchange of Images" } };
        }
    }
}
