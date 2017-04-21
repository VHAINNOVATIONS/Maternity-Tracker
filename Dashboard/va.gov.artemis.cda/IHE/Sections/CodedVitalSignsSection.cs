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
    /// A Coded Vital Signs Section as defined by IHE PCC TF2
    /// </summary>
    public class CodedVitalSignsSection: CdaSection
    {
        // *** Section Information *** 
        public override CodingSystem CodeSystem { get { return CodingSystem.Loinc; } }
        public override string CodeSystemName { get { return "LOINC"; } }
        public override string CodeSystemId { get { return "2.16.840.1.113883.6.1"; } }
        public override string Code { get { return "8716-3"; } }
        public override string DisplayName { get { return "Vital Signs"; } }
        public override string SectionTitle { get { return "Vital Signs"; } }

        public override CdaTemplateIdList TemplateIds
        {
            get
            {
                return new CdaTemplateIdList("2.16.840.1.113883.10.20.1.16", "1.3.6.1.4.1.19376.1.5.3.1.3.25", "1.3.6.1.4.1.19376.1.5.3.1.1.5.3.2");
            }
        }

        // *** The vital signs subsection has specific observations ***
        public List<CdaPqObservation> Observations { get; set; }

        public CodedVitalSignsSection()
        {
            this.Observations = new List<CdaPqObservation>(); 
        }

        /// <summary>
        /// Create the component to add to the document
        /// </summary>
        /// <returns></returns>
        public override POCD_MT000040Component5 ToPocdComponent5()
        {
            if (this.Observations.Count == 0)
                this.Narrative = "(No Data)"; 

            POCD_MT000040Component5 returnVal = base.ToPocdComponent5();

            // *** Check if we have entries ***
            if (this.Observations.Count > 0)
            {
                // *** And entries ***
                List<POCD_MT000040Entry> entryList = new List<POCD_MT000040Entry>();

                // *** Create an entry ***
                POCD_MT000040Entry newEntry = new POCD_MT000040Entry();

                // *** Create vital signs organizer ***
                POCD_MT000040Organizer organizer = new POCD_MT000040Organizer();

                // *** Set the organizer attributes ***
                organizer.classCode = x_ActClassDocumentEntryOrganizer.CLUSTER;
                organizer.moodCode = "EVN";

                // *** Template Id's ***
                CdaTemplateIdList orgIds = new CdaTemplateIdList("2.16.840.1.113883.10.20.1.32", "2.16.840.1.113883.10.20.1.35", "1.3.6.1.4.1.19376.1.5.3.1.4.13.1");
                organizer.templateId = orgIds.ToPocd();

                // *** Vital Signs Organizer Code ***
                CdaCode orgCode = new CdaCode() { Code = "46680005", CodeSystem = CodingSystem.SnomedCT, DisplayName = "Vital Signs" };
                organizer.code = orgCode.ToCD();

                // *** Organizer shall have id ***
                organizer.id = new II[] { new II() { root = Guid.NewGuid().ToString() } };

                organizer.statusCode = new CS() { code = "completed" };

                // *** Note: Using first observation's date/time ***

                // *** Effective Time of observations ***
                organizer.effectiveTime = this.Observations[0].EffectiveTime.ToIvlTs();

                // *** Create a list of components for the observations ***
                List<POCD_MT000040Component4> componentList = new List<POCD_MT000040Component4>();

                foreach (var item in this.Observations)
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
                    new StrucDocTh() { Text = new string[] { "Measurement" } },
                    new StrucDocTh() { Text = new string[] { "Value" } },
                    new StrucDocTh() { Text = new string[] { "Comment" } },
                };

                // *** Create Body Information ***
                returnTable.tbody = new StrucDocTbody[] { new StrucDocTbody() };
                List<StrucDocTr> trList = new List<StrucDocTr>();

                // *** Create a Row for each observation ***
                foreach (CdaPqObservation obs in this.Observations)
                {
                    // *** Create the row ***
                    StrucDocTr tr = new StrucDocTr() { ID = obs.ReferenceId };

                    // *** Create a list of TD ***
                    List<StrucDocTd> tdList = new List<StrucDocTd>();

                    // *** Add TD's ***
                    tdList.Add(new StrucDocTd() { Text = new string[] { obs.Code.DisplayName } });
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
