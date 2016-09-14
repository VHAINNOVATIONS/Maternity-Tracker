using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.CDA.Common;
using VA.Gov.Artemis.CDA.Observations;

namespace VA.Gov.Artemis.CDA.IHE.Sections
{
    public class NewbornDeliveryInfoSection: CdaSection
    {
        // *** Section Information *** 
        public override CodingSystem CodeSystem { get { return CodingSystem.Loinc; } }
        public override string CodeSystemName { get { return CdaCode.LoincSystemName; } }
        public override string CodeSystemId { get { return CdaCode.LoincSystemId; } }
        public override string Code { get { return "57075-4"; } }
        public override string DisplayName { get { return "Newborn Delivery Information"; } }
        public override CdaTemplateIdList TemplateIds
        {
            get
            {
                return new CdaTemplateIdList("1.3.6.1.4.1.19376.1.5.3.1.1.21.2.4");
            }
        }

        public string BabyNumber { get; set; }

        //public List<CdaSimpleObservation> Observations { get; set; }
        public CodedPhysicalExamSection PhysicalExam { get; set; }

        public ProceduresInterventionsSection ProceduresInterventions { get; set; }

        public override string SectionTitle
        {
            get { return string.Format("{0} (Baby {1})", this.DisplayName, this.BabyNumber); }
        }

        public NewbornDeliveryInfoSection()
        {
            this.PhysicalExam = new CodedPhysicalExamSection();
            this.ProceduresInterventions = new ProceduresInterventionsSection(); 
        }

        public override POCD_MT000040Component3 ToPocdComponent()
        {
            POCD_MT000040Component3 returnVal = base.ToPocdComponent();

            //// *** Create an entry ***
            //POCD_MT000040Entry newEntry = new POCD_MT000040Entry();

            ////// *** Create observation ***
            //newEntry.Item = this.PhysicalExam.ToPocdComponent();

            ////returnVal.section.entry 

            //List<POCD_MT000040Component5> compList = new List<POCD_MT000040Component5>(); 

            //POCD_MT000040Component5 comp = this.PhysicalExam.ToPocdComponent5(); 

            //comp.section.entry = new POCD_MT000040Entry[] { newEntry }; 

            //compList.Add(comp);

            List<POCD_MT000040Component5> compList = new List<POCD_MT000040Component5>();

            compList.Add(this.ProceduresInterventions.ToPocdComponent5()); 
            compList.AddRange(this.PhysicalExam.ToPocdComponentArray());

            returnVal.section.component = compList.ToArray(); 

            return returnVal;
        }

        protected override StrucDocTable GetEntriesTable()
        {
            // *** Create the table ***
            StrucDocTable returnTable = null;

            //List<CdaSimpleObservation> observations = this.PhysicalExam.Subsections["10210-3"].Observations; 

            //if (observations.Count > 0)
            //{
            //    returnTable = new StrucDocTable();

            //    // *** Create Header information ***
            //    returnTable.thead = new StrucDocThead();
            //    returnTable.thead.tr = new StrucDocTr[] { new StrucDocTr() };
            //    returnTable.thead.tr[0].Items = new StrucDocTh[] { 
            //        new StrucDocTh() { Text = new string[] { "Date/Time" } },
            //        new StrucDocTh() { Text = new string[] { "Description" } },
            //        new StrucDocTh() { Text = new string[] { "Value" } }                
            //    };

            //    // *** Create Body Information ***
            //    returnTable.tbody = new StrucDocTbody[] { new StrucDocTbody() };
            //    List<StrucDocTr> trList = new List<StrucDocTr>();

            //    foreach (var obs in observations)
            //    {
            //        // *** Create the row ***
            //        StrucDocTr tr = new StrucDocTr() { ID = obs.ReferenceId };

            //        // *** Create a list of TD ***
            //        List<StrucDocTd> tdList = new List<StrucDocTd>();

            //        // *** Add TD's ***

            //        // *** Date/Time ***
            //        string date = "";
            //        if (obs.EffectiveTime != null)
            //            if (obs.EffectiveTime.Value != DateTime.MinValue)
            //                date = obs.EffectiveTime.Value.ToString(); 

            //        tdList.Add(new StrucDocTd() { Text = new string[] { date } });

            //        // *** Description ***
            //        tdList.Add(new StrucDocTd() { Text = new string[] { obs.Code.DisplayName } });

            //        // *** Value ***
            //        tdList.Add(new StrucDocTd() { Text = new string[] { obs.DisplayValue } });

            //        // *** Add td's to tr ***
            //        tr.Items = tdList.ToArray();

            //        // *** Add tr to tr list ***
            //        trList.Add(tr);
            //    }

            //    // *** Add rows to body ***
            //    returnTable.tbody[0].tr = trList.ToArray();
            //}

            return returnTable;
        }
    }
}
