using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.CDA.Common;
using VA.Gov.Artemis.CDA.Observations;

namespace VA.Gov.Artemis.CDA.IHE.Sections
{
    public class ProblemConcernEntriesSection
    {
        // *** List of observations which are problem concerns ***
        public List<CdaCodeObservation> Observations { get; set; }

        public List<POCD_MT000040Entry> ToPocdEntryList()
        {
            List<POCD_MT000040Entry> entryList = new List<POCD_MT000040Entry>();

            if (this.Observations != null)
                foreach (CdaCodeObservation cdaObservation in this.Observations)
                {
                    // *** Create the entry ***
                    POCD_MT000040Entry tempEntry = new POCD_MT000040Entry();

                    // *** Create an act ***
                    POCD_MT000040Act act = new POCD_MT000040Act();

                    act.id = new II[] { new II { root = Guid.NewGuid().ToString() } };

                    act.classCode = x_ActClassDocumentEntryAct.ACT;
                    act.moodCode = x_DocumentActMood.EVN;

                    // *** Add template ids for this act ***
                    CdaTemplateIdList templateIdList =
                        new CdaTemplateIdList(
                            "1.3.6.1.4.1.19376.1.5.3.1.4.5.2",
                            "1.3.6.1.4.1.19376.1.5.3.1.4.5.1",
                            "2.16.840.1.113883.10.20.1.27");

                    act.templateId = templateIdList.ToPocd();

                    // *** No code here ***
                    act.code = new CD() { nullFlavor = "NA" };

                    // *** The concern is active, even though the problem itself may be resolved or inactive ***
                    act.statusCode = new CS() { code = "active" };

                    // *** This concern uses the observation date/time ***
                    //CdaEffectiveTime effTime = new CdaEffectiveTime() { Low = cdaObservation.EffectiveTime };
                    //act.effectiveTime = effTime.ToIvlTs();
                    act.effectiveTime = cdaObservation.EffectiveTime.ToIvlTs(); 

                    // *** Create entry relationship ***
                    List<POCD_MT000040EntryRelationship> entryRelationships = new List<POCD_MT000040EntryRelationship>();

                    POCD_MT000040EntryRelationship tempEntryRelationship = new POCD_MT000040EntryRelationship();

                    tempEntryRelationship.typeCode = x_ActRelationshipEntryRelationship.SUBJ;
                    tempEntryRelationship.inversionInd = false;
                    tempEntryRelationship.inversionIndSpecified = true; 

                    // *** Create pocd observation ***
                    POCD_MT000040Observation observation = cdaObservation.ToPocd();

                    // *** Add the observation to the entry relationship ***
                    tempEntryRelationship.Item = observation;

                    // *** Add the entry relationship to the list ***
                    entryRelationships.Add(tempEntryRelationship);

                    // *** Add entry relationships to the act ***
                    act.entryRelationship = entryRelationships.ToArray();

                    // *** Add act to entry ***
                    tempEntry.Item = act;

                    // *** Add entry to list ***
                    entryList.Add(tempEntry);
                }

            return entryList;
        }

        public StrucDocTable ToTable() 
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
                    new StrucDocTh() { Text = new string[] { "Problem" } },
                    new StrucDocTh() { Text = new string[] { "Yes/No" } },
                    new StrucDocTh() { Text = new string[] { "Comment" } },
                };

                // *** Create Body Information ***
                returnTable.tbody = new StrucDocTbody[] { new StrucDocTbody() };
                List<StrucDocTr> trList = new List<StrucDocTr>();

                // *** Sort list to put positives first ***
                this.Observations.Sort(delegate(CdaCodeObservation x, CdaCodeObservation y)
                {
                    return x.NegationIndicator.CompareTo(y.NegationIndicator);
                });

                // *** Create a Row for each observation ***
                foreach (CdaCodeObservation obs in this.Observations)
                {
                    // *** Create the row ***
                    StrucDocTr tr = new StrucDocTr() { ID = obs.ReferenceId };

                    // *** Create a list of TD ***
                    List<StrucDocTd> tdList = new List<StrucDocTd>();

                    // *** Add TD's ***
                    //string problemDescription; 
                    //if (obs.NegationIndicator) 
                    //    problemDescription = string.Format("(Patient Does Not Have) {0}", obs.Code.DisplayName);
                    //else
                    //    problemDescription = obs.Code.DisplayName; 

                    //tdList.Add(new StrucDocTd() { Text = new string[] { problemDescription } });
                    tdList.Add(new StrucDocTd() { Text = new string[] { obs.Value.DisplayName } });

                    StrucDocTd td = new StrucDocTd() { Text = new string[] { (obs.NegationIndicator) ? "NO" : "YES" } };
                    td.align = StrucDocTdAlign.center;
                    td.alignSpecified = true;
                    tdList.Add(td);
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
