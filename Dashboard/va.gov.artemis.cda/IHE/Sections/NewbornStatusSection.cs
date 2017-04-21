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
    public class NewbornStatusSection: CdaSection
    {
        // *** Section Information ***
        public override string CodeSystemName { get { return "LOINC"; } }
        public override string CodeSystemId { get { return "2.16.840.1.113883.6.1"; } }
        public override string Code { get { return "57077-0"; } }
        public override string DisplayName { get { return "Newborn Status at Maternal Discharge"; } }
        public override CdaTemplateIdList TemplateIds
        {
            get
            {
                return new CdaTemplateIdList("1.3.6.1.4.1.19376.1.5.3.1.1.21.2.8");
            }
        }

        public override CodingSystem CodeSystem
        {
            get { return CodingSystem.Loinc; }
        }

        public override string SectionTitle
        {
            get { return this.DisplayName; }
        }

        public override POCD_MT000040Component3 ToPocdComponent()
        {
            if (string.IsNullOrWhiteSpace(this.Narrative))
                this.Narrative = "(No Data)";

            POCD_MT000040Component3 returnVal = base.ToPocdComponent();

            return returnVal;
        }

        protected override StrucDocTable GetEntriesTable()
        {
            return null; 
        }
    }
}
