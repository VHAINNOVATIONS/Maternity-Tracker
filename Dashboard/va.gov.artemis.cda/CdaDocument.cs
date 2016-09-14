using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;
using System.Xml.Serialization;
using VA.Gov.Artemis.CDA.DocumentationOf;
using VA.Gov.Artemis.CDA.Participant;
using VA.Gov.Artemis.CDA.RecordTarget;

namespace VA.Gov.Artemis.CDA
{
    public abstract class CdaDocument
    {
        public string DocumentId { get; set; }

        public CdaRecordTarget RecordTarget { get; set; }
        public CdaProviderAuthor Author { get; set; }
        public CdaDeviceAuthor DeviceAuthor { get; set; }
        public CdaRecipient Recipient { get; set; }
        public CdaParticipantList Participants { get; set; }
        public CdaDocumentationOf DocumentationOf { get; set; }
        public CdaCustodian Custodian { get; set; }

        public CdaAllergies Allergies { get; set; }

        public CdaDocument()
        {
            this.RecordTarget = new CdaRecordTarget();
            this.Author = new CdaProviderAuthor();
            this.DeviceAuthor = new CdaDeviceAuthor(); 
            this.Recipient = new CdaRecipient();
            this.Participants = new CdaParticipantList();
            this.DocumentationOf = new CdaDocumentationOf();
            this.Custodian = new CdaCustodian();
            this.Allergies = new CdaAllergies(); 
        }

        //public abstract string ToCdaXml();

        protected POCD_MT000040ClinicalDocument AddRawDocumentData(POCD_MT000040ClinicalDocument rawDoc)
        {
            // *** Set the realm to US ***
            //rawDoc.realmCode = new List<CS>();
            //rawDoc.realmCode.Add(new CS() { code = "US" });

            // *** All documents will have this type ***
            rawDoc.typeId = new POCD_MT000040InfrastructureRoottypeId() { root = "2.16.840.1.113883.1.3", extension = "POCD_HD000040" };

            // *** Date/Time of Creation ***
            //<effectiveTime value='20000407130000+0500'/>
            rawDoc.effectiveTime = new TS() { value = DateTime.Now.ToString(RawCdaDocument.CdaDateFormat) };

            // *** Confidentiality ***
            //<confidentialityCode code='N' codeSystem='2.16.840.1.113883.5.25'/>
            rawDoc.confidentialityCode = new CE() { code = "N", codeSystem = "2.16.840.1.113883.5.25" };

            // *** Language ***
            //<languageCode code='en-US'/>
            rawDoc.languageCode = new CS() { code = "en-US" };

            // *** Set id ***
            rawDoc.id = new II() { root = this.DocumentId };

            // *** Record Target ***
            POCD_MT000040RecordTarget rt = this.RecordTarget.ToPocdRecordTarget();
            rawDoc.recordTarget = new POCD_MT000040RecordTarget[]{rt};

            // *** Information Recipient ***
            rawDoc.informationRecipient = this.Recipient.ToPocdRecipient(); 

            // *** Participants ***
            rawDoc.participant = this.Participants.ToPocdParticpantArray(); 

            // *** Authors ***
            List<POCD_MT000040Author> authorList = new List<POCD_MT000040Author>();

            // *** Device Author ***
            if (!this.DeviceAuthor.IsEmpty)
            {
                POCD_MT000040Author pocdDevAuthor = this.DeviceAuthor.ToPocdAuthor();
                authorList.Add(pocdDevAuthor);
            }

            // *** Author - Current User ***
            POCD_MT000040Author pocdAuthor = this.Author.ToPocdAuthor();
            authorList.Add(pocdAuthor);

            rawDoc.author = authorList.ToArray();

            // *** Custodian ***
            rawDoc.custodian = this.Custodian.ToPocdCustodian(); 

            // *** Documentation Of ***
            rawDoc.documentationOf = new POCD_MT000040DocumentationOf[]{this.DocumentationOf.ToPocdDocumentationOf()};

            // *** Document Body ***
            rawDoc.component = new POCD_MT000040Component2();
            POCD_MT000040StructuredBody body = new POCD_MT000040StructuredBody();

            // *** Create list of component/sections ***
            List<POCD_MT000040Component3> componentList = new List<POCD_MT000040Component3>(); 

            // *** Add allergy section ***
            POCD_MT000040Component3 allergySection = this.Allergies.ToPocdComponent();
            if (allergySection != null)
                componentList.Add(allergySection); 

            // TODO: Add additional sections here...

            // *** Add the sections/component to body ***
            body.component = componentList.ToArray(); 

            // *** Add body ***
            rawDoc.component.Item = body;

            return rawDoc; 
        }
    }
}
