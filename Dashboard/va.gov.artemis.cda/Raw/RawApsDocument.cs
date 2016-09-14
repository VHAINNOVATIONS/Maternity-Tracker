using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace VA.Gov.Artemis.CDA.Raw
{
    [System.Xml.Serialization.XmlRootAttribute("ClinicalDocument", Namespace = "urn:hl7-org:v3", IsNullable = false)]
    public class RawApsDocument : IheDocument
    {
        public const string ApsTemplateId = "1.3.6.1.4.1.19376.1.5.3.1.1.11.2"; 

        public RawApsDocument()
            : base()
        {
            //<code code='2.16.1.2' codeSystem='2.4' displayName='loinc'/>
            // <code code='57055-6' displayName='Antepartum summary' codeSystem='2.16.840.1.113883.6.1' codeSystemName='LOINC'/>
            //this.code = new CE() { code = "2.16.1.2", codeSystem = "2.4", displayName = "LOINC" };
            this.code = new CE() 
            { 
                code = "57055-6", 
                codeSystem = "2.16.840.1.113883.6.1", 
                displayName = "Antepartum Summary", 
                codeSystemName="LOINC" 
            };

            List<II> templateIds = new List<II>();

            templateIds.Add(new II() { root = IheDocument.MedicalSummaryTemplateId });
            templateIds.Add(new II() { root = ApsTemplateId });

            this.templateId = templateIds.ToArray();

            this.title = new ST() { Text = new string[] { "Antepartum Summary" } };
        }
    }
}