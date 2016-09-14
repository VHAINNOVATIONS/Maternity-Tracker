using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.CDA.Common;
using VA.Gov.Artemis.CDA.Observations;

namespace VA.Gov.Artemis.CDA.IHE.Sections
{
    public class PatientEducationSection: CdaSection
    {
        public override string CodeSystemName { get { return CdaCode.LoincSystemName; } }
        public override string CodeSystemId { get { return CdaCode.LoincSystemId; } }
        public override string Code { get { return "34895-3"; } }
        public override string DisplayName { get { return "Education Note"; } }
        public override CodingSystem CodeSystem { get { return CodingSystem.Loinc; } }
        public override string SectionTitle { get { return "Antepartum Education"; } }

        public override CdaTemplateIdList TemplateIds
        {
            get
            {
                return new CdaTemplateIdList(
                    "1.3.6.1.4.1.19376.1.5.3.1.1.9.38",
                    "1.3.6.1.4.1.19376.1.5.3.1.1.9.39"
                );
            }
        }

        public List<CdaProcedure> Procedures { get; set; }

        public PatientEducationSection()
        {
            this.Procedures = new List<CdaProcedure>(); 
        }

        public override POCD_MT000040Component3 ToPocdComponent()
        {
            POCD_MT000040Component3 returnVal = base.ToPocdComponent();

            if (this.Procedures.Count == 0)
                this.Narrative = "(No Data)";

            List<POCD_MT000040Entry> entryList = new List<POCD_MT000040Entry>();

            // *** Create battery ***

            foreach (CdaProcedure proc in this.Procedures)
            {
                // *** Create an entry ***
                POCD_MT000040Entry newEntry = new POCD_MT000040Entry();

                // *** Create observation ***
                newEntry.Item = proc.ToPocd();

                entryList.Add(newEntry);
            }

            returnVal.section.entry = entryList.ToArray();

            return returnVal;
        }
        protected override StrucDocTable GetEntriesTable()
        {
            //return this.Organizer.gE
            // *** Create the table ***
            StrucDocTable returnTable = null;

            if (this.Procedures.Count > 0)
            {
                returnTable = new StrucDocTable();

                // *** Create Header information ***
                returnTable.thead = new StrucDocThead();
                returnTable.thead.tr = new StrucDocTr[] { new StrucDocTr() };
                returnTable.thead.tr[0].Items = new StrucDocTh[] { 
                    new StrucDocTh() { Text = new string[] { "Code System" } },
                    new StrucDocTh() { Text = new string[] { "Code" } },
                    new StrucDocTh() { Text = new string[] { "Description" } }                
                };

                // *** Create Body Information ***
                returnTable.tbody = new StrucDocTbody[] { new StrucDocTbody() };
                List<StrucDocTr> trList = new List<StrucDocTr>();

                foreach (var obs in this.Procedures)
                {
                    // *** Create the row ***
                    StrucDocTr tr = new StrucDocTr() { ID = obs.ReferenceId };

                    // *** Create a list of TD ***
                    List<StrucDocTd> tdList = new List<StrucDocTd>();

                    // *** Add TD's ***

                    // *** Code System ***
                    tdList.Add(new StrucDocTd() { Text = new string[] { CodingSystemUtility.GetDescription(obs.Code.CodeSystem) } });

                    // *** Code ***
                    tdList.Add(new StrucDocTd() { Text = new string[] { obs.Code.Code } });

                    // *** Description ***
                    tdList.Add(new StrucDocTd() { Text = new string[] { obs.Code.DisplayName } });

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
