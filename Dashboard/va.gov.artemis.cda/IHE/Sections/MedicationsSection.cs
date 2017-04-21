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
    public class MedicationsSection: CdaSection
    {
        //<templateId root='2.16.840.1.113883.10.20.1.8'/>
        //<templateId root='1.3.6.1.4.1.19376.1.5.3.1.3.19'/> 2755
        //<id root=' ' extension=' '/>
        //<code code='10160-0' displayName='HISTORY OF MEDICATION USE'
        //codeSystem='2.16.840.1.113883.6.1' codeSystemName='LOINC'/>

        public override string CodeSystemName { get { return CdaCode.LoincSystemName; } }
        public override string CodeSystemId { get { return CdaCode.LoincSystemId; } }
        public override string Code { get { return "10160-0"; } }
        public override string DisplayName { get { return "History of Medication Use"; } }
        public override CodingSystem CodeSystem { get { return CodingSystem.Loinc; } }
        public override string SectionTitle { get { return "Medications"; } }

        public override CdaTemplateIdList TemplateIds
        {
            get
            {
                return new CdaTemplateIdList("2.16.840.1.113883.10.20.1.8", "1.3.6.1.4.1.19376.1.5.3.1.3.19");
            }
        }

        public List<CdaMedication> Medications { get; set; }

        public MedicationsSection()
        {
            this.Medications = new List<CdaMedication>(); 
        }

        public override POCD_MT000040Component3 ToPocdComponent()
        {
            POCD_MT000040Component3 returnVal = base.ToPocdComponent();

            if (this.Medications.Count == 0)
                this.Narrative = "(No Data)";

            List<POCD_MT000040Entry> entryList = new List<POCD_MT000040Entry>();

            foreach (CdaMedication med in this.Medications)
            {
                // *** Create an entry ***
                POCD_MT000040Entry newEntry = new POCD_MT000040Entry();

                // *** Create observation ***
                newEntry.Item = med.ToPocd();

                entryList.Add(newEntry);
            }

            returnVal.section.entry = entryList.ToArray();

            return returnVal;
        }

        protected override StrucDocTable GetEntriesTable()
        {
            // *** Create the table ***
            StrucDocTable returnTable = null;

            if (this.Medications.Count > 0)
            {
                returnTable = new StrucDocTable();

                // *** Create Header information ***
                returnTable.thead = new StrucDocThead();
                returnTable.thead.tr = new StrucDocTr[] { new StrucDocTr() };
                returnTable.thead.tr[0].Items = new StrucDocTh[] { 
                    new StrucDocTh() { Text = new string[] { "Medication" } },
                    new StrucDocTh() { Text = new string[] { "Start" } },
                    new StrucDocTh() { Text = new string[] { "Stop" } }                
                };

                // *** Create Body Information ***
                returnTable.tbody = new StrucDocTbody[] { new StrucDocTbody() };
                List<StrucDocTr> trList = new List<StrucDocTr>();

                foreach (var med in this.Medications)
                {
                    // *** Create the row ***
                    StrucDocTr tr = new StrucDocTr() { ID = med.ReferenceId };

                    // *** Create a list of TD ***
                    List<StrucDocTd> tdList = new List<StrucDocTd>();

                    // *** Add TD's ***

                    // *** Description ***
                    tdList.Add(new StrucDocTd() { Text = new string[] { med.Description } });

                    // *** Start ***
                    string low = ""; 
                    if (med.EffectiveTime != null)
                        if (med.EffectiveTime.Low != null) 
                            if (med.EffectiveTime.Low != DateTime.MinValue) 
                                low = med.EffectiveTime.Low.ToString();

                    tdList.Add(new StrucDocTd() { Text = new string[] { low } });

                    // *** Stop ***
                    string high = "";
                    if (med.EffectiveTime != null)
                        if (med.EffectiveTime.High != null)
                            if (med.EffectiveTime.High != DateTime.MinValue)
                                high = med.EffectiveTime.High.ToString();

                    StrucDocTd td = new StrucDocTd() { Text = new string[] { high } };
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
