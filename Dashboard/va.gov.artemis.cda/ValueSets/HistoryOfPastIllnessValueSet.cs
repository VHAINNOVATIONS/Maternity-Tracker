using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.CDA.ValueSets
{
    public class HistoryOfPastIllnessValueSet: ValueSet
    {
        public HistoryOfPastIllnessValueSet()
        {
            this.ValueSetName = "Antepartum History of Past Illness Value Set";
            this.Id = "1.3.6.1.4.1.19376.1.5.3.1.1.16.5.1";

            InitializeCodes();
        }

        private void InitializeCodes()
        {
            this.Items.Add(new ValueSetItem("73211009", Common.CodingSystem.SnomedCT, "Diabetes", ""));
            this.Items.Add(new ValueSetItem("38341003", Common.CodingSystem.SnomedCT, "Hypertension", ""));   
            this.Items.Add(new ValueSetItem("56265001", Common.CodingSystem.SnomedCT, "Heart Disease", ""));
            this.Items.Add(new ValueSetItem("85828009", Common.CodingSystem.SnomedCT, "Autoimmune Disorder", ""));
            this.Items.Add(new ValueSetItem("90708001", Common.CodingSystem.SnomedCT, "Kidney Disease", ""));
            this.Items.Add(new ValueSetItem("68566005", Common.CodingSystem.SnomedCT, "UTI", ""));
            this.Items.Add(new ValueSetItem("118940003", Common.CodingSystem.SnomedCT, "Neurologic", ""));
            this.Items.Add(new ValueSetItem("84757009", Common.CodingSystem.SnomedCT, "Epilepsy", ""));
            this.Items.Add(new ValueSetItem("74732009", Common.CodingSystem.SnomedCT, "Psychiatric", ""));
            this.Items.Add(new ValueSetItem("41006004", Common.CodingSystem.SnomedCT, "Depression", ""));
            this.Items.Add(new ValueSetItem("58703003", Common.CodingSystem.SnomedCT, "Postpartum Depression", ""));
            this.Items.Add(new ValueSetItem("128241005", Common.CodingSystem.SnomedCT, "Hepatitis", ""));
            this.Items.Add(new ValueSetItem("235856003", Common.CodingSystem.SnomedCT, "Liver Disease", ""));
            this.Items.Add(new ValueSetItem("276504003", Common.CodingSystem.SnomedCT, "Varicosities", ""));
            this.Items.Add(new ValueSetItem("61599003", Common.CodingSystem.SnomedCT, "Phlebitis", ""));
            this.Items.Add(new ValueSetItem("14304000", Common.CodingSystem.SnomedCT, "Thyroid Dysfunction", ""));
            this.Items.Add(new ValueSetItem("417746004", Common.CodingSystem.SnomedCT, "Trauma", ""));
            this.Items.Add(new ValueSetItem("225818009", Common.CodingSystem.SnomedCT, "Violence", ""));
            this.Items.Add(new ValueSetItem("116859006", Common.CodingSystem.SnomedCT, "History of Blood Transfusion", ""));
            this.Items.Add(new ValueSetItem("3885002", Common.CodingSystem.SnomedCT, "D(Rh) Sensitized", ""));
            this.Items.Add(new ValueSetItem("19829001", Common.CodingSystem.SnomedCT, "Pulmonary", ""));
            this.Items.Add(new ValueSetItem("367498001", Common.CodingSystem.SnomedCT, "Seasonal Allergies", ""));
            this.Items.Add(new ValueSetItem("416098002", Common.CodingSystem.SnomedCT, "Drug Allergy", ""));
            this.Items.Add(new ValueSetItem("300916003", Common.CodingSystem.SnomedCT, "Latex Allergy", ""));
            this.Items.Add(new ValueSetItem("414285001", Common.CodingSystem.SnomedCT, "Food Allergy", ""));
            this.Items.Add(new ValueSetItem("79604008", Common.CodingSystem.SnomedCT, "Breast", ""));
            this.Items.Add(new ValueSetItem("12658000", Common.CodingSystem.SnomedCT, "Gyn Surgery", ""));
            this.Items.Add(new ValueSetItem("387713003", Common.CodingSystem.SnomedCT, "Operations", ""));
            this.Items.Add(new ValueSetItem("32485007", Common.CodingSystem.SnomedCT, "Hospitalizations", ""));
            this.Items.Add(new ValueSetItem("33211000", Common.CodingSystem.SnomedCT, "Anesthetic Complications", ""));
            this.Items.Add(new ValueSetItem("274688009", Common.CodingSystem.SnomedCT, "History of Abnormal Pap", ""));
            this.Items.Add(new ValueSetItem("37849005", Common.CodingSystem.SnomedCT, "Uterine Anomaly/DES", ""));
            this.Items.Add(new ValueSetItem("xx-desexposure", Common.CodingSystem.SnomedCT, "DES Exposure", ""));
            this.Items.Add(new ValueSetItem("8619003", Common.CodingSystem.SnomedCT, "Infertility", ""));
            this.Items.Add(new ValueSetItem("63487001", Common.CodingSystem.SnomedCT, "Art Treatment", "")); 

        }
    }
}
