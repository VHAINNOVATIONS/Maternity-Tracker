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
    public class RawAplDocument: IheDocument
    {
        public const string LabReportSummaryTemplateId = "1.3.6.1.4.1.19376.1.3.3"; 
        public const string AplTemplateId = "1.3.6.1.4.1.19376.1.5.3.1.1.16.1.2";

        public RawAplDocument(): base()
        {
            this.code = new CE()
            {
                code = "26436-6",
                codeSystem = CdaCode.LoincSystemId,
                codeSystemName = CdaCode.LoincSystemName,
                displayName = "Laboratory Studies"
            };

            List<II> templateIds = new List<II>();

            templateIds.Add(new II() { root = LabReportSummaryTemplateId });
            templateIds.Add(new II() { root = AplTemplateId });

            this.templateId = templateIds.ToArray();

            this.title = new ST() { Text = new string[] { "Antepartum Laboratory Results" } };

            this.realmCode = new List<CS> { new CS() { code = "USA" } };

            this.setId = new II() { root = Guid.NewGuid().ToString() }; 
        }
    }
}
