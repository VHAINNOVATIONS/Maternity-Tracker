using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.CDA.ValueSets
{
    public class HistoryOfInfectionValueSet: ValueSet
    {
        public HistoryOfInfectionValueSet()
        {
            this.ValueSetName = "Antepartum Coded History of Infection Value Set";
            this.Id = "1.3.6.1.4.1.19376.1.5.3.1.1.16.5.6";

            InitializeCodes(); 
        }

        private void InitializeCodes()
        {            
            this.Items.Add(new ValueSetItem("170464005", Common.CodingSystem.SnomedCT, "Live with someone with TB or exposed to TB", ""));   
            this.Items.Add(new ValueSetItem("402888002", Common.CodingSystem.SnomedCT, "History of Genital Herpes", ""));
            this.Items.Add(new ValueSetItem("240480009", Common.CodingSystem.SnomedCT, "Exposed to Genital Herpes", ""));
            this.Items.Add(new ValueSetItem("49882001", Common.CodingSystem.SnomedCT, "Rash since LMP", ""));
            this.Items.Add(new ValueSetItem("34014006", Common.CodingSystem.SnomedCT, "Viral illness since LMP", ""));
            this.Items.Add(new ValueSetItem("49882001", Common.CodingSystem.SnomedCT, "Rash or viral illness since LMP", "")); 
            this.Items.Add(new ValueSetItem("235871004", Common.CodingSystem.SnomedCT, "Hepatitis B", ""));
            this.Items.Add(new ValueSetItem("235872006", Common.CodingSystem.SnomedCT, "Hepatitis C", ""));
            this.Items.Add(new ValueSetItem("8098009", Common.CodingSystem.SnomedCT, "History of STD", ""));
            this.Items.Add(new ValueSetItem("15628003", Common.CodingSystem.SnomedCT, "History of Gonorrhea", ""));
            this.Items.Add(new ValueSetItem("312099009", Common.CodingSystem.SnomedCT, "History of Chlamydia", ""));
            this.Items.Add(new ValueSetItem("302812006", Common.CodingSystem.SnomedCT, "History of HPV", "")); 
            this.Items.Add(new ValueSetItem("165816005", Common.CodingSystem.SnomedCT, "History of HIV", ""));
            this.Items.Add(new ValueSetItem("76272004", Common.CodingSystem.SnomedCT, "History of Syphilis", ""));
        }
    }
}
