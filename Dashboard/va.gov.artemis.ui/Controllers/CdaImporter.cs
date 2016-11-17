using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using System.Xml;
using System.Xml.Serialization;
using VA.Gov.Artemis.CDA;
using VA.Gov.Artemis.CDA.IHE.Sections;
using VA.Gov.Artemis.CDA.Observations;
using VA.Gov.Artemis.CDA.Raw;
using VA.Gov.Artemis.CDA.RecordTarget;
using VA.Gov.Artemis.Core;
using VA.Gov.Artemis.UI.Data.Cda;
using VA.Gov.Artemis.UI.Data.Models.Cda;
using VA.Gov.Artemis.UI.Data.Models.Edd;

namespace VA.Gov.Artemis.UI.Controllers
{
    public class CdaImporter
    {
        private string FileName { get; set; }
        public string DocumentContent { get; set; }
        private POCD_MT000040ClinicalDocument PocdDocument { get; set; }
        private Nullable<IheDocumentType> documentType { get; set; }

        public CdaImporter(string fileName)
        {
            this.FileName = fileName; 
        }

        public Nullable<IheDocumentType> DocumentType
        {
            get
            {
                if (!this.documentType.HasValue)
                    this.documentType = this.GetDocumentType();

                return this.documentType; 
            }
        }

        public CdaExtractedHeader ExtractDocumentHeader()
        {
            CdaExtractedHeader result = null;

            if (this.Initialize())
            {
                if (this.PocdDocument != null)
                {
                    result = new CdaExtractedHeader();

                    DateTime effectiveTime;
                    CultureInfo enUS = new CultureInfo("en-US");

                    // *** Document Date/Time ***
                    if (this.PocdDocument.effectiveTime != null)
                        if (!string.IsNullOrWhiteSpace(this.PocdDocument.effectiveTime.value))
                            if (DateTime.TryParseExact(this.PocdDocument.effectiveTime.value, RawCdaDocument.CdaDateFormat, enUS, DateTimeStyles.None, out effectiveTime))
                                result.CreationDateTime = effectiveTime;

                    // *** Check all document types ***
                    if (this.PocdDocument.templateId != null)
                        if (this.PocdDocument.templateId.Length > 0)
                            foreach (II templateId in this.PocdDocument.templateId)
                                switch (templateId.root)
                                {
                                    case RawAphpDocument.AphpTemplateId:
                                        result.DocumentType = IheDocumentType.APHP;
                                        break;
                                    case RawApsDocument.ApsTemplateId:
                                        result.DocumentType = IheDocumentType.APS;
                                        break;
                                    case RawApeDocument.ApeTemplateId:
                                        result.DocumentType = IheDocumentType.APE;
                                        break;
                                    case RawAplDocument.AplTemplateId:
                                        result.DocumentType = IheDocumentType.APL;
                                        break;
                                    case RawPpvsDocument.PpvsTemplateId:
                                        result.DocumentType = IheDocumentType.PPVS;
                                        break; 
                                    case RawXdriDocument.XdriTemplateId:
                                        result.DocumentType = IheDocumentType.XDR_I;
                                        break; 
                                    case RawMdsDocument.MdsTemplateId:
                                        result.DocumentType = IheDocumentType.MDS;
                                        break; 
                                    case RawNdsDocument.NdsTemplateId:
                                        result.DocumentType = IheDocumentType.NDS;
                                        break; 
                                }


                    // *** Get document id ***
                    if (this.PocdDocument.id != null)
                        result.Id = this.PocdDocument.id.root;

                    // *** Sender ***
                    if (this.PocdDocument.recordTarget != null)
                        if (this.PocdDocument.recordTarget.Length > 0)
                            if (this.PocdDocument.recordTarget[0].patientRole != null)
                                if (this.PocdDocument.recordTarget[0].patientRole.providerOrganization != null)
                                    if (this.PocdDocument.recordTarget[0].patientRole.providerOrganization.name != null)
                                        if (this.PocdDocument.recordTarget[0].patientRole.providerOrganization.name[0].Text != null)
                                            result.Sender = this.PocdDocument.recordTarget[0].patientRole.providerOrganization.name[0].Text[0];

                    // *** Title ***
                    if (this.PocdDocument.title != null)
                        if (this.PocdDocument.title.Text != null)
                            if (this.PocdDocument.title.Text.Length > 0)
                                result.Title = this.PocdDocument.title.Text[0];

                    // *** Recipient ****
                    result.IntendedRecipient = ExtractRecipient(this.PocdDocument);

                }
            }

            return result;
        }

        public List<POCD_MT000040Observation> ExtractPregnancyObservations()
        {
            // *** Extract pregnancy history observations from the document ***

            List<POCD_MT000040Observation> returnList = new List<POCD_MT000040Observation>();

            returnList = this.ExtractObservationsFromSection(new PregnancyHistorySection().Code);

            return returnList;
        }

        public List<POCD_MT000040Observation> ExtractEddObservations()
        {
            // *** Extract EDD Observations from the document ***

            List<POCD_MT000040Observation> returnList = new List<POCD_MT000040Observation>();

            List<POCD_MT000040Observation> tempList = this.ExtractObservationsFromSection(new EstimatedDeliveryDatesSection().Code); 

            foreach (var item in tempList)
                switch (item.code.code)
                {
                    case EddUtility.LmpDateCode: // "8665-2": // LMP
                    case EddUtility.EddFromLMPCode: //"11779-6": // EDD from LMP
                    case EddUtility.EstimatedGestationalAgeCode: //"11884-4": // GA
                    case EddUtility.EddCode: //"11778-8": // EDD
                        returnList.Add(item); 
                        break;
                }

            return returnList;
        }

        private List<POCD_MT000040Observation> ExtractObservationsFromSection(string sectionCode)
        {
            // *** Extract section observations from the document ***

            List<POCD_MT000040Observation> returnList = new List<POCD_MT000040Observation>();

            if (this.Initialize())
            {
                // *** Check if we have something to work with ***
                if (this.PocdDocument != null)
                    if (this.PocdDocument.component != null)
                        if (this.PocdDocument.component.Item is POCD_MT000040StructuredBody)
                        {
                            POCD_MT000040StructuredBody body = this.PocdDocument.component.Item as POCD_MT000040StructuredBody;

                            if (body.component != null)
                                if (body.component.Length > 0)
                                    foreach (var item in body.component)
                                        if (item.section != null)
                                            if (item.section.code != null)
                                                if (item.section.code.code == sectionCode)
                                                    if (item.section.entry != null)
                                                        foreach (var entry in item.section.entry)
                                                            if (entry.Item != null)
                                                                if (entry.Item is POCD_MT000040Observation)
                                                                {
                                                                    POCD_MT000040Observation pocdObs = entry.Item as POCD_MT000040Observation;
                                                                    returnList.Add(pocdObs);

                                                                    List<POCD_MT000040Observation> tempList = this.GetSupportingObservationsFromSection(pocdObs);
                                                                    returnList.AddRange(tempList);
                                                                }
                        }
            }

            return returnList;
        }

        public CdaRecordTarget ExtractRecordTarget()
        {
            // *** Extract basic patient information from the document content ***

            CdaRecordTarget returnRecordTarget = null;

            if (this.Initialize())
            {
                // *** Check if we have something to work with ***
                if (this.PocdDocument != null)
                    if (this.PocdDocument.recordTarget != null)
                        if (this.PocdDocument.recordTarget.Length > 0)
                        {
                            // *** Create the return value ***
                            returnRecordTarget = new CdaRecordTarget();

                            // *** Get the first record target ***
                            POCD_MT000040RecordTarget pocdRecordTarget = this.PocdDocument.recordTarget[0];

                            // *** Make sure we have a patient role section ***
                            if (pocdRecordTarget.patientRole != null)
                            {
                                // *** Get the SSN ***
                                returnRecordTarget.SSN = GetSSN(pocdRecordTarget.patientRole);

                                // *** Make sure we have a patient ***
                                if (pocdRecordTarget.patientRole.patient != null)
                                {
                                    // *** Create shortcut for patient ***
                                    POCD_MT000040Patient pat = pocdRecordTarget.patientRole.patient;

                                    // *** Get the date of birth ***
                                    returnRecordTarget.Patient.DateOfBirth = GetDOB(pat);

                                    // *** Get the name ***
                                    string[] name = GetName(pat.name);
                                    returnRecordTarget.Patient.Name.First = name[0];
                                    returnRecordTarget.Patient.Name.Last = name[1];

                                }
                            }
                        }
            }

            return returnRecordTarget;
        }

        private List<POCD_MT000040Observation> GetSupportingObservationsFromSection(POCD_MT000040Observation observation)
        {
            List<POCD_MT000040Observation> returnList = new List<POCD_MT000040Observation>();

            if (observation.entryRelationship != null) 
                foreach (var entryRel in observation.entryRelationship)
                    if (entryRel.Item is POCD_MT000040Observation)
                    {
                        POCD_MT000040Observation subObs = entryRel.Item as POCD_MT000040Observation;
                        returnList.Add(subObs);
                        List<POCD_MT000040Observation> tempList = this.GetSupportingObservationsFromSection(subObs);
                        returnList.AddRange(tempList);
                    }

            return returnList; 
        }

        private bool Initialize()
        {
            bool returnVal = false; 

            try
            {
                if (string.IsNullOrWhiteSpace(this.DocumentContent))
                    this.DocumentContent = System.IO.File.ReadAllText(this.FileName);

                if (this.PocdDocument == null)
                    this.PocdDocument = this.DeserializeContent(this.DocumentContent);

                returnVal = true; 
            }
            catch (Exception ex)
            {
                ErrorLogger.Log(ex, "Error Retrieving Document Type");
            }

            return returnVal; 
        }

        private string ExtractRecipient(POCD_MT000040ClinicalDocument doc)
        {
            // *** Gets the recipient string from a clinical doc ***

            string returnValue = "";

            // *** Create a working recipient ***
            CdaRecipient tempRecipient = new CdaRecipient();

            // *** Check for existence and drill down ***
            if (doc.informationRecipient != null)
                if (doc.informationRecipient.Length > 0)
                    if (doc.informationRecipient[0].intendedRecipient != null)
                    {
                        // *** Organization***
                        if (doc.informationRecipient[0].intendedRecipient.receivedOrganization != null)
                            if (doc.informationRecipient[0].intendedRecipient.receivedOrganization.name != null)
                                if (doc.informationRecipient[0].intendedRecipient.receivedOrganization.name.Length > 0)
                                    if (doc.informationRecipient[0].intendedRecipient.receivedOrganization.name[0].Text != null)
                                        tempRecipient.Organization = doc.informationRecipient[0].intendedRecipient.receivedOrganization.name[0].Text[0];

                        // *** Person Name ***
                        if (doc.informationRecipient[0].intendedRecipient.informationRecipient != null)
                            if (doc.informationRecipient[0].intendedRecipient.informationRecipient.name != null)
                            {
                                string[] names = GetName(doc.informationRecipient[0].intendedRecipient.informationRecipient.name);
                                tempRecipient.FirstName = names[0];
                                tempRecipient.LastName = names[1];
                            }

                        // *** Set result ***
                        returnValue = tempRecipient.ToString();
                    }

            return returnValue;
        }

        private static string[] GetName(PN[] pn)
        {
            string[] returnName = new string[] { "", "" };

            // *** Name ***
            if (pn != null)
                if (pn.Length > 0)
                {
                    PN name = pn[0];
                    if (name.Items != null)
                        if (name.Items.Length > 0)
                            foreach (ENXP enxp in name.Items)
                                if (enxp.Text != null)
                                    if (enxp.Text.Length > 0)
                                    {
                                        if (enxp is engiven)
                                            returnName[0] = enxp.Text[0];
                                        else if (enxp is enfamily)
                                            returnName[1] = enxp.Text[0];
                                    }
                }

            return returnName;
        }

        private Nullable<IheDocumentType> GetDocumentType()
        {
            Nullable<IheDocumentType> returnVal = null;

            // *** Check if the xml for the passed-in content is supported ***

            if (this.Initialize())
            {
                if (this.PocdDocument != null)
                {
                    // *** Look for document template id matching supported ***
                    // *** For now only APHP, but could be CCD or other IHE template ***

                    if (this.PocdDocument.templateId != null)
                        if (this.PocdDocument.templateId.Length > 0)
                            foreach (II templateId in this.PocdDocument.templateId)
                                switch (templateId.root)
                                {
                                    case RawAphpDocument.AphpTemplateId:
                                        returnVal = IheDocumentType.APHP;
                                        break;

                                    case RawApsDocument.ApsTemplateId:
                                        returnVal = IheDocumentType.APS;
                                        break;

                                    case RawAplDocument.AplTemplateId:
                                        returnVal = IheDocumentType.APL;
                                        break;

                                    case RawApeDocument.ApeTemplateId:
                                        returnVal = IheDocumentType.APE;
                                        break;

                                    case RawPpvsDocument.PpvsTemplateId:
                                        returnVal = IheDocumentType.PPVS;
                                        break;

                                    case RawXdriDocument.XdriTemplateId:
                                        returnVal = IheDocumentType.XDR_I;
                                        break;

                                    case RawNdsDocument.NdsTemplateId:
                                        returnVal = IheDocumentType.NDS;
                                        break;

                                    case RawMdsDocument.MdsTemplateId:
                                        returnVal = IheDocumentType.MDS;
                                        break;
                                }
                }
            }

            return returnVal;
        }

        private POCD_MT000040ClinicalDocument DeserializeContent(string content)
        {
            POCD_MT000040ClinicalDocument returnDocument = null;

            // *** Create a generic CDA serializer ***
            XmlSerializer serializer = new XmlSerializer(typeof(POCD_MT000040ClinicalDocument));

            // *** Create an xml reader ***
            using (XmlReader xmlReader = XmlReader.Create(new StringReader(content)))
            {
                // *** Check if it can deserialize ***
                if (serializer.CanDeserialize(xmlReader))
                {
                    // *** Deserialize ***
                    returnDocument = (POCD_MT000040ClinicalDocument)serializer.Deserialize(xmlReader);
                }
            }

            return returnDocument;
        }

        private string GetSSN(POCD_MT000040PatientRole patRole)
        {
            string returnVal = "";

            // *** SSN ***
            if (patRole.id != null)
                foreach (II tempII in patRole.id)
                    if (tempII.root == "2.16.840.1.113883.4.1")
                        if (!string.IsNullOrWhiteSpace(tempII.extension))
                            returnVal = tempII.extension;

            return returnVal;
        }

        private DateTime GetDOB(POCD_MT000040Patient pat)
        {
            DateTime returnDOB = DateTime.MinValue;

            CultureInfo enUS = new CultureInfo("en-US");

            // *** DOB ***
            if (pat.birthTime != null)
                if (!string.IsNullOrWhiteSpace(pat.birthTime.value))
                    DateTime.TryParseExact(pat.birthTime.value, "yyyyMMdd", enUS, DateTimeStyles.None, out returnDOB);

            return returnDOB;
        }

        public List<CdaObservationModel> ExtractDataElements()
        {
            List<CdaObservationModel> returnList = new List<CdaObservationModel>();

            if (this.Initialize())
            {
                if (this.documentType.Value == IheDocumentType.APE)
                {
                    // Education Topic 
                    List<POCD_MT000040Procedure> edItems = this.ExtractEducationProcedures();

                    if (edItems != null)
                        foreach (var edItem in edItems)
                        {
                            CdaSimpleObservation cdaObs = CdaObservationFactory.CreateObservation(edItem);

                            if ((cdaObs != null) && (cdaObs.Code != null))
                            {
                                CdaObservationModel tempObs = CdaObservationModel.Create(cdaObs);
                                returnList.Add(tempObs);
                            }
                        }
                }
                else if (this.documentType.Value == IheDocumentType.NDS)
                    returnList = this.ExtractBabyObservationsFromNds(); 
                else 
                {
                    List<POCD_MT000040Observation> pocdObsList = this.ExtractObservations();

                    foreach (var pocdObs in pocdObsList)
                    {
                        // *** Create a simple observation ***
                        CdaSimpleObservation cdaObs;

                        cdaObs = CdaObservationFactory.CreateObservation(pocdObs);

                        // *** Convert to model + add to return ***
                        if ((cdaObs != null) && (cdaObs.Code != null))
                        {
                            CdaObservationModel tempObs = CdaObservationModel.Create(cdaObs);
                            returnList.Add(tempObs);
                        }
                    }
                }
            }

            return returnList; 
        }

        private List<POCD_MT000040Observation> ExtractObservations()
        {
            List<POCD_MT000040Observation> returnList = new List<POCD_MT000040Observation>();

            switch (this.DocumentType.Value)
            {
                case IheDocumentType.APHP:
                    returnList = this.ExtractPregnancyObservations(); 
                    break; 

                case IheDocumentType.APS:
                    returnList = this.ExtractEddObservations();
                    break; 

                case IheDocumentType.APL:
                    returnList = this.ExtractLabObservations();
                    break; 

                case IheDocumentType.MDS:
                    returnList = this.ExtractMdsObservations();
                    break; 

                //case IheDocumentType.NDS:
                //    returnList = this.ExtractNdsObservations();
                //    break; 

                case IheDocumentType.PPVS:
                    returnList = this.ExtractPpvsObservations();
                    break; 
            }

            return returnList; 
        }

        private List<POCD_MT000040Observation> ExtractPpvsObservations()
        {
            List<POCD_MT000040Observation> returnList = new List<POCD_MT000040Observation>();

            returnList = this.ExtractObservationsFromSection(new LaborDeliveryEventsSection().Code);

            return returnList; 
        }

        //private List<POCD_MT000040Observation> ExtractNdsObservations()
        //{
        //    List<POCD_MT000040Observation> returnList = new List<POCD_MT000040Observation>();

        //    returnList = this.ExtractBabyObservationsFromNds();

        //    return returnList; 
        //}

        private List<POCD_MT000040Observation> ExtractMdsObservations()
        {
            List<POCD_MT000040Observation> returnList = new List<POCD_MT000040Observation>();

            returnList = this.ExtractObservationsFromSection("42545-4");

            return returnList; 
        }

        private List<POCD_MT000040Observation> ExtractLabObservations()
        {
            List<POCD_MT000040Observation> returnList = new List<POCD_MT000040Observation>();

            //returnList = this.ExtractObservationsFromSection(new LabResultsSection().Code); 
            
            return returnList; 

        }

        //internal List<POCD_MT000040Procedure> ExtractEducationProcedures()
        //{
        //    List<POCD_MT000040Procedure> returnList = new List<POCD_MT000040Procedure>();

        //    if (this.DocumentType == IheDocumentType.APE)
        //        returnList = this.ExtractEducationItems();

        //    return returnList;
        //}

        private List<POCD_MT000040Procedure> ExtractEducationProcedures()
        {
            List<POCD_MT000040Procedure> returnList = new List<POCD_MT000040Procedure>();

            // *** Extract section procedures from the document ***

            string sectionCode = "34895-3"; 

            if (this.Initialize())
            {
                // *** Check if we have something to work with ***
                if (this.PocdDocument != null)
                    if (this.PocdDocument.component != null)
                        if (this.PocdDocument.component.Item is POCD_MT000040StructuredBody)
                        {
                            POCD_MT000040StructuredBody body = this.PocdDocument.component.Item as POCD_MT000040StructuredBody;

                            if (body.component != null)
                                if (body.component.Length > 0)
                                    foreach (var item in body.component)
                                        if (item.section != null)
                                            if (item.section.code != null)
                                                if (item.section.code.code == sectionCode)
                                                    if (item.section.entry != null)
                                                        foreach (var entry in item.section.entry)
                                                            if (entry.Item != null)
                                                                if (entry.Item is POCD_MT000040Procedure)
                                                                {
                                                                    POCD_MT000040Procedure pocdProc = entry.Item as POCD_MT000040Procedure;
                                                                    returnList.Add(pocdProc);
                                                                }
                        }
            }

            return returnList; 
        }

        private List<CdaObservationModel> ExtractBabyObservationsFromNds()
        {
            // *** Extract section observations from the document ***

            List<CdaObservationModel> returnList = new List<CdaObservationModel>();
            int babyNumber = 0;

            if (this.Initialize())
            {
                // *** Check if we have something to work with ***
                if (this.PocdDocument != null)
                    if (this.PocdDocument.component != null)
                        if (this.PocdDocument.component.Item is POCD_MT000040StructuredBody)
                        {
                            POCD_MT000040StructuredBody body = this.PocdDocument.component.Item as POCD_MT000040StructuredBody;

                            if (body.component != null)
                                if (body.component.Length > 0)
                                    foreach (var item in body.component)
                                        if (item.section != null)
                                            if (item.section.code != null)
                                                if (item.section.code.code == "57075-4")
                                                    if (item.section.component != null)
                                                    {
                                                        foreach (var comp in item.section.component)
                                                        {
                                                            if (comp.section != null) 
                                                            {
                                                                if (comp.section.code.code == "10210-3")
                                                                if (comp.section.entry != null)
                                                                {
                                                                    ++babyNumber;

                                                                    List<POCD_MT000040Observation> pocdList = new List<POCD_MT000040Observation>();

                                                                    foreach (var entry in comp.section.entry)
                                                                        if (entry.Item != null)
                                                                            if (entry.Item is POCD_MT000040Observation)
                                                                            {
                                                                                POCD_MT000040Observation pocdObs = entry.Item as POCD_MT000040Observation;
                                                                                pocdList.Add(pocdObs);

                                                                                List<POCD_MT000040Observation> tempList = this.GetSupportingObservationsFromSection(pocdObs);
                                                                                pocdList.AddRange(tempList);
                                                                            }

                                                                    foreach (var pocdObs in pocdList)
                                                                    {
                                                                        // *** Create a simple observation ***
                                                                        CdaSimpleObservation cdaObs = CdaObservationFactory.CreateObservation(pocdObs);

                                                                        // *** Convert to model + add to return ***
                                                                        if ((cdaObs != null) && (cdaObs.Code != null))
                                                                        {
                                                                            CdaObservationModel tempObs = CdaObservationModel.Create(cdaObs);
                                                                            tempObs.BabyNumber = babyNumber;
                                                                            returnList.Add(tempObs);
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                        }
            }

            return returnList;
        }
    }
}