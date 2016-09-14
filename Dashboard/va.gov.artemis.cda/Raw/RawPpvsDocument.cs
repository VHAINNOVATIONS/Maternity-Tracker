using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.CDA.Raw
{
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.XmlRootAttribute("ClinicalDocument", Namespace = "urn:hl7-org:v3", IsNullable = false)]
    public class RawPpvsDocument: IheDocument
    {
        public const string PpvsTemplateId = "1.3.6.1.4.1.19376.1.5.3.1.1.21.1.4";
        public const string MedicalDocumentsTemplateId = "1.3.6.1.4.1.19376.1.5.3.1.1.1"; 

        public RawPpvsDocument(): base()
        {
            List<II> templateIds = new List<II>();

            // *** Ppvs Id's ***
            II templateId = new II() { root = MedicalDocumentsTemplateId };
            templateIds.Add(templateId);

            templateId = new II() { root = PpvsTemplateId };
            templateIds.Add(templateId);

            templateId = new II() { root = IheDocument.MedicalSummaryTemplateId };
            templateIds.Add(templateId);

            this.templateId = templateIds.ToArray();

            // *** NOTE: No specific loinc code for this document, using generic history and physical note code ***
            //<code code='XX-PostpartumVisitSummary' displayName='Postpartum visit summary' codeSystem='2.16.840.1.113883.6.1' codeSystemName='LOINC'/>
            this.code = new CE() { code = "XX-PostPartumVisitSummary", codeSystem = "2.16.840.1.113883.6.1", displayName = "Postpartum Visit Summary", codeSystemName = "LOINC" };

            // *** NOTE: Could be customized locally or by system.
            this.title = new ST() { Text = new string[] { "Postpartum Visit Summary" } };
        }
    }
}
