// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.CDA.Common;

namespace VA.Gov.Artemis.CDA.IHE.Sections
{
    public class HistoryOfPastIllnessSection: CdaSection
    {
        // *** Section Information ***
        public override CodingSystem CodeSystem { get { return CodingSystem.Loinc; } }
        public override string CodeSystemName { get { return "LOINC"; } }
        public override string CodeSystemId { get { return "2.16.840.1.113883.6.1"; } }
        public override string Code { get { return "11348-0"; } }
        public override string DisplayName { get { return "History of Past Illness"; } }
        public override CdaTemplateIdList TemplateIds { get { return new CdaTemplateIdList("1.3.6.1.4.1.19376.1.5.3.1.3.8"); } }

        // *** Free-text description of the history of past illness ***
        //public string Narrative { get; set; }

        public ProblemConcernEntriesSection Entries { get; set; }

        public HistoryOfPastIllnessSection()
        {
            this.Entries = new ProblemConcernEntriesSection(); 
        }

        public override string SectionTitle
        {
            get { return "History of Past Illness"; }
        }
        // *** List of observations, matching the Antepartum History of Past Illness Value Set ***
        //public List<CdaProblemObservation> Observations { get; set; }

        //<component>
        //    <section>
        //        <templateId root="1.3.6.1.4.1.19376.1.5.3.1.3.8"/>
        //        <code code="11348-0" displayName="HISTORY OF PAST ILLNESS"
        //            codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC"/>
        //        <title>Resolved Problems</title>
        //        <text>None</text>
        //        <entry>
        //            <act classCode="ACT" moodCode="EVN">
        //                <!-- Required Problem Concern Entry element -->
        //                <templateId root="1.3.6.1.4.1.19376.1.5.3.1.4.5.2"/>
        //                <templateId root="1.3.6.1.4.1.19376.1.5.3.1.4.5.1"/>
        //                <templateId root="2.16.840.1.113883.10.20.1.27"/>
        //                <id/>
        //                <code nullFlavor="NA"/>
        //                <statusCode code="active"/>
        //                <effectiveTime>
        //                    <low value="20071011"/>
        //                    <!-- <high value="20071012"/> -->
        //                </effectiveTime>
        //                <entryRelationship typeCode="SUBJ" inversionInd="false">
        //                    <observation classCode="OBS" moodCode="EVN" negationInd="false">
        //                        <templateId root="2.16.840.1.113883.10.20.1.28"/>
        //                        <templateId root="1.3.6.1.4.1.19376.1.5.3.1.4.5"/>
        //                        <id root="2.1.160"/>
        //                        <code code="64572001" codeSystem="2.16.840.1.113883.6.96"/>
        //                        <statusCode code="completed"/>
        //                        <effectiveTime>
        //                            <low nullFlavor="UNK"/>
        //                        </effectiveTime>
        //                        <text></text>
        //                        <value xsi:type="CD" code="thing" codeSystem="thing"
        //                            codeSystemName="myName" displayName="myName"/>
        //                    </observation>
        //                </entryRelationship>
        //            </act>
        //        </entry>
        //    </section>
        //</component>

        public override POCD_MT000040Component3 ToPocdComponent()
        {
            // *** Creates a CDA POCD component for inclusion in APHP document ***

            if ((string.IsNullOrWhiteSpace(this.Narrative)) && (this.Entries.Observations.Count == 0))
                this.Narrative = "(No Data)"; 

            POCD_MT000040Component3 returnVal = base.ToPocdComponent();

            // *** And entries ***
            List<POCD_MT000040Entry> entryList = this.Entries.ToPocdEntryList();

            // *** Add entry list to section ***
            returnVal.section.entry = entryList.ToArray();

            return returnVal;
        }

        //private StrucDocText GetSectionText()
        //{
        //    StrucDocText returnVal = new StrucDocText();

        //    // *** Create list of items ***
        //    List<object> textItems = new List<object>();

        //    // *** Add narrative ***
        //    StrucDocParagraph narrativeParagraph = new StrucDocParagraph();
        //    narrativeParagraph.Text = new string[] { this.Narrative };

        //    textItems.Add(narrativeParagraph); 

        //    // *** Add entries ***
        //    StrucDocTable entriesTble = this.Entries.ToTable(); //GetObservationTable();

        //    textItems.Add(entriesTble);

        //    returnVal.Items = textItems.ToArray(); 

        //    return returnVal; 
        //}

        //private StrucDocTable GetObservationTable()
        //{
        //    // *** Create the table ***
        //    StrucDocTable returnTable = new StrucDocTable();

        //    // *** Create Header information ***
        //    returnTable.thead = new StrucDocThead();
        //    returnTable.thead.tr = new StrucDocTr[] { new StrucDocTr() };
        //    returnTable.thead.tr[0].Items = new StrucDocTh[] { 
        //        new StrucDocTh() { Text = new string[] { "Problem" } },
        //        new StrucDocTh() { Text = new string[] { "Comment" } },
        //    };

        //    // *** Create Body Information ***
        //    returnTable.tbody = new StrucDocTbody[] { new StrucDocTbody() };
        //    List<StrucDocTr> trList = new List<StrucDocTr>();

        //    // *** Create a Row for each observation ***
        //    foreach (CdaObservation obs in this.Entries.Observations)
        //    {
        //        // *** Create the row ***
        //        StrucDocTr tr = new StrucDocTr() { ID = obs.ReferenceId };

        //        // *** Create a list of TD ***
        //        List<StrucDocTd> tdList = new List<StrucDocTd>();

        //        // *** Add TD's ***
        //        string problemDescription; 
        //        if (obs.NegationIndicator) 
        //            problemDescription = string.Format("(Patient Does Not Have) {0}", obs.Code.DisplayName);
        //        else
        //            problemDescription = obs.Code.DisplayName; 

        //        tdList.Add(new StrucDocTd() { Text = new string[] { problemDescription } });
        //        tdList.Add(new StrucDocTd() { Text = new string[] { obs.Comment } });

        //        tr.Items = tdList.ToArray();

        //        trList.Add(tr);
        //    }

        //    // *** Add rows to body ***
        //    returnTable.tbody[0].tr = trList.ToArray();

        //    return returnTable;
        //}

        //private StrucDocTable GetNarrativeTable()
        //{
        //    // *** Create the table ***
        //    StrucDocTable tbl = new StrucDocTable();

        //    // *** Create Header information ***
        //    tbl.thead = new StrucDocThead();
        //    tbl.thead.tr = new StrucDocTr[] { new StrucDocTr() };
        //    tbl.thead.tr[0].Items = new StrucDocTh[] { 
        //        new StrucDocTh() { Text = new string[] { "Narrative" } },
        //    };

        //    // *** Create Body Information ***
        //    tbl.tbody = new StrucDocTbody[] { new StrucDocTbody() };
        //    List<StrucDocTr> trList = new List<StrucDocTr>();

        //    // *** Create the row ***
        //    StrucDocTr tr = new StrucDocTr() { ID = this.NarrativeObservation.ReferenceId };

        //    // *** Create a list of TD ***
        //    List<StrucDocTd> tdList = new List<StrucDocTd>(); 

        //    // *** Add TD's ***
        //    // TODO: Use comment when available in vista...
        //    tdList.Add( new StrucDocTd() { Text = new string[] { this.NarrativeObservation.Value } });
            
        //    tr.Items = tdList.ToArray();

        //    trList.Add(tr); 

        //    // *** Add rows to body ***
        //    tbl.tbody[0].tr = trList.ToArray();

        //    return tbl; 
        //}



        protected override StrucDocTable GetEntriesTable()
        {
            return this.Entries.ToTable();
        }
    }
}
