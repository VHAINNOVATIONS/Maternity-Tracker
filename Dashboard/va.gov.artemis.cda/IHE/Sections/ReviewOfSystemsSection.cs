using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.CDA.Common;
using VA.Gov.Artemis.CDA.Observations;

namespace VA.Gov.Artemis.CDA.IHE.Sections
{
    /// <summary>
    /// Review of System Section
    /// Contains Menstrual History Observations
    /// </summary>
    public class ReviewOfSystemsSection: CdaSection 
    {
        // *** Section Information *** 
        public override CodingSystem CodeSystem { get { return CodingSystem.Loinc; } }
        public override string CodeSystemName { get { return "LOINC"; } }
        public override string CodeSystemId { get { return "2.16.840.1.113883.6.1"; } }
        public override string Code { get { return "10187-3"; } }
        public override string DisplayName { get { return "Review of Systems"; } }
        public override CdaTemplateIdList TemplateIds
        {
            get
            {
                return new CdaTemplateIdList("1.3.6.1.4.1.19376.1.5.3.1.3.18");
            }
        }

        public override string SectionTitle
        {
            get { return "Review of Systems"; }
        }
        // *** Review of Systems Included as single string narrative ***
        //public string Narrative { get; set; }

        // *** List of menstrual history observations matching menstrual history value set ***
        public List<CdaSimpleObservation> MenstrualHistoryObservations { get; set; }

        public ReviewOfSystemsSection(): base()
        {
            this.MenstrualHistoryObservations = new List<CdaSimpleObservation>();
        }

        /// <summary>
        /// Create the component to add to the document
        /// </summary>
        /// <returns></returns>
        public override POCD_MT000040Component3 ToPocdComponent()
        {
            if ((string.IsNullOrWhiteSpace(this.Narrative)) && (this.MenstrualHistoryObservations.Count == 0))
                this.Narrative = "(No Data)"; 

            POCD_MT000040Component3 returnVal = base.ToPocdComponent();

            // *** And entries ***
            List<POCD_MT000040Entry> entryList = new List<POCD_MT000040Entry>();

            // *** Create an entry ***
            POCD_MT000040Entry newEntry = new POCD_MT000040Entry();

            // *** Create menstrual history organizer ***
            POCD_MT000040Organizer organizer = new POCD_MT000040Organizer();

            // *** Set the organizer attributes ***
            //organizer.classCode = x_ActClassDocumentEntryOrganizer.CLUSTER;
           organizer.moodCode = "EVN";
           organizer.statusCode = new CS() { code = "active" };

            // *** Menstrual History Organizer Code ***
            CdaCode orgCode = new CdaCode() { Code = "49033-4", CodeSystem = CodingSystem.Loinc, DisplayName = "Menstrual History" };
            organizer.code = orgCode.ToCD();

            // *** Create a list of components for the observations ***
            List<POCD_MT000040Component4> componentList = new List<POCD_MT000040Component4>(); 

            foreach (var item in this.MenstrualHistoryObservations)
            {
                // *** Create a component ***
                POCD_MT000040Component4 component = new POCD_MT000040Component4();

                // *** Add observation to component ***
                component.Item = item.ToPocd();

                // *** Add component to list ***
                componentList.Add(component);
            }

            // *** Add component array to organizer ***
            organizer.component = componentList.ToArray();

            // *** Add organizer to entry ***
            newEntry.Item = organizer;

            // *** Add entry to the list ***
            entryList.Add(newEntry);

            // *** Add entry list to section ***
            returnVal.section.entry = entryList.ToArray();

            return returnVal;
        }

        //private StrucDocText GetSectionText()
        //{
        //    // *** Create the section text ***

        //    // **** Narrative + Entries Table ***

        //    StrucDocText returnVal = new StrucDocText();

        //    // *** Create list of items ***
        //    List<object> textItems = new List<object>();

        //    if (!string.IsNullOrWhiteSpace(this.Narrative))
        //    {
        //        // *** Add narrative ***
        //        StrucDocParagraph narrativeParagraph = new StrucDocParagraph();
        //        narrativeParagraph.Text = new string[] { this.Narrative };

        //        textItems.Add(narrativeParagraph);
        //    }

        //    // *** Add entries ***
        //    StrucDocTable entriesTble = this.GetEntriesTable(); 

        //    textItems.Add(entriesTble);

        //    returnVal.Items = textItems.ToArray();

        //    return returnVal;
        //}

        protected override StrucDocTable GetEntriesTable()
        {
            // *** Create the table ***
            StrucDocTable returnTable = null; 

            if (this.MenstrualHistoryObservations.Count > 0)
            {
                returnTable = new StrucDocTable();

                // *** Create Header information ***
                returnTable.thead = new StrucDocThead();
                returnTable.thead.tr = new StrucDocTr[] { new StrucDocTr() };
                returnTable.thead.tr[0].Items = new StrucDocTh[] { 
                    new StrucDocTh() { Text = new string[] { "Description" } },
                    new StrucDocTh() { Text = new string[] { "Value" } },
                    new StrucDocTh() { Text = new string[] { "Comment" } },
                };

                // *** Create Body Information ***
                returnTable.tbody = new StrucDocTbody[] { new StrucDocTbody() };
                List<StrucDocTr> trList = new List<StrucDocTr>();

                // *** Sort list to put positives first ***
                this.MenstrualHistoryObservations.Sort(delegate(CdaSimpleObservation x, CdaSimpleObservation y)
                {
                    return x.NegationIndicator.CompareTo(y.NegationIndicator);
                });

                // *** Create a Row for each observation ***
                foreach (CdaSimpleObservation obs in this.MenstrualHistoryObservations)
                {
                    // *** Create the row ***
                    StrucDocTr tr = new StrucDocTr() { ID = obs.ReferenceId };

                    // *** Create a list of TD ***
                    List<StrucDocTd> tdList = new List<StrucDocTd>();

                    // *** Add TD's ***
                    tdList.Add(new StrucDocTd() { Text = new string[] { obs.Code.DisplayName } });

                    StrucDocTd td = new StrucDocTd() { Text = new string[] { obs.DisplayValue } };
                    tdList.Add(td);

                    tdList.Add(new StrucDocTd() { Text = new string[] { obs.Comment } });

                    tr.Items = tdList.ToArray();

                    trList.Add(tr);
                }

                // *** Add rows to body ***
                returnTable.tbody[0].tr = trList.ToArray();

                returnTable.caption = new StrucDocCaption() { Text = new string[] { "Menstrual History" } };
            }

            return returnTable;
        }

    }
}
