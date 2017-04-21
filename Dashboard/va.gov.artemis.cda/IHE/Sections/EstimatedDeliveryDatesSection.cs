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
    public class EstimatedDeliveryDatesSection: CdaSection
    {
        // <templateId root='1.3.6.1.4.1.19376.1.5.3.1.1.11.2.2.1'/>
        //<code code='57060-6' displayName='Estimated date of delivery'

        public override string CodeSystemName { get { return CdaCode.LoincSystemName; } }
        public override string CodeSystemId { get { return CdaCode.LoincSystemId; } }
        public override string Code { get { return "57060-6"; } }
        public override string DisplayName { get { return "Estimated Date of Delivery"; } }
        public override CodingSystem CodeSystem { get { return CodingSystem.Loinc; } }
        public override string SectionTitle { get { return "Estimated Date of Delivery"; } }

        public CdaDateObservation EstimatedDeliveryDate { get; set; }

        public override CdaTemplateIdList TemplateIds
        {
            get
            {
                return new CdaTemplateIdList("1.3.6.1.4.1.19376.1.5.3.1.1.11.2.2.1");
            }
        }

        public override POCD_MT000040Component3 ToPocdComponent()
        {
            POCD_MT000040Component3 returnVal = base.ToPocdComponent();

            if (this.EstimatedDeliveryDate == null) 
                this.Narrative = "(No Data)";

            returnVal.section.entry = new POCD_MT000040Entry[1];
            returnVal.section.entry[0] = new POCD_MT000040Entry(); 
            returnVal.section.entry[0].Item = this.EstimatedDeliveryDate.ToPocd();

            return returnVal;
        }

        protected override StrucDocTable GetEntriesTable()
        {
            // *** Create the table ***
            StrucDocTable returnTable = null;

            if (this.EstimatedDeliveryDate != null)
            {
                returnTable = new StrucDocTable();

                // *** Create Header information ***
                returnTable.thead = new StrucDocThead();
                returnTable.thead.tr = new StrucDocTr[] { new StrucDocTr() };
                returnTable.thead.tr[0].Items = new StrucDocTh[] { 
                    new StrucDocTh() { Text = new string[] { "Date/Time" } },
                    new StrucDocTh() { Text = new string[] { "Description" } },
                    new StrucDocTh() { Text = new string[] { "Value" } }, 
                };

                // *** Create Body Information ***
                returnTable.tbody = new StrucDocTbody[] { new StrucDocTbody() };
                List<StrucDocTr> trList = new List<StrucDocTr>();

                DateTime dt = DateTime.MinValue;
                if (this.EstimatedDeliveryDate.Author != null) 
                    dt = this.EstimatedDeliveryDate.Author.Time;                 

                StrucDocTr tr = CreateRow(this.EstimatedDeliveryDate, true, dt);

                trList.Add(tr);

                foreach (var item in this.EstimatedDeliveryDate.SupportingObservations)
                {
                    //tr = CreateRow(item, false, dt); 

                    //// *** Add tr to tr list ***
                    //trList.Add(tr);

                    if (item.SupportingObservations.Count > 0)
                        foreach (var sprt in item.SupportingObservations)
                        {                            
                            tr = CreateRow(sprt, false, dt);
                            trList.Add(tr);
                        }
                }

                // *** Add rows to body ***
                returnTable.tbody[0].tr = trList.ToArray();
            }

            return returnTable;
        }

        private StrucDocTr CreateRow(CdaSimpleObservation obs, bool isFinal, DateTime dateTime)
        {
            // *** Create the row ***
            StrucDocTr tr = new StrucDocTr() { ID = obs.ReferenceId };

            // *** Create a list of TD ***
            List<StrucDocTd> tdList = new List<StrucDocTd>();

            // *** Add TD's ***

            // *** Date/Time ***
            tdList.Add(new StrucDocTd() { Text = new string[] { dateTime.ToString() } });

            // *** Description ***
            tdList.Add(new StrucDocTd() { Text = new string[] { obs.Code.DisplayName } });

            // *** Value ***
            StrucDocTd td = new StrucDocTd() { Text = new string[] { obs.DisplayValue } };
            td.align = StrucDocTdAlign.center;
            td.alignSpecified = true;
            tdList.Add(td);

            //// *** Is final ***
            //StrucDocTd td1 = new StrucDocTd() { Text = new string[] { (isFinal) ? "YES" : "NO" } };
            //td1.align = StrucDocTdAlign.center;
            //td1.alignSpecified = true;
            //tdList.Add(td1);

            // *** Add td's to tr ***
            tr.Items = tdList.ToArray();

            return tr; 
        }

    }
}
