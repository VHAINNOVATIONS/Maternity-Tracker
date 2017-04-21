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
    /// <summary>
    /// A physical exam subsection for use in the coded physical exam
    /// </summary>
    public class PhysicalExamSubsection: CdaSection
    {
        private string codeSystemName;
        private string codeSystemId;
        private string code;
        private string displayName;
        private CdaTemplateIdList templateIds;
        private CodingSystem codeSystem;
        private string sectionTitle;

        // *** Allow entries ***
        public List<CdaSimpleObservation> Observations { get; set; }

        /// <summary>
        /// Sets code information
        /// </summary>
        /// <param name="codeSysNm">The coding system name</param>
        /// <param name="sysId">The coding system id</param>
        /// <param name="cd">The code</param>
        /// <param name="dispName">The display name of the code</param>
        /// <param name="cdSys">The coding system</param>
        public void SetCode(string codeSysNm, string sysId, string cd, string dispName, CodingSystem cdSys)
        {
            this.codeSystemName = codeSysNm;
            this.codeSystemId = sysId;
            this.code = cd;
            this.displayName = dispName;
            this.codeSystem = cdSys; 
        }

        /// <summary>
        /// Sets the template id's for this section
        /// </summary>
        /// <param name="list"></param>
        public void SetTemplateIds(params string[] list)
        {
            this.templateIds = new CdaTemplateIdList(list); 
        }

        /// <summary>
        /// Sets the section title for this section 
        /// </summary>
        /// <param name="title"></param>
        public void SetSectionTitle(string title)
        {
            this.sectionTitle = title;
        }

        public PhysicalExamSubsection()
        {
            this.Observations = new List<CdaSimpleObservation>(); 
        }

        public override string CodeSystemName { get { return this.codeSystemName; } }

        public override string CodeSystemId  { get { return this.codeSystemId; } }

        public override string Code  { get { return this.code; } }

        public override string DisplayName { get { return this.displayName; } }

        public override CdaTemplateIdList TemplateIds { get { return this.templateIds; } }

        public override CodingSystem CodeSystem { get { return this.codeSystem; } }

        public override string SectionTitle { get { return this.sectionTitle; } }

        public override POCD_MT000040Component5 ToPocdComponent5()
        {
            POCD_MT000040Component5 returnVal = base.ToPocdComponent5();

            if (this.Observations.Count > 0)
            {
                List<POCD_MT000040Entry> entryList = new List<POCD_MT000040Entry>();

                foreach (var obs in this.Observations)
                {
                    // *** Create an entry ***
                    POCD_MT000040Entry newEntry = new POCD_MT000040Entry();

                    newEntry.Item = obs.ToPocd();

                    entryList.Add(newEntry);
                }

                returnVal.section.entry = entryList.ToArray();
            }

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
                    tdList.Add(new StrucDocTd() { Text = new string[] { obs.EffectiveTime.Value.ToString() } });

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
