using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.CDA.ValueSets
{
    /// <summary>
    /// Antepartum Family History Value Set
    /// </summary>
    public class AntepartumFamilyHistoryValueSet: ValueSet
    {
        public AntepartumFamilyHistoryValueSet(): base()
        {
            this.ValueSetName = "Antepartum Family History & Genetic Screening Observation Codes";
            this.Id = "1.3.6.1.4.1.19376.1.5.3.1.1.16.5.4";

            InitializeCodes(); 
        }

        private void InitializeCodes()
        {
            this.Items.Add(new ValueSetItem("40108008", Common.CodingSystem.SnomedCT, "Thalassemia", ""));
            this.Items.Add(new ValueSetItem("253098009", Common.CodingSystem.SnomedCT, "Neural Tube Defect", ""));
            this.Items.Add(new ValueSetItem("13213009", Common.CodingSystem.SnomedCT, "Congenital Heart Defect", ""));
            this.Items.Add(new ValueSetItem("41040004", Common.CodingSystem.SnomedCT, "Down Syndrome", ""));
            this.Items.Add(new ValueSetItem("111385000", Common.CodingSystem.SnomedCT, "Tay-Sachs", ""));
            this.Items.Add(new ValueSetItem("80544005", Common.CodingSystem.SnomedCT, "Canavan Disease", ""));
            this.Items.Add(new ValueSetItem("29159009", Common.CodingSystem.SnomedCT, "Familial Dysautonomia", ""));
            this.Items.Add(new ValueSetItem("417357006", Common.CodingSystem.SnomedCT, "Sickling disorder due to hemoglobin S", ""));
            this.Items.Add(new ValueSetItem("16402000", Common.CodingSystem.SnomedCT, "Sickle cell trait", ""));
            this.Items.Add(new ValueSetItem("90935002", Common.CodingSystem.SnomedCT, "Hemophilia", ""));
            this.Items.Add(new ValueSetItem("414022008", Common.CodingSystem.SnomedCT, "Blood Disorders", ""));
            this.Items.Add(new ValueSetItem("73297009", Common.CodingSystem.SnomedCT, "Muscular Dystrophy", ""));
            this.Items.Add(new ValueSetItem("190905008", Common.CodingSystem.SnomedCT, "Cystic Fibrosis", ""));
            this.Items.Add(new ValueSetItem("58756001", Common.CodingSystem.SnomedCT, "Huntington's Chorea", ""));
            this.Items.Add(new ValueSetItem("91138005", Common.CodingSystem.SnomedCT, "Mental Retardation", ""));
            this.Items.Add(new ValueSetItem("408856003", Common.CodingSystem.SnomedCT, "Autism", ""));     
            this.Items.Add(new ValueSetItem("409709004", Common.CodingSystem.SnomedCT, "Chrosomosal disorder", ""));
            this.Items.Add(new ValueSetItem("75934005", Common.CodingSystem.SnomedCT, "Maternal Metabolic Disorder", ""));
            this.Items.Add(new ValueSetItem("276720006", Common.CodingSystem.SnomedCT, "Dysmorphism (Patient or baby's father has a child with birth defects)", ""));
            this.Items.Add(new ValueSetItem("102878001", Common.CodingSystem.SnomedCT, "Recurrent pregnancy loss/stillbirth", ""));     

        }

    }
}
