using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.CDA.Common;

namespace VA.Gov.Artemis.CDA
{
    //<act classCode='ACT' moodCode='EVN'>
    //<templateId root='2.16.840.1.113883.10.20.1.27'/>
    //<templateId root='1.3.6.1.4.1.19376.1.5.3.1.4.5.1'/>
    //<templateId root='1.3.6.1.4.1.19376.1.5.3.1.4.5.3'/>
    //<id root=' ' extension=' '/>
    //<code nullFlavor='NA'/>
    //<statusCode code='active|suspended|aborted|completed'/>
    //<effectiveTime>
    //<low value=' '/>
    //<high value=' '/>
    //</effectiveTime>
    //<!-- 1..* entry relationships identifying allergies of concern -->
    //<entryRelationship typeCode='SUBJ'>
    //<observation classCode='OBS' moodCode='EVN'/>
    //<templateId root='1.3.6.1.4.1.19376.1.5.3.1.4.6'/>
    //:
    //</observation>
    //</entryRelationship>
    //<!-- optional entry relationship providing more information about the concern -->
    //<entryRelationship type='REFR'>
    //</entryRelationship>
    //</act>

    //<observation classCode='OBS' moodCode='EVN' negationInd='false'>
    //<templateId root='2.16.840.1.113883.10.20.1.18'/>
    //<templateId root='1.3.6.1.4.1.19376.1.5.3.1.4.6'/>
    //<templateId root='1.3.6.1.4.1.19376.1.5.3.1.4.5'/>
    //<id root=' ' extension=' '/>
    //<code code='ALG|OINT|DALG|EALG|FALG|DINT|EINT|FINT|DNAINT|ENAINT|FNAINT'
    //codeSystem='2.16.840.1.113883.5.4'
    //codeSystemName='ObservationIntoleranceType'/>
    //<text><reference value=' '/></text>
    //<statusCode code='completed'/>
    //<effectiveTime>
    //<low value=' '/>
    //<high value=' '/>
    //</effectiveTime>
    //<value xsi:type='CD' code=' ' codeSystem=' ' displayName=' ' codeSystemName=' '/>
    //<participant typeCode='CSM'>
    //<participantRole classCode='MANU'>
    //<playingEntity classCode='MMAT'>
    //<code code=' ' codeSystem=' '>
    //<originalText><reference value='#substance'/></orginalText>
    //</code>
    //<name></name>
    //</playingEntity>
    //</participantRole>
    //</participant>
    //<!-- zero to many <entryRelationship> elements containing reactions -->
    //<!-- zero or one <entryRelationship> elements containing severity -->
    //<!-- zero or one <entryRelationship> elements containing clinical status -->
    //<!-- zero to many <entryRelationship> elements containing comments -->
    //</observation>

    //<component>
    //    <section>
    //        <templateId root='1.3.6.1.4.1.19376.1.5.3.1.3.13'/>
    //        <code code='10155-0' displayName='HISTORY OF ALLERGIES' 
    //            codeSystem='2.16.840.1.113883.6.1' codeSystemName='LOINC'/>
    //        <title>Allergies</title>
    //        <text> <!-- Narrative -->
    //            <table border='1'>
    //                <thead>
    //                    <tr>
    //                        <td>Allergy</td>
    //                    </tr>
    //                </thead>
    //                <tbody>
    //                    <tr>
    //                        <td ID='Allergy'>Latex</td>
    //                    </tr>
    //                </tbody>
    //            </table>
    //        </text>
    //        <entry> <!-- Latex Allergy -->
    //            <!-- negationInd will be true if patient does NOT have latex allergy -->
    //            <observation classCode='COND' moodCode='EVN' negationInd='false'>
    //                <templateId extension='allergy' root='1.3.6.1.4.1.19376.1.5.3.1.3.13'/>
    //                <id root='dc6d49d1-9371-40bb-9507-90ca93e181a6'/>
    //                <code xsi:type='CD' code='EALG' displayName='ObservationEnvironmentAllergyType' 
    //                    codeSystem='2.16.840.1.113883.5.4' codeSystemName='ActCode' />
    //                <statusCode code='active'/>
    //                <effectiveTime>
    //                    <low value='20041101'/>
    //                </effectiveTime>
    //                <value xsi:type='CD' code='300916003' displayName='Latex allergy (disorder)' 
    //                    codeSystem='2.16.840.1.113883.6.96' codeSystemName='SNOMED CT'>
    //                    <originalText>
    //                        <reference value='#Allergy'/>
    //                    </originalText>
    //                </value>
    //            </observation>
    //        </entry>
    //    </section>
    //</component>

    public class CdaAllergy
    {
        public string Id { get; set; }
        public Hl7ObservationIntoleranceType IntoleranceType { get; set; }
        public string AllergyText { get; set; }
        public string Substance { get; set; }
        public CdaEffectiveTime EffectiveTime { get; set; }
        public CdaConcernStatus Status { get; set; }
        public bool NegationIndicator { get; set; }

        public CdaCode Value { get; set; }

        public string ReferenceId
        {
            get
            {
                return string.Format("al-{0}", this.Id);
            }
        }

        public POCD_MT000040Entry ToPocdEntry()
        {
            // *** Create allergy section ***
            POCD_MT000040Entry entry = new POCD_MT000040Entry();

            // *** Required Allergies and Intolerances Concern element ***
            //entry.templateId = new II[] { 
            //    new II { root = "1.3.6.1.4.1.19376.1.5.3.1.4.5.3" },
            //    new II { root = "2.16.840.1.113883.10.20.1.27" }, 
            //    new II { root = "1.3.6.1.4.1.19376.1.5.3.1.4.5.1" }, 
            //};

            POCD_MT000040Act act = new POCD_MT000040Act();

            act.id = new II[] { new II { root = Guid.NewGuid().ToString() } };

            act.classCode = x_ActClassDocumentEntryAct.ACT;
            act.moodCode = x_DocumentActMood.EVN;

            act.templateId = new II[]{
                new II{root = "2.16.840.1.113883.10.20.1.27"},
                new II{root = "1.3.6.1.4.1.19376.1.5.3.1.4.5.1"},
                new II{root = "1.3.6.1.4.1.19376.1.5.3.1.4.5.3"}
            };

            act.code = new CD() { nullFlavor = "NA" };

            act.statusCode = GetStatusCode(); 

            List<POCD_MT000040EntryRelationship> entryRelationships = new List<POCD_MT000040EntryRelationship>();


            POCD_MT000040EntryRelationship entryRel = new POCD_MT000040EntryRelationship();

            entryRel.typeCode = x_ActRelationshipEntryRelationship.SUBJ;
            
            entryRel.inversionInd = false;
            entryRel.inversionIndSpecified = true; 

            POCD_MT000040Observation obs = new POCD_MT000040Observation();

            obs.id = new II[] { new II { root = Guid.NewGuid().ToString() } };

            obs.classCode = "OBS";
            obs.moodCode = x_ActMoodDocumentObservation.EVN;
            obs.templateId = new II[]{
                new II(){root = "1.3.6.1.4.1.19376.1.5.3.1.4.5"},
                new II(){root = "1.3.6.1.4.1.19376.1.5.3.1.4.6"}, 
                new II(){root = "2.16.840.1.113883.10.20.1.28" }
            };

            obs.negationInd = this.NegationIndicator;
            obs.negationIndSpecified = true; 

            string intoleranceTypeCode = GetIntoleranceType();

            obs.code = new CD()
            {
                code = intoleranceTypeCode,
                codeSystem = "2.16.840.1.113883.5.4",
                codeSystemName = "ObservationIntoleranceType"
            };
           
            obs.text = new ED() { Text = new string[] { this.Id } };

            if (this.Value == null)
                obs.value = new ANY[] { new CD() { originalText = new ED() { Text = new string[] { this.AllergyText } } } };
            else
                obs.value = new ANY[] {this.Value.ToCD()};

            obs.participant = new POCD_MT000040Participant2[]{
            new POCD_MT000040Participant2(){
                    typeCode = "CSM", 
                    participantRole = new POCD_MT000040ParticipantRole()
                    {
                        classCode = "MANU",
                        Item = new POCD_MT000040PlayingEntity (){
                            classCode = "MMAT",
                            code = new CE(){ 
                                code = this.Id, 
                                codeSystemName=CdaCode.VhaSystemName,
                                codeSystem=CdaCode.VhaSystemId,
                                originalText = new ED(){ 
                                    reference = new TEL(){
                                        value=this.Substance
                                    }
                                }
                            }
                        }
                    }
            }
            };

            if (this.EffectiveTime != null)
            {
                act.effectiveTime = this.EffectiveTime.ToIvlTs();
                obs.effectiveTime = act.effectiveTime;
            }

            obs.statusCode = new CS() { code = "completed" };

            // TODO: Optional entry relationships for reactions
            // TODO: Optional entry relationships for severity

            entryRel.Item = obs;

            entryRelationships.Add(entryRel);

            // *** Add entry relationships ***
            act.entryRelationship = entryRelationships.ToArray();

            // ** Add act ***
            entry.Item = act;

            return entry;
        }

        public string StatusText
        {
            get
            {
                string[] codes = new string[] { "", "active", "suspended", "aborted", "completed" };

                return codes[(int)this.Status];
            }
        }

        private CS GetStatusCode()
        {
            CS returnVal = new CS();

            returnVal.code = StatusText;

            return returnVal; 
        }

        private string GetIntoleranceType()
        {
            string returnVal = "";

            string[] codes = new string[] { "", "ALG", "OINT", "DALG", "EALG", "FALG", "DINT", "EINT", "FINT", "DNAINT", "ENAINT", "FNAINT" };

            returnVal = codes[(int)this.IntoleranceType];

            return returnVal; 
        }
    }

 
}
