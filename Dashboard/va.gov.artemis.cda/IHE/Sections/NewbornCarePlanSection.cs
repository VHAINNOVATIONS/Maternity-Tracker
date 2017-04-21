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
    public class NewbornCarePlanSection : CarePlanSection
    {
        public override string DisplayName { get { return string.Format("{0} (Baby {1})", "Newborn Care Plan", this.BabyNumber); } }

        public override string SectionTitle { get { return this.DisplayName; } }

        public string BabyNumber { get; set; }

        public string PediatricianName { get; set; }

        public override POCD_MT000040Component3 ToPocdComponent()
        {
            POCD_MT000040Component3 returnVal = base.ToPocdComponent();

            // *** Skip unless we have a pediatrician name ***
            if (!string.IsNullOrWhiteSpace(this.PediatricianName) )
            {
                // *** Create encounter containing pediatrician name *** 
                POCD_MT000040Encounter enc = new POCD_MT000040Encounter();

                // *** Set Class, Mood ***
                enc.classCode = "ENC";
                enc.moodCode = x_DocumentEncounterMood.PRP; 

                // *** Set Template Ids ***
                CdaTemplateIdList templateIds = new CdaTemplateIdList("1.3.6.1.4.1.19376.1.5.3.1.4.14", "2.16.840.1.113883.10.20.1.21", "2.16.840.1.113883.10.20.1.25");
                enc.templateId = templateIds.ToPocd();

                // *** Add Id ***
                enc.id = new II[] { new II() { root = Guid.NewGuid().ToString() } };

                // *** Code ***
                enc.code = new CD() { code = "Ambulatory", codeSystem = "2.16.840.1.113883.5.4", codeSystemName = "ActEncounterCode" };

                // *** Add name as performer ***
                CdaName cdaName = new CdaName() { Last = this.PediatricianName };

                enc.performer = new POCD_MT000040Performer2[]
                { 
                    new POCD_MT000040Performer2() 
                    { 
                        typeCode = ParticipationPhysicalPerformer.PRF, 
                        typeCodeSpecified = true, 
                        assignedEntity = new POCD_MT000040AssignedEntity() 
                        { 
                            assignedPerson = new POCD_MT000040Person() 
                            { 
                                name = new PN[] 
                                {
                                    cdaName.ToPN()
                                }
                            }
                        }
                    }
                };

                // *** Add encounter to list of entries ***
                List<POCD_MT000040Entry> entryList = new List<POCD_MT000040Entry>(returnVal.section.entry);
                entryList.Add(new POCD_MT000040Entry() { Item = enc });
                returnVal.section.entry = entryList.ToArray();

                // *** Add pediatrician to human-readable ***
                List<object> items = new List<object>(returnVal.section.text.Items); 

                // *** Create a new paragraph ***
                StrucDocParagraph para = new StrucDocParagraph();
                para.Text = new[] { string.Format("Pediatrician: {0}", this.PediatricianName) };

                // *** Add it to list ***
                items.Add(para);

                // *** Add list to document ***
                returnVal.section.text.Items = items.ToArray(); 
            }

            return returnVal; 
        }

    }
}
