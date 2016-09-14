using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.CDA.Common;
using VA.Gov.Artemis.CDA.Observations;

namespace VA.Gov.Artemis.CDA.IHE.Sections
{
    public class AntepartumVisitSummarySection: CdaSection
    {
        // <templateId root='1.3.6.1.4.1.19376.1.5.3.1.1.11.2.2.2'/>
        //<id root=' ' extension=' '/> 3025
        //<code code='57059-8' displayName='Pregnancy visit summary'
        //codeSystem='2.16.840.1.113883.6.1' codeSystemName='LOINC'/>

        public override string CodeSystemName { get { return CdaCode.LoincSystemName; } }
        public override string CodeSystemId { get { return CdaCode.LoincSystemId; } }
        public override string Code { get { return "57059-8"; } }
        public override string DisplayName { get { return "Pregnancy Visit Summary"; } }
        public override CodingSystem CodeSystem { get { return CodingSystem.Loinc; } }
        public override string SectionTitle { get { return "Antepartum Visit Summary"; } }

        public override CdaTemplateIdList TemplateIds
        {
            get
            {
                return new CdaTemplateIdList("1.3.6.1.4.1.19376.1.5.3.1.1.11.2.2.2");
            }
        }

        public CdaPqObservation PrepregnancyWeight { get; set; }

        //public List<CdaSimpleObservation> Observations { get; set; }
        public VisitSummaryOrganizer Organizer { get; set; }

        public AntepartumVisitSummarySection()
        {
            //this.Observations = new List<CdaSimpleObservation>(); 
            this.Organizer = new VisitSummaryOrganizer(); 
        }

        public override POCD_MT000040Component3 ToPocdComponent()
        {
            POCD_MT000040Component3 returnVal = base.ToPocdComponent();

            //if (this.Observations.Count == 0)
            //    this.Narrative = "(No Data)";

            List<POCD_MT000040Entry> entryList = new List<POCD_MT000040Entry>();

            if (this.PrepregnancyWeight != null)
            {
                // *** Create an entry ***
                POCD_MT000040Entry newEntry = new POCD_MT000040Entry();

                // *** Create observation ***
                newEntry.Item = this.PrepregnancyWeight.ToPocd();

                entryList.Add(newEntry);
            }
            
            // *** Create battery ***

            //foreach (CdaBoolObservation obs in this.Observations)
            //{
            //    // *** Create an entry ***
            //    POCD_MT000040Entry newEntry = new POCD_MT000040Entry();

            //    // *** Create observation ***
            //    newEntry.Item = obs.ToPocd();

            //    entryList.Add(newEntry);
            //}

            POCD_MT000040Entry orgEntry = this.Organizer.ToPocdOrganizerEntry();

            if (orgEntry != null)
                entryList.Add(orgEntry);

            returnVal.section.entry = entryList.ToArray();

            return returnVal;
        }


        protected override StrucDocTable GetEntriesTable()
        {
            //return this.Organizer.gE
            // *** Create the table ***
            StrucDocTable returnTable = null;

            if (this.Organizer.Observations.Count > 0)
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

                foreach (var obs in this.Organizer.Observations)
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

                    // *** Description ***
                    tdList.Add(new StrucDocTd() { Text = new string[] { obs.DisplayValue } });

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
