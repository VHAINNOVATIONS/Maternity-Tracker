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
    public class CodedFamilyMedicalHistorySection: CdaSection
    {
        // *** Section Information *** 
        public override CodingSystem CodeSystem { get { return CodingSystem.Loinc; } }
        public override string CodeSystemName { get { return "LOINC"; } }
        public override string CodeSystemId { get { return "2.16.840.1.113883.6.1"; } }
        public override string Code { get { return "10157-6"; } }
        public override string DisplayName { get { return "History of Family Member Diseases"; } }
        public override CdaTemplateIdList TemplateIds
        {
            get
            {
                return new CdaTemplateIdList("1.3.6.1.4.1.19376.1.5.3.1.3.15", "1.3.6.1.4.1.19376.1.5.3.1.3.14");
            }
        }

        public CdaCodeObservation UnknownObservation { get; set; }

        public override string SectionTitle
        {
            get { return "Family Medical History"; }
        }

        // *** Since observations are grouped by family member, use a dictionary keyed by family memnber for the observations ***
        private Dictionary<Hl7FamilyMember, List<CdaCodeObservation>> Observations { get; set; }

        public CodedFamilyMedicalHistorySection(): base()
        {
            // *** Create empty ***
            this.Observations = new Dictionary<Hl7FamilyMember, List<CdaCodeObservation>>(); 
        }

        public void AddObservation(Hl7FamilyMember relation, CdaCodeObservation observation)
        {
            // *** Adds an observation to the dictionary ***

            // *** Add the list if it does not exist yet ***
            if (this.Observations.ContainsKey(relation) == false)
                this.Observations.Add(relation, new List<CdaCodeObservation>());

            // *** Add observation to proper list ***
            this.Observations[relation].Add(observation); 
        }

        public int ObservationCount
        {
            get
            {
                return this.Observations.Keys.Count; 
            }
        }

        // *** Sample code from IHE PCC TF ***

            //<entry>
            //    <organizer classCode='CLUSTER' moodCode='EVN'>
            //        <templateId root='2.16.840.1.113883.10.20.1.23'/>
            //        <templateId root='1.3.6.1.4.1.19376.1.5.3.1.4.15'/>
            //        <subject typeCode='SBJ'>
            //            <relatedSubject classCode='PRS'>
                //            <code code='' displayName='' codeSystem='2.16.840.1.113883.5.111' codeSystemName='RoleCode'/>
                //            <subject>
                //                <sdtc:id root='' extension=''/>
                //                <administrativeGenderCode code='' displayName='' codeSystem='' codeSystemName=''/>
                //            </subject>
            //            </relatedSubject>
            //        </subject>
            //        <!-- zero or more participants linking to other relations -->
            //        <participant typeCode='IND'>
            //            <participantRole classCode='PRS'>
            //                <code code='' displayName='' codeSystem='2.16.840.1.113883.5.111' codeSystemName='RoleCode'/>
            //                <playingEntity classCode='PSN'>
            //                    <sdtc:id root='' extension=''/>
            //                </playingEntity>
            //            </participantRole>
            //        </participant>
            //        <!-- one or more entry relationships for family history observations -->
            //        <component typeCode='COMP'>
            //            <observation classCode='OBS' moodCode='EVN'>
            //                <templateId root='2.16.840.1.113883.10.20.1.22'/>
            //            </observation>
            //        </component>
            //    </organizer>
            //</entry>

        public override POCD_MT000040Component3 ToPocdComponent()
        {
            if (this.Observations.Count == 0)
                this.Narrative = "(No Data)"; 

            // *** Create the component ***
            POCD_MT000040Component3 returnVal = base.ToPocdComponent();

            // *** There is one "organizer" per family member ***

            // *** Add the text ***             
            //returnVal.section.text = this.GetSectionText();

            // *** Create list of entries ***
            List<POCD_MT000040Entry> entryList = new List<POCD_MT000040Entry>();

            // *** If we don't have anything ***
            if (this.UnknownObservation != null)
            {
                // *** Create an entry ***
                POCD_MT000040Entry newEntry = new POCD_MT000040Entry();

                // *** Each entry has one organizer ***
                POCD_MT000040Organizer organizer = new POCD_MT000040Organizer();

                // *** Set the organizer attributes ***
                organizer.classCode = x_ActClassDocumentEntryOrganizer.CLUSTER;
                organizer.moodCode = "EVN";

                // *** Create the template ids ***
                CdaTemplateIdList ids = new CdaTemplateIdList("2.16.840.1.113883.10.20.1.23", "1.3.6.1.4.1.19376.1.5.3.1.4.15");
                organizer.templateId = ids.ToPocd();

                organizer.statusCode = new CS() { code = "completed" };

                CdaSubject cdaSubject = new CdaSubject() { FamilyMember =  Hl7FamilyMember.FamilyMember };

                // *** Add the subject to the organizer ***
                organizer.subject = cdaSubject.ToPocdSubject();

                // *** Create a list of components for the observations for this family member ***
                List<POCD_MT000040Component4> componentList = new List<POCD_MT000040Component4>();

                // *** Create a component ***
                POCD_MT000040Component4 component = new POCD_MT000040Component4();

                // *** Add observation to component ***
                component.Item = this.UnknownObservation.ToPocd();

                // *** Add component to list ***
                componentList.Add(component);

                // *** Add component array to organizer ***
                organizer.component = componentList.ToArray();

                // *** Add organizer to entry ***
                newEntry.Item = organizer;

                // *** Add entry to the list ***
                entryList.Add(newEntry);
            }
            else
            {
                // *** Loop through family members ***
                foreach (Hl7FamilyMember key in this.Observations.Keys)
                {
                    // *** Create an entry ***
                    POCD_MT000040Entry newEntry = new POCD_MT000040Entry();

                    // *** Each entry has one organizer ***
                    POCD_MT000040Organizer organizer = new POCD_MT000040Organizer();

                    // *** Set the organizer attributes ***
                    organizer.classCode = x_ActClassDocumentEntryOrganizer.CLUSTER;
                    organizer.moodCode = "EVN";

                    // *** Create the template ids ***
                    CdaTemplateIdList ids = new CdaTemplateIdList("2.16.840.1.113883.10.20.1.23", "1.3.6.1.4.1.19376.1.5.3.1.4.15");
                    organizer.templateId = ids.ToPocd();

                    organizer.statusCode = new CS() { code = "completed" };

                    //// *** Create the subject ***
                    //POCD_MT000040Subject subject = new POCD_MT000040Subject() { typeCode = ParticipationTargetSubject.SBJ, typeCodeSpecified = true };

                    //// *** Create the related subject ***
                    //POCD_MT000040RelatedSubject relatedSubject = new POCD_MT000040RelatedSubject() { classCode = x_DocumentSubject.PRS };

                    //// *** Create the role and add as code ***
                    //CdaRoleCode roleCode = new CdaRoleCode() { FamilyMember = key }; 
                    //relatedSubject.code = roleCode.ToCe(); 

                    //// *** Add the related subject to the subject ***
                    //subject.relatedSubject = relatedSubject;

                    CdaSubject cdaSubject = new CdaSubject() { FamilyMember = key };

                    // *** Add the subject to the organizer ***
                    organizer.subject = cdaSubject.ToPocdSubject();

                    // *** Create a list of components for the observations for this family member ***
                    List<POCD_MT000040Component4> componentList = new List<POCD_MT000040Component4>();

                    // *** Loop through all observations for this family member ***
                    foreach (CdaCodeObservation obs in this.Observations[key])
                    {
                        // *** Create a component ***
                        POCD_MT000040Component4 component = new POCD_MT000040Component4();

                        // *** Add observation to component ***
                        component.Item = obs.ToPocd();

                        // *** Add component to list ***
                        componentList.Add(component);
                    }

                    // *** Add component array to organizer ***
                    organizer.component = componentList.ToArray();

                    // *** Add organizer to entry ***
                    newEntry.Item = organizer;

                    // *** Add entry to the list ***
                    entryList.Add(newEntry);
                }
            }

            // *** Add entry list to section ***
            returnVal.section.entry = entryList.ToArray();

            return returnVal; 
        }

        //private StrucDocText GetSectionText()
        //{
        //    // *** Create the section text ***

        //    StrucDocText returnVal = new StrucDocText();

        //    // *** Create list of items ***
        //    List<object> textItems = new List<object>();

        //    // *** Add entries ***
        //    StrucDocTable entriesTble = this.GetTable();
        //    textItems.Add(entriesTble);

        //    // *** Add text items to return ***
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
                    new StrucDocTh() { Text = new string[] { "Relationship" } },
                    new StrucDocTh() { Text = new string[] { "Diagnosis" } },
                    new StrucDocTh() { Text = new string[] { "Yes/No" } }                
                };

                // *** Create Body Information ***
                returnTable.tbody = new StrucDocTbody[] { new StrucDocTbody() };
                List<StrucDocTr> trList = new List<StrucDocTr>();

                foreach (var key in this.Observations.Keys)
                {
                    // *** Sort list to put positives first ***
                    this.Observations[key].Sort(delegate(CdaCodeObservation x, CdaCodeObservation y)
                    {
                        return x.NegationIndicator.CompareTo(y.NegationIndicator);
                    });

                    bool first = true;

                    // *** Create a Row for each observation ***
                    foreach (CdaCodeObservation obs in this.Observations[key])
                    {
                        // *** Create the row ***
                        StrucDocTr tr = new StrucDocTr() { ID = obs.ReferenceId };

                        // *** Create a list of TD ***
                        List<StrucDocTd> tdList = new List<StrucDocTd>();

                        // *** Add TD's ***

                        // *** Show relationship for first only ***
                        if (first)
                        {
                            CdaRoleCode role = new CdaRoleCode() { FamilyMember = obs.Relationship };
                            StrucDocTd tempTd = new StrucDocTd() { Text = new string[] { role.DisplayName } };
                            tempTd.styleCode = "Bold";
                            tdList.Add(tempTd);
                            first = false;
                        }
                        else
                            tdList.Add(new StrucDocTd());

                        // *** Display Name ***
                        tdList.Add(new StrucDocTd() { Text = new string[] { obs.Value.DisplayName } });

                        // *** Yes/No ***
                        StrucDocTd td = new StrucDocTd() { Text = new string[] { (obs.NegationIndicator) ? "NO" : "YES" } };
                        td.align = StrucDocTdAlign.center;
                        td.alignSpecified = true;
                        tdList.Add(td);

                        // *** Add td's to tr ***
                        tr.Items = tdList.ToArray();

                        // *** Add tr to tr list ***
                        trList.Add(tr);
                    }
                }

                // *** Add rows to body ***
                returnTable.tbody[0].tr = trList.ToArray();
            }

            return returnTable;
        }

    }
}
