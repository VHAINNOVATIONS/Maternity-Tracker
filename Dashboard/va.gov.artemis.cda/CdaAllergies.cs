using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace VA.Gov.Artemis.CDA
{
    public class CdaAllergies
    {
        public List<CdaAllergy> Allergies { get; set; }

        //<component>
        //<section>
        //<templateId root='2.16.840.1.113883.10.20.1.2'/>
        //<templateId root='1.3.6.1.4.1.19376.1.5.3.1.3.13'/>
        //<id root=' ' extension=' '/>
        //<code code='48765-2' displayName='Allergies, adverse reactions, alerts'
        //codeSystem='2.16.840.1.113883.6.1' codeSystemName='LOINC'/>
        //<text>
        //Text as described above
        //</text>
        //<entry>
        //:
        //<!-- Required Allergies and Intolerances Concern element -->
        //<templateId root='1.3.6.1.4.1.19376.1.5.3.1.4.5.3'/>
        //:
        //</entry>
        //</section>
        //</component>

        public CdaAllergies()
        {
            this.Allergies = new List<CdaAllergy>();
        }

        public POCD_MT000040Component3 ToPocdComponent()
        {
            // *** Converts this item to raw component ***

            POCD_MT000040Component3 returnVal = new POCD_MT000040Component3();

            if (this.Allergies.Count == 0)
                returnVal = null;
            else
            {
                // *** Add new section object ***
                returnVal.section = new POCD_MT000040Section();

                // *** Id ***
                returnVal.section.id = new II() { root = Guid.NewGuid().ToString() };

                // *** Title ***
                returnVal.section.title = new ST() { Text = new string[] { "Allergies" } };

                // *** Set section template ids ***
                returnVal.section.templateId = new II[] { 
                new II() { root = "2.16.840.1.113883.10.20.1.2" }, 
                new II() { root = "1.3.6.1.4.1.19376.1.5.3.1.3.13"}
            };

                // *** Set section ID (Not needed currently) ***
                //returnVal.section.id = new II() { root = "", extension = "" };

                // *** Add code/system information ***
                returnVal.section.code = new CE()
                {
                    code = "48765-2",
                    displayName = "Allergies, adverse reactions, alerts",
                    codeSystem = "2.16.840.1.113883.6.1",
                    codeSystemName = "LOINC"
                };

                returnVal.section.text = GetObservationTable(this.Allergies);

                List<POCD_MT000040Entry> entryList = new List<POCD_MT000040Entry>();

                foreach (CdaAllergy allergy in this.Allergies)
                    entryList.Add(allergy.ToPocdEntry());

                // *** Add entry ***
                returnVal.section.entry = entryList.ToArray();
            }
           
            return returnVal;
        }

        private StrucDocText GetObservationTable(List<CdaAllergy> allergies)
        {
            // *** Creates a structured document text object from a list of allergies ***

            StrucDocText returnVal = new StrucDocText();

            // *** Create the table ***
            StrucDocTable tbl = new StrucDocTable();

            // *** Create Header information ***
            tbl.thead = new StrucDocThead();
            tbl.thead.tr = new StrucDocTr[] { new StrucDocTr() };
            tbl.thead.tr[0].Items = new StrucDocTh[] { 
                new StrucDocTh() { Text = new string[] { "Date/Time" } },
                new StrucDocTh() { Text = new string[] { "Description" } },
                new StrucDocTh() { Text = new string[] { "Status" } }
            };

            // *** Create Body Information ***
            tbl.tbody = new StrucDocTbody[] { new StrucDocTbody() };
            List<StrucDocTr> trList = new List<StrucDocTr>();

            // *** Create a Row for each observation ***
            foreach (CdaAllergy allergy in allergies)
            {
                // *** Create the row ***
                StrucDocTr tr = new StrucDocTr() { ID = allergy.ReferenceId };

                // *** Create a list of TD ***
                List<StrucDocTd> tdList = new List<StrucDocTd>();

                // *** Add TD's ***
                string allergyDateTime = "";
                if (allergy.EffectiveTime != null)
                    if (allergy.Status == Common.CdaConcernStatus.Actve)
                    {
                        if (allergy.EffectiveTime.Low != null)
                            if (allergy.EffectiveTime.Low != DateTime.MinValue)
                                allergyDateTime = allergy.EffectiveTime.Low.ToString();
                    }
                    else if (allergy.EffectiveTime.High != null)
                        if (allergy.EffectiveTime.High != DateTime.MinValue)
                            allergyDateTime = allergy.EffectiveTime.High.ToString();

                tdList.Add(new StrucDocTd() { Text = new string[] { allergyDateTime } });
                tdList.Add(new StrucDocTd() { Text = new string[] { allergy.AllergyText } });
                tdList.Add(new StrucDocTd() { Text = new string[] { allergy.StatusText } });

                tr.Items = tdList.ToArray();

                trList.Add(tr);
            }

            // *** Add rows to body ***
            tbl.tbody[0].tr = trList.ToArray();

            // *** Add a table caption ***
            StrucDocCaption caption = new StrucDocCaption() { Text = new string[] { "Allergies & Intolerances" } };
            tbl.caption = caption;

            // *** Add list of items ***
            List<object> textItems = new List<object>();

            textItems.Add(tbl);

            returnVal.Items = textItems.ToArray();

            return returnVal;
        }
    }
}
