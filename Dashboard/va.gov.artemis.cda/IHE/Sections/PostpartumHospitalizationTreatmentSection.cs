// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.CDA.Common;

namespace VA.Gov.Artemis.CDA.IHE.Sections
{
    public class PostpartumHospitalizationTreatmentSection: CdaSection
    {
        // *** Section Information *** 
        public override CodingSystem CodeSystem { get { return CodingSystem.Loinc; } }
        public override string CodeSystemName { get { return CdaCode.LoincSystemName; } }
        public override string CodeSystemId { get { return CdaCode.LoincSystemId; } }
        public override string Code { get { return "57076-2"; } }
        public override string DisplayName { get { return "Postpartum Hospitalization Treatment"; } }
        public override CdaTemplateIdList TemplateIds
        {
            get
            {
                return new CdaTemplateIdList("1.3.6.1.4.1.19376.1.5.3.1.1.21.2.7");
            }
        }

        public override string SectionTitle
        {
            get { return this.DisplayName; }
        }

        public ProceduresInterventionsSection ProceduresInterventionsSection { get; set; }
        public DischargeDietSection DischargeDietSection { get; set; }

        public PostpartumHospitalizationTreatmentSection()
        {
            this.ProceduresInterventionsSection = new ProceduresInterventionsSection();
            this.DischargeDietSection = new DischargeDietSection(); 
        }

        protected override StrucDocTable GetEntriesTable()
        {
            return null; 
        }

        public override POCD_MT000040Component3 ToPocdComponent()
        {
            POCD_MT000040Component3 returnVal = base.ToPocdComponent();

            List<POCD_MT000040Component5> componentList = new List<POCD_MT000040Component5>();

            componentList.Add(this.ProceduresInterventionsSection.ToPocdComponent5());
            componentList.Add(this.DischargeDietSection.ToPocdComponent5()); 

            returnVal.section.component = componentList.ToArray();

            return returnVal;
        }
    }
}
