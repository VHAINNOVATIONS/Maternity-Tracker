using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.CDA.Common;
using VA.Gov.Artemis.CDA.Observations;

namespace VA.Gov.Artemis.CDA.IHE.Sections
{
    public class ProblemsSection: CdaSection
    {
        //<templateId root='2.16.840.1.113883.10.20.1.11'/>
        //<templateId root='1.3.6.1.4.1.19376.1.5.3.1.3.6'/>
        //<id root=' ' extension=' '/>
        //<code code='11450-4' displayName='PROBLEM LIST' 2345
        //codeSystem='2.16.840.1.113883.6.1' codeSystemName='LOINC'/>

        public override CodingSystem CodeSystem { get { return CodingSystem.Loinc; } }
        public override string CodeSystemName { get { return CdaCode.LoincSystemName; } }
        public override string CodeSystemId { get { return CdaCode.LoincSystemId; } }
        public override string Code { get { return "11450-4"; } }
        public override string DisplayName { get { return "Active Problems"; } }        
        public override string SectionTitle { get { return "Active Problems"; } }
        
        public ProblemConcernEntriesSection Entries { get; set; }

        public ProblemsSection()
        {
            this.Entries = new ProblemConcernEntriesSection();
        }

        public override CdaTemplateIdList TemplateIds
        {
            get
            {
                return new CdaTemplateIdList("2.16.840.1.113883.10.20.1.11", "1.3.6.1.4.1.19376.1.5.3.1.3.6");
            }
        }

        public override POCD_MT000040Component3 ToPocdComponent()
        {
            // *** Creates a CDA POCD component for inclusion in APS document ***

            if ((string.IsNullOrWhiteSpace(this.Narrative)) && (this.Entries.Observations.Count == 0))
                this.Narrative = "(No Data)";

            // *** First create basic section ***
            POCD_MT000040Component3 returnVal = base.ToPocdComponent();

            // *** And entries ***
            List<POCD_MT000040Entry> entryList = this.Entries.ToPocdEntryList();

            // *** Add entry list to section ***
            returnVal.section.entry = entryList.ToArray();

            return returnVal;
        }

        protected override StrucDocTable GetEntriesTable()
        {
            return this.Entries.ToTable();
        }
    }
}
