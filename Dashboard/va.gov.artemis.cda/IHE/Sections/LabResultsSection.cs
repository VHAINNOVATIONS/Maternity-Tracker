// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using VA.Gov.Artemis.CDA.Common;
using VA.Gov.Artemis.CDA.Observations;

namespace VA.Gov.Artemis.CDA.IHE.Sections
{
    public class LabResultsSection
    {
        public CdaCode Code { get; set; }

        public string SectionTitle { get; set; }

        public List<CdaPqObservation> LabObservations { get; set; } 

        public CdaTemplateIdList TemplateIds
        {
            get
            {
                return new CdaTemplateIdList("1.3.6.1.4.1.19376.1.3.3.2.1");
            }
        }

        // *** Narrative text for this section ***
        public string Narrative { get; set; }

        public LabResultsSection()
        {
            this.LabObservations = new List<CdaPqObservation>(); 

        }

        //<section classCode="DOCSECT">
        //  <templateId root="1.3.6.1.4.1.19376.1.3.3.2.1"/>
        //  <!-- Example Specialty Section that holds Report Items directly as a Laboratory Report Data Processing Entry-->
        //  <code code="18719-5" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="CHEMISTRY STUDIES"/>
        //  <title>Laboratory Chemistry Results</title>
        //  <text><table>...</table></text>
        //  <entry typeCode="DRIV">
        //      <templateId root="1.3.6.1.4.1.19376.1.3"/>
        //      <act classCode="ACT" moodCode="EVN">
        //          ...
        //      </act>
        //  </entry>
        //</section>

        public virtual POCD_MT000040Component3 ToPocdComponent()
        {
            // *** Creates the basic section ***

            POCD_MT000040Component3 returnVal = new POCD_MT000040Component3();

            returnVal.section = new POCD_MT000040Section();

            // *** Template ID ***            
            returnVal.section.templateId = this.TemplateIds.ToPocd();

            // *** Make sure section has an unique ID ***
            returnVal.section.id = new II { root = Guid.NewGuid().ToString() };

            // *** Code ***
            returnVal.section.code = this.Code.ToCE(); 

            // *** Title ***
            returnVal.section.title = new ST() { Text = new string[] { this.SectionTitle } };

            // *** Then add the text ***             
            returnVal.section.text = this.GetSectionText();

            List<POCD_MT000040Entry> entryList = new List<POCD_MT000040Entry>();

            // *** Entries ***
            foreach (var item in this.LabObservations)
            {
                // *** Create an entry ***
                POCD_MT000040Entry newEntry = new POCD_MT000040Entry();

                // *** Create observation ***
                newEntry.Item = item.ToPocd();

                entryList.Add(newEntry);
            }

            returnVal.section.entry = entryList.ToArray();

            return returnVal;
        }

        protected StrucDocTable GetEntriesTable()
        {
            // *** Create the table ***
            StrucDocTable returnTable = null;

            if (this.LabObservations.Count > 0)
            {
                returnTable = new StrucDocTable();

                // *** Create Header information ***
                returnTable.thead = new StrucDocThead();
                returnTable.thead.tr = new StrucDocTr[] { new StrucDocTr() };
                returnTable.thead.tr[0].Items = new StrucDocTh[] { 
                    new StrucDocTh() { Text = new string[] { "Test" } },
                    new StrucDocTh() { Text = new string[] { "Result" } },                    
                    new StrucDocTh() { Text = new string[] { "Range" } }, 
                    new StrucDocTh() { Text = new string[] { "Interpretation" } }
                };

                // *** Create Body Information ***
                returnTable.tbody = new StrucDocTbody[] { new StrucDocTbody() };
                List<StrucDocTr> trList = new List<StrucDocTr>();

                foreach (var lab in this.LabObservations)
                {
                    // *** Create the row ***
                    StrucDocTr tr = new StrucDocTr() { ID = lab.ReferenceId };

                    // *** Create a list of TD ***
                    List<StrucDocTd> tdList = new List<StrucDocTd>();

                    // *** Add TD's ***

                    // *** Test ***
                    StrucDocTd td = new StrucDocTd() { Text = new string[] { lab.Code.DisplayName } };
                    tdList.Add(td);

                    // *** Result ***
                    tdList.Add(new StrucDocTd() { Text = new string[] { lab.DisplayValue } });

                    //// *** Units ***
                    //td = new StrucDocTd() { Text = new string[] { lab.Unit } };
                    //td.align = StrucDocTdAlign.center;
                    //td.alignSpecified = true;
                    //tdList.Add(td);

                    // *** Range ***
                    string range = string.Format("{0}-{1}", lab.ReferenceRange.Low, lab.ReferenceRange.High); 
                    td = new StrucDocTd() { Text = new string[] { range } };
                    td.align = StrucDocTdAlign.center;
                    td.alignSpecified = true;
                    tdList.Add(td);

                    // *** Interpretation ***
                    td = new StrucDocTd() { Text = new string[] { lab.InterpretationCode } };
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

        protected virtual StrucDocText GetSectionText()
        {
            // *** Create the section text ***

            // **** Narrative + Entries Table ***

            StrucDocText returnVal = new StrucDocText();

            // *** Create list of items ***
            List<object> textItems = new List<object>();

            if (!string.IsNullOrWhiteSpace(this.Narrative))
            {
                // *** Add narrative ***
                StrucDocParagraph narrativeParagraph = new StrucDocParagraph();
                narrativeParagraph.Text = new string[] { this.Narrative };

                textItems.Add(narrativeParagraph);
            }

            // *** Add entries ***
            StrucDocTable entriesTable = this.GetEntriesTable();

            if (entriesTable != null)
                textItems.Add(entriesTable);

            //// *** Add any additional text needed ***
            //List<object> additionalText = this.GetAdditionalText();

            //if (additionalText != null)
            //    if (additionalText.Count > 0)
            //        textItems.AddRange(additionalText);

            returnVal.Items = textItems.ToArray();

            return returnVal;
        }

    }
}
