// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.CDA.IHE.Sections;
using VA.Gov.Artemis.CDA.Raw;

namespace VA.Gov.Artemis.CDA.IHE.Documents
{
    public class ApsDocument: CdaDocument
    {
        public AdvanceDirectiveSection AdvanceDirectiveSection { get; set; }
        public CarePlanSection CarePlanSection { get; set; }
        public MedicationsSection MedicationsSection { get; set; }
        public ProblemsSection ProblemsSection {get; set; }
        public EstimatedDeliveryDatesSection EstimatedDeliveryDatesSection {get; set;}
        public AntepartumVisitSummarySection AntepartumVisitSummarySection {get; set;}

        public ApsDocument()
        {
            this.AdvanceDirectiveSection = new AdvanceDirectiveSection();
            this.CarePlanSection = new CarePlanSection();
            this.MedicationsSection = new MedicationsSection();
            this.ProblemsSection = new ProblemsSection();
            this.EstimatedDeliveryDatesSection = new EstimatedDeliveryDatesSection();
            this.AntepartumVisitSummarySection = new AntepartumVisitSummarySection(); 
        }

        public RawApsDocument ToRawDocument()
        {
            RawApsDocument returnDoc = new RawApsDocument();

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
            
            // *** Add advance directive ***
            POCD_MT000040Component3 advanceDirective = this.AdvanceDirectiveSection.ToPocdComponent();
            if (advanceDirective != null)
                components.Add(advanceDirective);

            // *** Add care plan ***
            POCD_MT000040Component3 carePlan = this.CarePlanSection.ToPocdComponent();
            if (carePlan != null)
                components.Add(carePlan);

            // *** Add problems ***
            POCD_MT000040Component3 problems = this.ProblemsSection.ToPocdComponent();
            if (problems != null)
                components.Add(problems);

            // *** Add medications ***
            POCD_MT000040Component3 meds = this.MedicationsSection.ToPocdComponent();
            if (meds != null)
                components.Add(meds);

            // *** Add edd ***
            POCD_MT000040Component3 edd = this.EstimatedDeliveryDatesSection.ToPocdComponent();
            if (edd != null)
                components.Add(edd);

            // *** Add antepartum visit summary ***
            POCD_MT000040Component3 visit = this.AntepartumVisitSummarySection.ToPocdComponent();
            if (visit != null)
                components.Add(visit);

            body.component = components.ToArray();
            return returnDoc;
        }

    }
}
