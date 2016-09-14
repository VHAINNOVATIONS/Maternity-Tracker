using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace VA.Gov.Artemis.CDA.Raw
{
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.XmlRootAttribute("ClinicalDocument", Namespace = "urn:hl7-org:v3", IsNullable = false)]
    public class RawAphpDocument : IheDocument
    {
        public const string AphpTemplateId = "1.3.6.1.4.1.19376.1.5.3.1.1.16.1.1"; 

        public RawAphpDocument()
            : base()
        {
            List<II> templateIds = new List<II>();

            // *** APHP Id's ***
            //<templateId root='1.3.6.1.4.1.19376.1.5.3.1.1.2'/><!--Medical Summary-->
            II templateId = new II() { root = IheDocument.MedicalSummaryTemplateId };
            templateIds.Add(templateId);

            //<templateId root='1.3.6.1.4.1.19376.1.5.3.1.1.16.1.4'/><!--History and Physical-->  
            templateId = new II() { root = "1.3.6.1.4.1.19376.1.5.3.1.1.16.1.4" };
            templateIds.Add(templateId);

            //<templateId root='1.3.6.1.4.1.19376.1.5.3.1.1.16.1.1'/><!--Antepartum History and Physical-->
            templateId = new II() { root = AphpTemplateId };
            templateIds.Add(templateId);

            this.templateId = templateIds.ToArray();

            // *** NOTE: No specific loinc code for this document, using generic history and physical note code ***
            //<code code='34117-2' displayName='HISTORY AND PHYSICAL' codeSystem='2.16.840.1.113883.6.1' codeSystemName='LOINC'/>
            this.code = new CE() { code = "34117-2", codeSystem = "2.16.840.1.113883.6.1", displayName = "HISTORY AND PHYSICAL", codeSystemName = "LOINC" };

            // *** NOTE: Could be customized locally or by system.
            this.title = new ST() { Text = new string[] { "Antepartum History & Physical" } };

        }
    }
}