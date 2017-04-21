// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.CDA.Common;

namespace VA.Gov.Artemis.CDA.Raw
{
    [System.Xml.Serialization.XmlRootAttribute("ClinicalDocument", Namespace = "urn:hl7-org:v3", IsNullable = false)]
    public class RawApeDocument : IheDocument
    {
        public const string MedicalDocumentTemplateId = "1.3.6.1.4.1.19376.1.5.3.1.1.1"; 
        public const string ApeTemplateId = "1.3.6.1.4.1.19376.1.5.3.1.1.16.1.3";

        public RawApeDocument(): base()
        {
            this.code = new CE()
            {
                code = "34895-3",
                codeSystem = CdaCode.LoincSystemId,
                codeSystemName = CdaCode.LoincSystemName,
                displayName = "Education Note"
            };

            List<II> templateIds = new List<II>();

            templateIds.Add(new II() { root = MedicalDocumentTemplateId });
            templateIds.Add(new II() { root = ApeTemplateId });

            this.templateId = templateIds.ToArray();

            this.title = new ST() { Text = new string[] { "Antepartum Education Note" } };
        }
    }
}
