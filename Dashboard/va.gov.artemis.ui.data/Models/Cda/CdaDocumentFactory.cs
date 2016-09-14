using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.CDA;
using VA.Gov.Artemis.CDA.IHE;
using VA.Gov.Artemis.CDA.IHE.Documents;
using VA.Gov.Artemis.CDA.IHE.Sections;
using VA.Gov.Artemis.CDA.ValueSets;
using VA.Gov.Artemis.UI.Data.Cda;

namespace VA.Gov.Artemis.UI.Data.Models.Cda
{
    public class CdaDocumentFactory
    {
        public static AphpDocument CreateAphpDocument(CdaSource source)
        {
            // *** Creates the APHP document ***

            AphpDocument aphp = new AphpDocument();

            // *** Set id ***
            Guid tempGuid = new Guid(source.DocumentId);
            aphp.DocumentId = tempGuid.ToString();

            // *** Create Record Target Section ***
            aphp.RecordTarget = CdaSectionFactory.CreateRecordTarget(source.VprData.Demographics);

            // *** Add provider organization to record target ***
            aphp.RecordTarget.ProviderOrganization = CdaSectionFactory.CreateProviderOrganization(source.VprData.Demographics, source.ProviderOrganizationPhone);

            // *** Create Device Author ***
            // TODO: Skip device author...?
            //aphp.DeviceAuthor = new CdaDeviceAuthor();
            //aphp.DeviceAuthor.AssignedAuthoringDevice.ManufacturerModelName = source.ManufacturerModelName;
            //aphp.DeviceAuthor.AssignedAuthoringDevice.SoftwareName = source.SoftwareName; 

            // *** Create Author ***
            aphp.Author = CdaSectionFactory.CreateAuthor(source.VprData);

            // *** Information Recipient ***
            aphp.Recipient = new CdaRecipient();
            aphp.Recipient.FirstName = source.Options.IntendedRecipientFirstName;
            aphp.Recipient.LastName = source.Options.IntendedRecipientLastName;
            aphp.Recipient.Organization = source.Options.IntendedRecipientOrganization;

            // *** Participants ***
            aphp.Participants = CdaSectionFactory.CreateParticipants(source.VprData);

            // *** Custodian ***
            aphp.Custodian = CdaSectionFactory.CreateCustodian(aphp.RecordTarget.ProviderOrganization);

            // *** Documentation Of ***
            aphp.DocumentationOf = CdaSectionFactory.CreateDocumentationOf();

            // *** Chief Complaint *** 
            aphp.ChiefComplaint = CdaSectionFactory.CreateChiefComplaintSection(source.Observations);

            // *** History of Present Illness ***
            aphp.HistoryOfPresentIllness = CdaSectionFactory.CreatePresentIllnessSection(source.Observations);

            // *** History of Past Illness ***
            ValueSet vs;
            if (source.ValueSets.TryGetValue(ValueSetType.HistoryOfPastIllness, out vs))
                aphp.HistoryOfPastIllness = CdaSectionFactory.CreatePastIllnessSection(source.Observations, (HistoryOfPastIllnessValueSet)vs);

            // *** Coded History of Infection ***
            if (source.ValueSets.TryGetValue(ValueSetType.HistoryOfInfection, out vs))
                aphp.CodedHistoryOfInfection = CdaSectionFactory.CreateHistoryOfInfectionSection(source.Observations, (HistoryOfInfectionValueSet)vs);

            // *** Allergies ***
            aphp.Allergies = CdaSectionFactory.CreateAllergiesSection(source.VprData.Reactions);

            CdaAllergy latexAllergy = CdaObservationFactory.CreateLatexAllergy(source.Observations);

            if (latexAllergy != null)
                aphp.Allergies.Allergies.Add(latexAllergy);

            // *** Pregnancy History ***
            aphp.PregnancyHistorySection = CdaSectionFactory.CreatePregnancyHistorySection(source.Observations, source.Patient.Pregnant, source.Pregnancies);

            // *** Coded Social History ***
            aphp.SocialHistory = CdaSectionFactory.CreateSocialHistorySection(source.Observations);

            // *** Coded Family Medical History ***
            if (source.ValueSets.TryGetValue(ValueSetType.AntepartumFamilyHistory, out vs))
                aphp.FamilyMedicalHistory = CdaSectionFactory.CreateFamilyHistorySection(source.Observations, vs);

            // *** Review of Systems (+ Menstrual History) ***
            if (source.ValueSets.TryGetValue(ValueSetType.MenstrualHistory, out vs))
                aphp.ReviewOfSystems = CdaSectionFactory.CreateReviewOfSystemsSection(source.Observations, vs);

            // *** Coded Physical Exam ***
            aphp.PhysicalExam = CdaSectionFactory.CreatePhysicalExamSection(source.Observations);

            aphp.PhysicalExam.VitalSigns = CdaSectionFactory.CreateVitalsSubSection(source.VprData);

            return aphp;
        }

        public static ApsDocument CreateApsDocument(CdaSource cdaSource)
        {
            // *** Creates the APS document ***

            ApsDocument aps = new ApsDocument();

            // *** Set id ***
            Guid tempGuid = new Guid(cdaSource.DocumentId);
            aps.DocumentId = tempGuid.ToString();

            // *** Create Record Target Section ***
            aps.RecordTarget = CdaSectionFactory.CreateRecordTarget(cdaSource.VprData.Demographics);

            // *** Add provider organization to record target ***
            aps.RecordTarget.ProviderOrganization = CdaSectionFactory.CreateProviderOrganization(cdaSource.VprData.Demographics, cdaSource.ProviderOrganizationPhone);

            // *** Create Author ***
            aps.Author = CdaSectionFactory.CreateAuthor(cdaSource.VprData);

            // *** Information Recipient ***
            aps.Recipient = new CdaRecipient();
            aps.Recipient.FirstName = cdaSource.Options.IntendedRecipientFirstName;
            aps.Recipient.LastName = cdaSource.Options.IntendedRecipientLastName;
            aps.Recipient.Organization = cdaSource.Options.IntendedRecipientOrganization;

            // *** Participants ***
            //aphp.Participants = CreateParticipants(cdaSource.VprData);

            // *** Custodian ***
            aps.Custodian = CdaSectionFactory.CreateCustodian(aps.RecordTarget.ProviderOrganization);

            // *** Documentation Of ***
            aps.DocumentationOf = CdaSectionFactory.CreateDocumentationOf();

            // *** Allergies ***
            aps.Allergies = CdaSectionFactory.CreateAllergiesSection(cdaSource.VprData.Reactions);

            CdaAllergy latexAllergy = CdaObservationFactory.CreateLatexAllergy(cdaSource.Observations);

            if (latexAllergy != null)
                aps.Allergies.Allergies.Add(latexAllergy);

            // *** Advance Directves ***
            aps.AdvanceDirectiveSection = CdaSectionFactory.CreateAdvanceDirectivesSection(cdaSource.Observations);

            // *** Care Plan ***
            aps.CarePlanSection = CdaSectionFactory.CreateApsCarePlanSection(cdaSource.Observations);

            // *** Problems ***
            aps.ProblemsSection = CdaSectionFactory.CreateProblemsSection(cdaSource.Observations, cdaSource.VprData.Problems);

            // *** Meds ***
            aps.MedicationsSection = CdaSectionFactory.CreateMedicationSection(cdaSource.VprData.Meds);

            // *** EDD ***
            aps.EstimatedDeliveryDatesSection = CdaSectionFactory.CreateEddSection(cdaSource.Observations);

            // *** Antepartum Visit Summary ***
            aps.AntepartumVisitSummarySection = CdaSectionFactory.CreateVisitSummarySection(cdaSource.Observations);

            return aps;
        }

        public static ApeDocument CreateApeDocument(CdaSource cdaSource)
        {
            ApeDocument returnDoc = new ApeDocument();

            // *** Set id ***
            Guid tempGuid = new Guid(cdaSource.DocumentId);
            returnDoc.DocumentId = tempGuid.ToString();

            // *** Create Record Target Section ***
            returnDoc.RecordTarget = CdaSectionFactory.CreateRecordTarget(cdaSource.VprData.Demographics);

            // *** Add provider organization to record target ***
            returnDoc.RecordTarget.ProviderOrganization = CdaSectionFactory.CreateProviderOrganization(cdaSource.VprData.Demographics, cdaSource.ProviderOrganizationPhone);

            // *** Create Author ***
            returnDoc.Author = CdaSectionFactory.CreateAuthor(cdaSource.VprData);

            // *** Information Recipient ***
            returnDoc.Recipient = new CdaRecipient();
            returnDoc.Recipient.FirstName = cdaSource.Options.IntendedRecipientFirstName;
            returnDoc.Recipient.LastName = cdaSource.Options.IntendedRecipientLastName;
            returnDoc.Recipient.Organization = cdaSource.Options.IntendedRecipientOrganization;

            // *** Custodian ***
            returnDoc.Custodian = CdaSectionFactory.CreateCustodian(returnDoc.RecordTarget.ProviderOrganization);

            // *** Documentation Of ***
            returnDoc.DocumentationOf = CdaSectionFactory.CreateDocumentationOf();

            // *** Education Section ***
            returnDoc.PatientEducationSection = CdaSectionFactory.CreateEducationSection(cdaSource); 

            return returnDoc; 
        }

        public static AplDocument CreateAplDocument(CdaSource cdaSource)
        {
            AplDocument returnDoc = new AplDocument();

            // *** Set id ***
            Guid tempGuid = new Guid(cdaSource.DocumentId);
            returnDoc.DocumentId = tempGuid.ToString();

            // *** Create Record Target Section ***
            returnDoc.RecordTarget = CdaSectionFactory.CreateLabRecordTarget(cdaSource.VprData.Demographics);

            // *** Add provider organization to record target ***
            returnDoc.RecordTarget.ProviderOrganization = CdaSectionFactory.CreateProviderOrganization(cdaSource.VprData.Demographics, cdaSource.ProviderOrganizationPhone);

            // *** Create Author ***
            returnDoc.Author = CdaSectionFactory.CreateAuthor(cdaSource.VprData);

            // *** Information Recipient ***
            returnDoc.Recipient = new CdaRecipient();
            returnDoc.Recipient.FirstName = cdaSource.Options.IntendedRecipientFirstName;
            returnDoc.Recipient.LastName = cdaSource.Options.IntendedRecipientLastName;
            returnDoc.Recipient.Organization = cdaSource.Options.IntendedRecipientOrganization;

            // *** Custodian ***
            returnDoc.Custodian = CdaSectionFactory.CreateCustodian(returnDoc.RecordTarget.ProviderOrganization);

            // *** Documentation Of ***
            returnDoc.DocumentationOf = CdaSectionFactory.CreateDocumentationOf();

            // *** Lab Results Section ***
            returnDoc.Sections = CdaSectionFactory.CreateLabSections(cdaSource.VprData);

            return returnDoc;
        }

        public static PpvsDocument CreatePpvsDocument(CdaSource cdaSource)
        {
            // *** Creates the PPVS document ***

            PpvsDocument ppvs = new PpvsDocument();

            // *** Set id ***
            Guid tempGuid = new Guid(cdaSource.DocumentId);
            ppvs.DocumentId = tempGuid.ToString();

            // *** Create Record Target Section ***
            ppvs.RecordTarget = CdaSectionFactory.CreateRecordTarget(cdaSource.VprData.Demographics);

            // *** Add provider organization to record target ***
            ppvs.RecordTarget.ProviderOrganization = CdaSectionFactory.CreateProviderOrganization(cdaSource.VprData.Demographics, cdaSource.ProviderOrganizationPhone);

            // *** Create Author ***
            ppvs.Author = CdaSectionFactory.CreateAuthor(cdaSource.VprData);

            // *** Information Recipient ***
            ppvs.Recipient = new CdaRecipient();
            ppvs.Recipient.FirstName = cdaSource.Options.IntendedRecipientFirstName;
            ppvs.Recipient.LastName = cdaSource.Options.IntendedRecipientLastName;
            ppvs.Recipient.Organization = cdaSource.Options.IntendedRecipientOrganization;

            // *** Participants ***
            ppvs.Participants = CdaSectionFactory.CreateParticipants(cdaSource.VprData);

            // *** Custodian ***
            ppvs.Custodian = CdaSectionFactory.CreateCustodian(ppvs.RecordTarget.ProviderOrganization);

            // *** Documentation Of ***
            ppvs.DocumentationOf = CdaSectionFactory.CreateDocumentationOf();

            // *** History of Present Illness ***
            ppvs.HistoryOfPresentIllness = CdaSectionFactory.CreatePresentIllnessSection(cdaSource.Observations);

            // *** Allergies ***
            ppvs.Allergies = CdaSectionFactory.CreateAllergiesSection(cdaSource.VprData.Reactions);

            // *** Coded Social History ***
            ppvs.SocialHistory = CdaSectionFactory.CreateSocialHistorySection(cdaSource.Observations);

            // *** Coded Physical Exam ***
            ppvs.PhysicalExam = CdaSectionFactory.CreatePhysicalExamSection(cdaSource.Observations);
            ppvs.PhysicalExam.VitalSigns = CdaSectionFactory.CreateVitalsSubSection(cdaSource.VprData);

            // *** Problems ***
            ppvs.ProblemsSection = CdaSectionFactory.CreateProblemsSection(cdaSource.Observations, cdaSource.VprData.Problems);

            // *** Meds ***
            ppvs.MedicationsSection = CdaSectionFactory.CreateMedicationSection(cdaSource.VprData.Meds);

            // *** Care Plans ***
            ppvs.CarePlanSection = CdaSectionFactory.CreateCarePlanSection(cdaSource.Observations); 

            // *** Newborn Status ***
            ppvs.NewbornStatusSections = CdaSectionFactory.CreateNewbornStatusSections(cdaSource.Observations); 

            // *** Newborn Care Plan ***
            ppvs.NewbornCarePlanSections = CdaSectionFactory.CreateNewbornCarePlanSections(cdaSource.Observations);

            // *** Newborn Delivery Info ***
            ppvs.NewbornDeliveryInfoSections = CdaSectionFactory.CreateNewbornDeliveryInfoSections(cdaSource.Observations);
 
            // *** Labor & Delivery Events ***
            ppvs.LaborDeliveryEvents = CdaSectionFactory.CreateLaborDeliverySection(cdaSource.Observations);

            // *** Postpartum Hospitalization Treatment ***
            ppvs.PostpartumHospitalizationTreatment = CdaSectionFactory.CreatePostpartumHospitalizationTreatmentSection(cdaSource.Observations); 

            return ppvs;
        }

        public static XdriDocument CreateXdriDocument(CdaSource cdaSource)
        {
            XdriDocument doc = new XdriDocument();

            // *** Set id ***
            Guid tempGuid = new Guid(cdaSource.DocumentId);
            doc.DocumentId = tempGuid.ToString();

            // *** Create Record Target Section ***
            doc.RecordTarget = CdaSectionFactory.CreateRecordTarget(cdaSource.VprData.Demographics);

            // *** Add provider organization to record target ***
            doc.RecordTarget.ProviderOrganization = CdaSectionFactory.CreateProviderOrganization(cdaSource.VprData.Demographics, cdaSource.ProviderOrganizationPhone);

            // *** Create Author ***
            doc.Author = CdaSectionFactory.CreateAuthor(cdaSource.VprData);

            // *** Information Recipient ***
            doc.Recipient = new CdaRecipient();
            doc.Recipient.FirstName = cdaSource.Options.IntendedRecipientFirstName;
            doc.Recipient.LastName = cdaSource.Options.IntendedRecipientLastName;
            doc.Recipient.Organization = cdaSource.Options.IntendedRecipientOrganization;

            // *** Participants ***
            doc.Participants = CdaSectionFactory.CreateParticipants(cdaSource.VprData);

            // *** Custodian ***
            doc.Custodian = CdaSectionFactory.CreateCustodian(doc.RecordTarget.ProviderOrganization);

            // *** Documentation Of ***
            doc.DocumentationOf = CdaSectionFactory.CreateDocumentationOf();

            // *** Text of Report ***
            doc.ImageReport = new ImageReportSection() { ReportText = cdaSource.ImageReportText };

            return doc; 
        }
    }
}
