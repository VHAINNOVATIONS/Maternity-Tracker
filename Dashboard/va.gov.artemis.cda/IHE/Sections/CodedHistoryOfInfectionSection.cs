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
    public class CodedHistoryOfInfectionSection: CdaSection
    {
        // *** Section Information *** 
        public override CodingSystem CodeSystem { get { return CodingSystem.Loinc; } }
        public override string CodeSystemName { get { return "LOINC"; } }
        public override string CodeSystemId { get { return "2.16.840.1.113883.6.1"; } }
        public override string Code { get { return "56838-6"; } }
        public override string DisplayName { get { return "History of Infectious Disease"; } }
        public override CdaTemplateIdList TemplateIds { get { return new CdaTemplateIdList("1.3.6.1.4.1.19376.1.5.3.1.1.16.2.1.1"); } }
        public override string SectionTitle
        {
            get { return "Coded History of Infection"; }
        }

        // *** Free-text description of the history of infection ***
        //public string Narrative { get; set; }

        public ProblemConcernEntriesSection Entries { get; set; }

        public CodedHistoryOfInfectionSection()
        {
            this.Entries = new ProblemConcernEntriesSection(); 
        }

        public override POCD_MT000040Component3 ToPocdComponent()
        {
            // *** Creates a CDA POCD component for inclusion in APHP document ***

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
