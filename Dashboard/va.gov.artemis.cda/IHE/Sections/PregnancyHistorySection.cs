using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Xml;
using VA.Gov.Artemis.CDA.Common;
using VA.Gov.Artemis.CDA.Observations;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.CDA.IHE.Sections
{
    /// <summary>
    /// IHE Pregnancy History Section
    /// </summary>
    public class PregnancyHistorySection: CdaSection 
    {
        // *** Section Information *** 
        public override CodingSystem CodeSystem { get { return CodingSystem.Loinc; } }
        public override string CodeSystemName { get { return "LOINC"; } }
        public override string CodeSystemId { get { return "2.16.840.1.113883.6.1"; } }
        public override string Code { get { return "10162-6"; } }
        public override string DisplayName { get { return "History of Pregnancies"; } }
        public override CdaTemplateIdList TemplateIds
        {
            get
            {
                return new CdaTemplateIdList("1.3.6.1.4.1.19376.1.5.3.1.1.5.3.4");
            }
        }

        public override string SectionTitle
        {
            get { return "Pregnancy History"; }
        }

        /// <summary>
        /// List of Observations for the section
        /// </summary>
        public List<CdaSimpleObservation> Observations { get; set; }

        /// <summary>
        /// A separate code observation for the current pregnancy status
        /// </summary>
        public CdaCeObservation PregnancyStatusObservation { get; set; }

        /// <summary>
        /// A list of pregnancy organizers
        /// </summary>
        public Dictionary<string, PregnancyHistoryOrganizer> PregnancyOrganizers { get; set; }

        public PregnancyHistorySection()
        {
            this.Observations = new List<CdaSimpleObservation>();
            this.PregnancyOrganizers = new Dictionary<string, PregnancyHistoryOrganizer>(); 
        }

        /// <summary>
        /// Creates a CDA component containing all required data 
        /// </summary>
        /// <returns>A CDA component</returns>
        public override POCD_MT000040Component3 ToPocdComponent()
        {
            // *** Converts this item to raw component ***

            POCD_MT000040Component3 returnVal = base.ToPocdComponent(); 

            // *** Create a list of entries ***
            List<POCD_MT000040Entry> entryList = new List<POCD_MT000040Entry>();

            // *** Loop through observations ***
            foreach (CdaSimpleObservation observation in this.Observations)
            {
                // *** Create an entry ***
                POCD_MT000040Entry tempEntry = new POCD_MT000040Entry();

                // *** Add a single pregnancy observation ***
                tempEntry.Item = observation.ToPocd(); 

                // *** Add entry to list ***
                entryList.Add(tempEntry);
            }

            // *** Add pregnancy status observation ***
            POCD_MT000040Entry pregEntry = new POCD_MT000040Entry();
            pregEntry.Item = this.PregnancyStatusObservation.ToPocd();
            entryList.Add(pregEntry);

            // *** Add bold to pregnancy status ***
            if (returnVal.section.text.Items != null) 
                if (returnVal.section.text.Items.Length > 0)
                    if (returnVal.section.text.Items[0] is StrucDocParagraph)
                    {
                        StrucDocParagraph para = new StrucDocParagraph(); 

                        StrucDocContent cont = new StrucDocContent() { Text = new string[] { this.Narrative } }; 
                        cont.styleCode = "Bold";

                        para.Items = new object[] { cont }; 

                        returnVal.section.text.Items[0] = para;
                    }

            // *** Add pregnancy organizers ***
            foreach (var pregOrg in this.PregnancyOrganizers.Values)
            {
                POCD_MT000040Entry pocdOrgEntry = pregOrg.ToPocdOrganizerEntry();
                if (pocdOrgEntry != null)
                    entryList.Add(pocdOrgEntry);
            }

            // *** Add entry list as array ***
            returnVal.section.entry = entryList.ToArray();

            return returnVal; 
        }

        protected override StrucDocTable GetEntriesTable()
        {
            // *** Creates a structured document text object from a list of observations ***

            // *** Create the table ***
            StrucDocTable returnVal = null; 

            if (this.Observations.Count > 0)
            {
                returnVal = new StrucDocTable();

                returnVal.caption = new StrucDocCaption() { Text = new string[] { "Pregnancy History Summary" } };

                // *** Create Header information ***
                returnVal.thead = new StrucDocThead();
                returnVal.thead.tr = new StrucDocTr[] { new StrucDocTr() };
                
                returnVal.thead.tr[0].Items = new StrucDocTh[] { 
                    new StrucDocTh() { Text = new string[] { "Date/Time" } },
                    new StrucDocTh() { Text = new string[] { "Description" } },
                    new StrucDocTh() { Text = new string[] { "Number" } }
                    };

                // *** Create Body Information ***
                returnVal.tbody = new StrucDocTbody[] { new StrucDocTbody() };
                List<StrucDocTr> trList = new List<StrucDocTr>();

                // *** Create a Row for each observation ***
                foreach (CdaSimpleObservation obs in this.Observations)
                {
                    // *** Create the row ***
                    StrucDocTr tr = new StrucDocTr() { ID = obs.ReferenceId };

                    // *** Create a list of TD ***
                    List<StrucDocTd> tdList = new List<StrucDocTd>();

                    // *** Add TD's ***
                    tdList.Add(
                        new StrucDocTd()
                        {
                            Text = new string[] { 
                            obs.EffectiveTime.Value.ToString(VistaDates.UserDateTimeFormat)
                        }
                        });

                    tdList.Add(new StrucDocTd() { Text = new string[] { obs.Code.DisplayName } });

                    StrucDocTd td;
                    if (obs is CdaIntObservation)
                    {
                        CdaIntObservation intObs = (CdaIntObservation)obs;
                        td = new StrucDocTd() { Text = new string[] { intObs.Value.ToString() } };
                    }
                    else if (obs is CdaTextObservation)
                    {
                        CdaTextObservation textObs = (CdaTextObservation)obs;
                        td = new StrucDocTd() { Text = new string[] { textObs.Value } };
                    }
                    else
                        td = new StrucDocTd() { Text = new string[] { "" } };

                    td.align = StrucDocTdAlign.center;
                    td.alignSpecified = true;
                    tdList.Add(td);

                    tr.Items = tdList.ToArray();

                    trList.Add(tr);
                }

                // *** Add rows to body ***
                returnVal.tbody[0].tr = trList.ToArray();
            }

            return returnVal;
        }

        /// <summary>
        /// Method to allow adding of baby observation
        /// </summary>
        /// <param name="pregIen">The unique id for the pregnancy</param>
        /// <param name="babyNum">The unique id for the baby</param>
        /// <param name="babyObs">The observation</param>
        public void AddBabyObservation(string pregIen, string babyNum, CdaSimpleObservation babyObs)
        {
            // *** Add the organizer if it does not exist ***
            if (!this.PregnancyOrganizers.ContainsKey(pregIen))
                this.PregnancyOrganizers.Add(pregIen, new PregnancyHistoryOrganizer());

            this.PregnancyOrganizers[pregIen].AddBabyObservation(babyNum, babyObs); 
        }   

        /// <summary>
        /// Method to allow adding of a pregnancy observation
        /// </summary>
        /// <param name="pregIen">The unique id for the pregnancy</param>
        /// <param name="pregObs">The observation</param>
        public void AddPregnancyObservation(string pregIen, CdaSimpleObservation pregObs)
        {
            // *** Add the pregnancy if it does not exist yet ***
            if (!this.PregnancyOrganizers.ContainsKey(pregIen))
                this.PregnancyOrganizers.Add(pregIen, new PregnancyHistoryOrganizer());

            this.PregnancyOrganizers[pregIen].Observations.Add(pregObs); 
        }

        /// <summary>
        /// Add details about the pregnancy 
        /// </summary>
        /// <param name="pregIen">The unique pregnancy id</param>
        /// <param name="startDate">The start date of the pregnancy</param>
        /// <param name="endDate">The delivery or end date of the pregnancy</param>
        /// <param name="description">The description of the pregnancy</param>
        public void AddPregnancyDetails(string pregIen, DateTime startDate, DateTime endDate, string description)
        {
            // *** Add pregnancy if it does not exist ***
            if (!this.PregnancyOrganizers.ContainsKey(pregIen))
                this.PregnancyOrganizers.Add(pregIen, new PregnancyHistoryOrganizer());

            this.PregnancyOrganizers[pregIen].AddPregnancyDetails(startDate, endDate, description); 
        }

        protected override List<object> GetAdditionalText()
        {
            // *** Gets any additional text objects needed for this section ***

            List<object> returnList = new List<object>();

            if (this.PregnancyOrganizers != null)
            {
                // *** Sort ***
                List<PregnancyHistoryOrganizer> sortedList = this.PregnancyOrganizers.Values.ToList();

                sortedList.Sort(delegate(PregnancyHistoryOrganizer x, PregnancyHistoryOrganizer y)
                {
                    DateTime dtX = (x.EffectiveTime.High == DateTime.MinValue) ? DateTime.MaxValue : x.EffectiveTime.High;
                    DateTime dtY = (y.EffectiveTime.High == DateTime.MinValue) ? DateTime.MaxValue : y.EffectiveTime.High;

                    return dtY.CompareTo(dtX); 
                });

                // *** Go through each organizer and get the text required ***
                foreach (var item in sortedList)
                {
                    returnList.Add(new StrucDocBr());
                    List<object> adds = item.GetAdditionalText();
                    if (adds != null)
                        if (adds.Count > 0)
                            returnList.AddRange(adds);
                }
            }

            return returnList; 
        }

    }
}
