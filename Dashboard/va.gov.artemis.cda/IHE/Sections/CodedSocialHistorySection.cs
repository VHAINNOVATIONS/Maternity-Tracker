// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.CDA.Common;
using VA.Gov.Artemis.CDA.Observations;

namespace VA.Gov.Artemis.CDA.IHE.Sections
{
    public class CodedSocialHistorySection: CdaSection
    {
        // *** Section Information *** 
        public override CodingSystem CodeSystem { get { return CodingSystem.Loinc; } }
        public override string CodeSystemName { get { return "LOINC"; } }
        public override string CodeSystemId { get { return "2.16.840.1.113883.6.1"; } }
        public override string Code { get { return "29762-2"; } }
        public override string DisplayName { get { return "Social History"; } }
        public override CdaTemplateIdList TemplateIds
        {
            get
            {
                return new CdaTemplateIdList("2.16.840.1.113883.10.20.1.15", "1.3.6.1.4.1.19376.1.5.3.1.3.16", "1.3.6.1.4.1.19376.1.5.3.1.3.16.1");
            }
        }

        public override string SectionTitle
        {
            get { return "Coded Social History"; }
        }

        // *** Narrative Observation ***
        //public CdaSocialObservation NarrativeObservation { get; set; }
        //public string Narrative { get; set; }

        // *** Social History Observations ***
        public List<CdaSimpleObservation> Observations { get; set; }

        public CodedSocialHistorySection()
        {
            this.Observations = new List<CdaSimpleObservation>(); 
        }

        // *** Some sample data ***

            //<!-- Social History -->
            //<component>
            //    <section>
            //        <templateId root="2.16.840.1.113883.10.20.1.15"/>
            //        <templateId root="1.3.6.1.4.1.19376.1.5.3.1.3.16"/>
            //        <code code="29762-2" displayName="SOCIAL HISTORY"
            //            codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC"/>
            //        <title>Social History</title>
            //        <text>Social History </text>
            //    </section>
            //</component>

            //<component>
            //    <section>
            //        <templateId root='11.3.6.1.4.1.19376.1.5.3.1.3.16'/>
            //        <templateId root='11.3.6.1.4.1.19376.1.5.3.1.3.16.1'/>
            //        <id root=' ' extension=' '/> 1805
            //        <code code='29762-2’ displayName='SOCIAL HISTORY'
            //            codeSystem='2.16.840.1.113883.6.1' codeSystemName='LOINC'/>
            //        <text>
            //            Text as described above
            //        </text> 1810
            //    </section>
            //</component>

        public override POCD_MT000040Component3 ToPocdComponent()
        {
            // *** Creates the component data ***

            POCD_MT000040Component3 returnVal;

            if ((string.IsNullOrWhiteSpace(this.Narrative)) && (this.Observations.Count == 0))
                this.Narrative = "(No Data)"; 

            // *** First create base ***
            returnVal = base.ToPocdComponent(); 

            // *** Add the text ***             
            //returnVal.section.text = this.GetSectionText();

            // *** Create a list of entries ***
            List<POCD_MT000040Entry> entryList = new List<POCD_MT000040Entry>();

            // *** Loop through observations ***
            foreach (CdaSimpleObservation observation in this.Observations)
            {
                // *** Create an entry ***
                POCD_MT000040Entry tempEntry = new POCD_MT000040Entry();

                // *** Add a single social observation ***
                tempEntry.Item = observation.ToPocd(); 

                // *** Add entry to list ***
                entryList.Add(tempEntry);
            }

            // *** Add entry list as array ***
            returnVal.section.entry = entryList.ToArray();

            return returnVal; 
        }

        //private StrucDocText GetSectionText()
        //{
        //    // *** Get the text section ***

        //    StrucDocText returnVal = new StrucDocText();

        //    // *** Create list of items ***
        //    List<object> textItems = new List<object>();

        //    // *** Add narrative ***
        //    if (!string.IsNullOrWhiteSpace(this.Narrative))
        //    {
        //        StrucDocParagraph narrativeParagraph = new StrucDocParagraph();
        //        narrativeParagraph.Text = new string[] { this.Narrative };

        //        textItems.Add(narrativeParagraph);
        //    }

        //    // *** Add entries ***
        //    StrucDocTable entriesTble = this.GetTable(); 

        //    // *** Add entries to items list ***
        //    textItems.Add(entriesTble);

        //    // *** Add items as array ***
        //    returnVal.Items = textItems.ToArray();

        //    return returnVal;
        //}

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
                    new StrucDocTh() { Text = new string[] { "Description" } },
                    new StrucDocTh() { Text = new string[] { "Amount" } },
                    new StrucDocTh() { Text = new string[] { "Comment" } },
                };

                // *** Create Body Information ***
                returnTable.tbody = new StrucDocTbody[] { new StrucDocTbody() };
                List<StrucDocTr> trList = new List<StrucDocTr>();

                // *** Create a Row for each observation ***
                foreach (CdaSimpleObservation obs in this.Observations)
                {
                    // *** Create the row ***
                    StrucDocTr tr = new StrucDocTr() { ID = obs.ReferenceId };

                    // *** Create a list of TD ***
                    List<StrucDocTd> tdList = new List<StrucDocTd>();

                    // *** Add TD's ***
                    string problemDescription;
                    if (obs.NegationIndicator)
                        problemDescription = string.Format("(Patient Does Not Have) {0}", obs.Code.DisplayName);
                    else
                        problemDescription = obs.Code.DisplayName;

                    tdList.Add(new StrucDocTd() { Text = new string[] { problemDescription } });
                    if (obs is CdaPqObservation)
                    {
                        CdaPqObservation pqObs = (CdaPqObservation)obs;
                        tdList.Add(new StrucDocTd() { Text = new string[] { pqObs.Amount } });
                    }
                    else
                        tdList.Add(new StrucDocTd() { Text = new string[] { "N/A" } });

                    tdList.Add(new StrucDocTd() { Text = new string[] { obs.Comment } });

                    tr.Items = tdList.ToArray();

                    trList.Add(tr);
                }

                // *** Add rows to body ***
                returnTable.tbody[0].tr = trList.ToArray();
            }

            return returnTable;
        }
    }
}
