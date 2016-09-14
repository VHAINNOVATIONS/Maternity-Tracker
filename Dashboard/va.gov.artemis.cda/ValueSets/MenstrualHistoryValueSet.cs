using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.CDA.Common;

namespace VA.Gov.Artemis.CDA.ValueSets
{
    /// <summary>
    /// Menstrual History Value Set
    /// </summary>
    public class MenstrualHistoryValueSet: ValueSet 
    {
        public MenstrualHistoryValueSet()
        {
            this.ValueSetName = "Menstrual History Observation Codes Value Set";
            this.Id = "1.3.6.1.4.1.19376.1.5.3.1.1.16.5.5";

            InitializeCodes();
        }

        private void InitializeCodes()
        {
            this.Items.Add(new ValueSetItem("21840007", CodingSystem.SnomedCT, "Date of Last Menstrual Period", ""));
            this.Items.Add(new ValueSetItem("364307006", CodingSystem.SnomedCT, "Regularity of Menstrual Cycle", ""));
            this.Items.Add(new ValueSetItem("21840007", CodingSystem.SnomedCT, "Prior Menses Date", ""));
            this.Items.Add(new ValueSetItem("364306002", CodingSystem.SnomedCT, "Frequency of Menstruation (Days)", ""));
            this.Items.Add(new ValueSetItem("xx-onbcp", CodingSystem.SnomedCT, "On birth control pills at conception", ""));
            this.Items.Add(new ValueSetItem("398700009", CodingSystem.SnomedCT, "Age at menarche", ""));
            this.Items.Add(new ValueSetItem("67900009", CodingSystem.SnomedCT, "Human chorionic gonadotropin measurement", ""));
        }
    }
}
