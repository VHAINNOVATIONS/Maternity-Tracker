// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.CDA.Common;
using VA.Gov.Artemis.CDA.IHE.Sections;
using VA.Gov.Artemis.CDA.Raw;

namespace VA.Gov.Artemis.CDA.IHE.Documents
{
    public class AplDocument: CdaDocument
    {
        public CdaCode Code { get; set; }

        public List<LabResultsSection> Sections { get; set; }

        public AplDocument()
        {
            this.Sections = new List<LabResultsSection>(); 

            //<code code='26436-6' displayName='Laboratory Studies' codeSystem='2.16.840.1.113883.6.1' codeSystemName='LOINC'/>
            this.Code = new CdaCode() { CodeSystem = CodingSystem.Loinc, Code = "26436-6", DisplayName = "Laboratory Studies" };
        }

        public RawAplDocument ToRawDocument()
        {
            RawAplDocument returnDoc = new RawAplDocument();

            // *** Get base type ***
            POCD_MT000040ClinicalDocument arg = returnDoc as POCD_MT000040ClinicalDocument;

            // *** Populate from base ***
            arg = this.AddRawDocumentData(arg);

            // *** This is the list of body sections
            List<POCD_MT000040Component3> components = new List<POCD_MT000040Component3>();

            // *** After all sections are added, add as array ***
            POCD_MT000040StructuredBody body = arg.component.Item as POCD_MT000040StructuredBody;

            // *** Add existing ***            
            components.AddRange(body.component);

            // *** Add lab results ***
            foreach (var section in this.Sections)
            {
                POCD_MT000040Component3 labResults = section.ToPocdComponent();
                if (labResults != null)
                    components.Add(labResults);
            }

            body.component = components.ToArray();
            return returnDoc;
        }
    }
}
