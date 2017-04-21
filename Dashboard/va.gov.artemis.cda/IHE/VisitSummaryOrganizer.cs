// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.CDA.Common;

namespace VA.Gov.Artemis.CDA.IHE
{
    public class VisitSummaryOrganizer: CdaOrganizer
    {
        protected override CdaTemplateIdList TemplateIds
        {
            get { return new CdaTemplateIdList("1.3.6.1.4.1.19376.1.5.3.1.1.11.2.3.2"); }
        }

        protected override CdaCode OrganizerCode
        {
            get { return new CdaCode() { CodeSystem = CodingSystem.Loinc, Code = "57061-4", DisplayName = "Antepartum flowsheet panel" }; }
        }

        protected override List<POCD_MT000040Component4> GetAdditionalComponents()
        {
            return new List<POCD_MT000040Component4>(); 
        }

        public override List<object> GetAdditionalText()
        {
            List<object> returnList = new List<object>();

            StrucDocTable tbl = base.GetEntriesTable();
            if (tbl != null)
                returnList.Add(tbl);

            return returnList;
        }

        protected override string Caption
        {
            get { throw new NotImplementedException(); }
        }
    }
}
