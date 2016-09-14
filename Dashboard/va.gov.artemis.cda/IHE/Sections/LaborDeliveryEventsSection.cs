using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.CDA.Common;
using VA.Gov.Artemis.CDA.Observations;

namespace VA.Gov.Artemis.CDA.IHE.Sections
{
    public class LaborDeliveryEventsSection: CdaSection
    {
        // *** Section Information ***
        public override CodingSystem CodeSystem { get { return CodingSystem.Loinc; }}
        public override string CodeSystemName { get { return CdaCode.LoincSystemName; } }
        public override string CodeSystemId { get { return CdaCode.LoincSystemId; } }
        public override string Code { get { return "57074-7"; } }
        public override string DisplayName { get { return "Labor & Delivery Process"; } }
        
        public override CdaTemplateIdList TemplateIds
        {
            get
            {
                return new CdaTemplateIdList("1.3.6.1.4.1.19376.1.5.3.1.1.21.2.3");
            }
        }
        
        public override string SectionTitle
        {
            get { return this.DisplayName; }
        }

        public List<CdaSimpleObservation> Observations { get; set; }

        public LaborDeliveryEventsSection()
        {
            this.Observations = new List<CdaSimpleObservation>(); 
        }

        public override POCD_MT000040Component3 ToPocdComponent()
        {
            POCD_MT000040Component3 returnVal = base.ToPocdComponent();

            if (this.Observations.Count == 0)
                this.Narrative = "(No Data)";

            List<POCD_MT000040Entry> entryList = new List<POCD_MT000040Entry>();

            foreach (CdaSimpleObservation obs in this.Observations)
            {
                // *** Create an entry ***
                POCD_MT000040Entry newEntry = new POCD_MT000040Entry();

                // *** Create observation ***
                newEntry.Item = obs.ToPocd();

                entryList.Add(newEntry);
            }

            returnVal.section.entry = entryList.ToArray();

            return returnVal;
        }

        protected override StrucDocTable GetEntriesTable()
        {
            // *** Create the table ***
            StrucDocTable returnTable = null;

            if (this.Observations.Count > 0)
            {
                returnTable = new StrucDocTable();

                // *** Create Header information ***
                returnTable.thead = new StrucDocThead();
                returnTable.thead.tr = new StrucDocTr[] { new StrucDocTr() };
                returnTable.thead.tr[0].Items = new StrucDocTh[] { 
                    new StrucDocTh() { Text = new string[] { "Date/Time" } },
                    new StrucDocTh() { Text = new string[] { "Description" } },
                    new StrucDocTh() { Text = new string[] { "Value" } }                
                };

                // *** Create Body Information ***
                returnTable.tbody = new StrucDocTbody[] { new StrucDocTbody() };
                List<StrucDocTr> trList = new List<StrucDocTr>();

                foreach (var obs in this.Observations)
                {
                    // *** Create the row ***
                    StrucDocTr tr = new StrucDocTr() { ID = obs.ReferenceId };

                    // *** Create a list of TD ***
                    List<StrucDocTd> tdList = new List<StrucDocTd>();

                    // *** Add TD's ***

                    // *** Date/Time ***
                    tdList.Add(new StrucDocTd() { Text = new string[] { obs.EffectiveTime.High.ToString() } });

                    // *** Description ***
                    tdList.Add(new StrucDocTd() { Text = new string[] { obs.Code.DisplayName } });

                    // *** Value ***
                    StrucDocTd td = new StrucDocTd() { Text = new string[] { obs.DisplayValue } };
                    td.align = StrucDocTdAlign.center;
                    td.alignSpecified = true;
                    tdList.Add(td);

                    // *** Add td's to tr ***
                    tr.Items = tdList.ToArray();

                    // *** Add tr to tr list ***
                    trList.Add(tr);
                }

                // *** Add rows to body ***
                returnTable.tbody[0].tr = trList.ToArray();
            }

            return returnTable;
        }
        
    }
}
