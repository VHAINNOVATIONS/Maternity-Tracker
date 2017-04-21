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
    public class PpvsDocument: CdaDocument
    {
        public ProblemsSection ProblemsSection { get; set; }
        public CodedSocialHistorySection SocialHistory { get; set; }
        public HistoryOfPresentIllnessSection HistoryOfPresentIllness { get; set; }
        public CodedPhysicalExamSection PhysicalExam { get; set; }
        public CarePlanSection CarePlanSection { get; set; }
        public MedicationsSection MedicationsSection { get; set; }

        public LaborDeliveryEventsSection LaborDeliveryEvents { get; set; }
        public PostpartumHospitalizationTreatmentSection PostpartumHospitalizationTreatment { get; set; }
        
        public Dictionary<string, NewbornStatusSection> NewbornStatusSections { get; set; }
        public Dictionary<string, NewbornDeliveryInfoSection> NewbornDeliveryInfoSections { get; set; }
        public Dictionary<string, NewbornCarePlanSection> NewbornCarePlanSections { get; set; }

        public PpvsDocument()
        {
            this.ProblemsSection = new ProblemsSection();
            this.SocialHistory = new CodedSocialHistorySection();
            this.HistoryOfPresentIllness = new HistoryOfPresentIllnessSection();
            this.PhysicalExam = new CodedPhysicalExamSection();
            this.CarePlanSection = new CarePlanSection();
            this.MedicationsSection = new MedicationsSection();

            this.LaborDeliveryEvents = new LaborDeliveryEventsSection();
            this.PostpartumHospitalizationTreatment = new PostpartumHospitalizationTreatmentSection(); 

            this.NewbornCarePlanSections = new Dictionary<string, NewbornCarePlanSection>();
            this.NewbornDeliveryInfoSections = new Dictionary<string, NewbornDeliveryInfoSection>();
            this.NewbornStatusSections = new Dictionary<string, NewbornStatusSection>(); 
        }

        public RawPpvsDocument ToRawDocument()
        {
            RawPpvsDocument returnDoc = new RawPpvsDocument();

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

            // *** Add Labor & Delivery Events ***
            POCD_MT000040Component3 laborDelivery = this.LaborDeliveryEvents.ToPocdComponent();
            if (laborDelivery != null)
                components.Add(laborDelivery); 

            // *** Add PP Hosp Tx ***
            POCD_MT000040Component3 ppHospTx = this.PostpartumHospitalizationTreatment.ToPocdComponent();
            if (ppHospTx != null)
                components.Add(ppHospTx); 

            // *** Add care plan ***
            POCD_MT000040Component3 carePlan = this.CarePlanSection.ToPocdComponent();
            if (carePlan != null)
                components.Add(carePlan);

            // *** Add problems ***
            POCD_MT000040Component3 problems = this.ProblemsSection.ToPocdComponent();
            if (problems != null)
                components.Add(problems);

            // *** Add history of present illness ***
            POCD_MT000040Component3 presentIllness = this.HistoryOfPresentIllness.ToPocdComponent();
            if (presentIllness != null)
                components.Add(presentIllness);

            // *** Add coded social history ***
            POCD_MT000040Component3 socialHistory = this.SocialHistory.ToPocdComponent();
            if (socialHistory != null)
                components.Add(socialHistory);

            // *** Add coded physical exam ***
            POCD_MT000040Component3 physicalExam = this.PhysicalExam.ToPocdComponent();
            if (physicalExam != null)
                components.Add(physicalExam);

            // *** Add medications ***
            POCD_MT000040Component3 meds = this.MedicationsSection.ToPocdComponent();
            if (meds != null)
                components.Add(meds);

            // *** Add Newborn Status ***
            if (this.NewbornStatusSections.Count > 0)
                foreach (var item in this.NewbornStatusSections.Values)
                {
                    POCD_MT000040Component3 stat = item.ToPocdComponent();
                    components.Add(stat);
                }

            // *** Add Newborn Delivery Info ***
            if (this.NewbornDeliveryInfoSections.Count > 0)
                foreach (var item in this.NewbornDeliveryInfoSections.Values)
                {
                    POCD_MT000040Component3 stat = item.ToPocdComponent();
                    components.Add(stat);
                }

            // *** Add Newborn Care Plan ***
            if (this.NewbornCarePlanSections.Count > 0)
                foreach (var item in this.NewbornCarePlanSections.Values)
                {
                    POCD_MT000040Component3 stat = item.ToPocdComponent();
                    components.Add(stat);
                }
            
            body.component = components.ToArray();
            return returnDoc;
        }

    }
}
