// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;
using System.Xml.Serialization;
using VA.Gov.Artemis.CDA.IHE.Sections;
using VA.Gov.Artemis.CDA.Participant;
using VA.Gov.Artemis.CDA.Raw;

namespace VA.Gov.Artemis.CDA.IHE.Documents
{
    public class AphpDocument: CdaDocument 
    {
        public PregnancyHistorySection PregnancyHistorySection { get; set; }
        public ChiefComplaintSection ChiefComplaint { get; set; }
        public HistoryOfPresentIllnessSection HistoryOfPresentIllness { get; set; }
        public HistoryOfPastIllnessSection HistoryOfPastIllness { get; set; }
        public CodedHistoryOfInfectionSection CodedHistoryOfInfection { get; set; }
        public CodedSocialHistorySection SocialHistory { get; set; }
        public CodedFamilyMedicalHistorySection FamilyMedicalHistory { get; set; }
        public ReviewOfSystemsSection ReviewOfSystems { get; set; }
        public CodedPhysicalExamSection PhysicalExam { get; set; }

        public AphpDocument() 
        {
            this.PregnancyHistorySection = new PregnancyHistorySection();
            this.ChiefComplaint = new ChiefComplaintSection();
            this.HistoryOfPresentIllness = new HistoryOfPresentIllnessSection();
            this.HistoryOfPastIllness = new HistoryOfPastIllnessSection();
            this.CodedHistoryOfInfection = new CodedHistoryOfInfectionSection();
            this.SocialHistory = new CodedSocialHistorySection();
            this.FamilyMedicalHistory = new CodedFamilyMedicalHistorySection();
            this.ReviewOfSystems = new ReviewOfSystemsSection();
            this.PhysicalExam = new CodedPhysicalExamSection(); 
        }

        public AphpDocument(string cdaXml)
        {
            // TODO: Deserialize

            // *** Deserialize ***

            // *** Convert from Raw ***
            
        }        

        public RawAphpDocument ToRawDocument()
        {
            // *** Converts this object to a raw APHP document ***

            RawAphpDocument returnDoc = new RawAphpDocument();

            // *** Get base type ***
            POCD_MT000040ClinicalDocument arg = returnDoc as POCD_MT000040ClinicalDocument;

            // *** Populate from base ***
            arg =  this.AddRawDocumentData(arg);

            // *** This is the list of body sections
            List<POCD_MT000040Component3> components = new List<POCD_MT000040Component3>();

            // *** After all sections are added, add as array ***
            POCD_MT000040StructuredBody body = arg.component.Item as POCD_MT000040StructuredBody;

            // *** Add existing ***            
            components.AddRange(body.component); 
            
            // *** Add chief complaint ***
            POCD_MT000040Component3 chiefComplaint = this.ChiefComplaint.ToPocdComponent();
            if (chiefComplaint != null)
                components.Add(chiefComplaint); 

            // *** Add history of present illness ***
            POCD_MT000040Component3 presentIllness = this.HistoryOfPresentIllness.ToPocdComponent();
            if (presentIllness != null)
                components.Add(presentIllness); 

            // *** Add history of past illness ***
            POCD_MT000040Component3 pastIllness = this.HistoryOfPastIllness.ToPocdComponent();
            if (presentIllness != null)
                components.Add(pastIllness);

            // *** Add coded history of infection ***
            POCD_MT000040Component3 infection = this.CodedHistoryOfInfection.ToPocdComponent();
            if (infection != null)
                components.Add(infection);

            // *** Add pregnancy history ***
            POCD_MT000040Component3 pregHist = this.PregnancyHistorySection.ToPocdComponent();
            if (pregHist != null)
                components.Add(pregHist);

            // *** Add coded social history ***
            POCD_MT000040Component3 socialHistory = this.SocialHistory.ToPocdComponent();
            if (socialHistory != null)
                components.Add(socialHistory);

            // *** Add coded family medical history ***
            POCD_MT000040Component3 familyMedicalHistory = this.FamilyMedicalHistory.ToPocdComponent();
            if (familyMedicalHistory != null)
                components.Add(familyMedicalHistory); 

            // *** Add review of systems ***
            POCD_MT000040Component3 reviewOfSystems = this.ReviewOfSystems.ToPocdComponent();
            if (reviewOfSystems != null)
                components.Add(reviewOfSystems); 

            // *** Add coded physical exam ***
            POCD_MT000040Component3 physicalExam = this.PhysicalExam.ToPocdComponent();
            if (physicalExam != null)
                components.Add(physicalExam); 

            body.component = components.ToArray();

            return returnDoc; 
        }
        
        public string ToCdaXml()
        {
            // *** Generates the CDA xml from the raw document ***

            // *** Create a string builder ***
            StringBuilder sb = new StringBuilder(); 

            // *** Get the raw document ***
            RawAphpDocument rawDoc = this.ToRawDocument();

            // *** Create serializer ***
            XmlSerializer serializer = new XmlSerializer(typeof(RawAphpDocument));

            // *** Add some xml settings ***
            XmlWriterSettings settings = new XmlWriterSettings();
            settings.Encoding = Encoding.UTF8;
            settings.Indent = true;
            settings.NewLineHandling = NewLineHandling.Replace;

            // *** Serialize It ***
            using (XmlWriter writer = XmlWriter.Create(sb, settings))
            {
                // *** Add the style sheet processing instruction ***
                writer.WriteProcessingInstruction("xml-stylesheet", "type=\"text/xsl\" href=\"CDA.xsl\"");

                serializer.Serialize(writer, rawDoc);
            }

            return sb.ToString(); 
        }        
    }
}
