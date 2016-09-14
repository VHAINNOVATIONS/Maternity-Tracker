using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.CDA.Common;
using VA.Gov.Artemis.CDA.Observations;

namespace VA.Gov.Artemis.CDA.IHE.Sections
{
    public class HistoryOfPresentIllnessSection: CdaSection
    {
        // *** Section Information ***
        public override string CodeSystemName { get { return "LOINC"; } }
        public override string CodeSystemId { get { return "2.16.840.1.113883.6.1"; } }
        public override string Code { get { return "10164-2"; } }
        public override string DisplayName { get { return "History of Present Illness"; } }
        public override CdaTemplateIdList TemplateIds { get { return new CdaTemplateIdList("1.3.6.1.4.1.19376.1.5.3.1.3.4"); } }

        public override CodingSystem CodeSystem
        {
            get { return CodingSystem.Loinc; }
        }

        public override string SectionTitle
        {
            get { return "History of Present Illness"; }
        }

        // *** History of Present Illness Observation From Vista ***
        //public string Narrative { get; set; }

        //<component>
        //    <section>
        //        <templateId root='1.3.6.1.4.1.19376.1.5.3.1.3.4'/>
        //        <id root=' ' extension=' '/>
        //        <code code='10164-2' displayName='HISTORY OF PRESENT ILLNESS' codeSystem='2.16.840.1.113883.6.1' codeSystemName='LOINC'/>
        //        <text>Text as described above</text>
        //    </section>
        //</component>

        public override POCD_MT000040Component3 ToPocdComponent()
        {
            if (string.IsNullOrWhiteSpace(this.Narrative))
                this.Narrative = "(No Data)"; 

            return base.ToPocdComponent();
        }

        protected override StrucDocTable GetEntriesTable()
        {
            // *** Narrative only, no entries ***
            return null; 
        }
    }
}
