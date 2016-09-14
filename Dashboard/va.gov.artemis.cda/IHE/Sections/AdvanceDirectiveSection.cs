using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.CDA.Common;
using VA.Gov.Artemis.CDA.Observations;

namespace VA.Gov.Artemis.CDA.IHE.Sections
{
    public class AdvanceDirectiveSection: CdaSection
    {
        //<code code='42348-3' displayName='ADVANCE DIRECTIVES' codeSystem='2.16.840.1.113883.6.1' codeSystemName='LOINC'/>

        public override string CodeSystemName {get {return "LOINC";}}
        public override string CodeSystemId { get { return "2.16.840.1.113883.6.1"; } }
        public override string Code { get { return "42348-3"; } }
        public override string DisplayName  {get { return "Advance Directives"; }}
        public override CodingSystem CodeSystem {get { return CodingSystem.Loinc; }}
        public override string SectionTitle { get { return "Advance Directives"; } }
        
        public override CdaTemplateIdList TemplateIds 
        {
            get 
            {
                return new CdaTemplateIdList("2.16.840.1.113883.10.20.1.1", "1.3.6.1.4.1.19376.1.5.3.1.3.34" );
            }
        }

        public List<CdaBoolObservation> Observations { get; set; }

        public AdvanceDirectiveSection()
        {
            this.Observations = new List<CdaBoolObservation>(); 
        }

        public override POCD_MT000040Component3 ToPocdComponent()
        {
            POCD_MT000040Component3 returnVal = base.ToPocdComponent();

            if (this.Observations.Count == 0)
                this.Narrative = "(No Data)";

            List<POCD_MT000040Entry> entryList = new List<POCD_MT000040Entry>();

            foreach (CdaBoolObservation obs in this.Observations)
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
                    new StrucDocTh() { Text = new string[] { "Allowed" } }                
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
                    tdList.Add(new StrucDocTd() { Text = new string[] { obs.EffectiveTime.Value.ToString() } });

                    // *** Procedure ***
                    tdList.Add(new StrucDocTd() { Text = new string[] { obs.Code.DisplayName } });

                    // *** Yes/No ***
                    StrucDocTd td = new StrucDocTd() { Text = new string[] { (obs.NegationIndicator) ? "NO" : "YES" } };
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
