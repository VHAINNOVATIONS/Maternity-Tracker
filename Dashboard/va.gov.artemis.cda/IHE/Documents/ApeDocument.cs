using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.CDA.IHE.Sections;
using VA.Gov.Artemis.CDA.Raw;

namespace VA.Gov.Artemis.CDA.IHE.Documents
{
    public class ApeDocument: CdaDocument
    {
        public PatientEducationSection PatientEducationSection { get; set; }

        public ApeDocument()
        {
            this.PatientEducationSection = new PatientEducationSection(); 
        }

        public RawApeDocument ToRawDocument()
        {
            RawApeDocument returnDoc = new RawApeDocument();

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

            // *** Add patient education ***
            POCD_MT000040Component3 patientEducation = this.PatientEducationSection.ToPocdComponent();
            if (patientEducation != null)
                components.Add(patientEducation);

            body.component = components.ToArray();
            return returnDoc;
        }

    }
}
