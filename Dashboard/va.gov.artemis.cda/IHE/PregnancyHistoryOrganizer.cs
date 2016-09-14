using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.CDA.Common;
using VA.Gov.Artemis.CDA.Observations;

namespace VA.Gov.Artemis.CDA.IHE
{
    /// <summary>
    /// An organizer which contains information about a single pregnancy
    /// </summary>
    public class PregnancyHistoryOrganizer: CdaOrganizer
    {
        protected override CdaTemplateIdList TemplateIds
        {
            get
            {
                return new CdaTemplateIdList("1.3.6.1.4.1.19376.1.5.3.1.4.13.5.1");
            }
        }

        protected override CdaCode OrganizerCode
        {
            get { return new CdaCode() { Code = "118185001", CodeSystem = CodingSystem.SnomedCT, DisplayName = "Pregnancy Finding" }; }
        }

        // *** Birth event organizers containing baby information ***
        // *** Key is Baby Num ***
        private Dictionary<string, BirthEventOrganizer> BirthEventOrganizers { get; set; }

        public string PregnancyDescription { get; set; }
        
        public PregnancyHistoryOrganizer()
        {
            this.Observations = new List<CdaSimpleObservation>();
            this.BirthEventOrganizers = new Dictionary<string, BirthEventOrganizer>();
            this.EffectiveTime = new CdaEffectiveTime();
            this.ClassCode = x_ActClassDocumentEntryOrganizer.CLUSTER; 
        }

        /// <summary>
        /// Adds some basic pregnancy information to the organizer
        /// </summary>
        /// <param name="startDate">The start date of the pregnancy</param>
        /// <param name="endDate">The delivery or end date of the pregnancy</param>
        /// <param name="description">The pregnancy description</param>
        public void AddPregnancyDetails(DateTime startDate, DateTime endDate, string description)
        {
            this.EffectiveTime = new CdaEffectiveTime() { Low = startDate, High = endDate };
            this.PregnancyDescription = description; 
        }

        /// <summary>
        /// Add baby observations 
        /// </summary>
        /// <param name="babyNum">A unique baby identifier</param>
        /// <param name="obs">The observation to add</param>
        public void AddBabyObservation(string babyNum, CdaSimpleObservation obs)
        {
            if (!this.BirthEventOrganizers.ContainsKey(babyNum))
                this.BirthEventOrganizers.Add(babyNum, new BirthEventOrganizer(){BabyNum = babyNum});

            this.BirthEventOrganizers[babyNum].Observations.Add(obs); 
        }

        protected override List<POCD_MT000040Component4> GetAdditionalComponents()
        {
            List<POCD_MT000040Component4> componentList = new List<POCD_MT000040Component4>(); 

            // *** Add organizers to list ***
            foreach (var org in this.BirthEventOrganizers.Values)
            {
                // *** Create a component ***
                POCD_MT000040Component4 component = new POCD_MT000040Component4();

                // *** Add observation to component ***
                component.Item = org.ToPocdOrganizer();

                // *** Add component to list ***
                componentList.Add(component);
            }

            return componentList; 
        }

        public override List<object> GetAdditionalText()
        {
            List<object> returnList = new List<object>();

            // *** Pregnancy Title ***
            //StrucDocCaption cap = new StrucDocCaption() { Text = new string[] { "Pregnancy #" } };
            //returnList.Add(cap); 

            // *** Pregnancy Observations ***
            StrucDocTable tbl = base.GetEntriesTable();
            if (tbl != null)
            {
                returnList.Add(tbl);

                //List<StrucDocTr> bodyRows = new List<StrucDocTr>(); 
                                
                //// *** Birth Event Organizers ***
                //if (this.BirthEventOrganizers != null)
                //    foreach (var org in this.BirthEventOrganizers.Values)
                //    {
                //        List<object> organizerTextItems = org.GetAdditionalText();

                //        returnList.Add(new StrucDocBr());

                //        if (organizerTextItems != null)
                //            if (organizerTextItems.Count > 0)
                //                returnList.AddRange(organizerTextItems);
                //    }
            }

            return returnList; 
        }

        protected override string Caption
        {
            get { return this.PregnancyDescription; }
        }

        protected override List<StrucDocTr> GetAdditionalRows()
        {
            List<StrucDocTr> returnList = new List<StrucDocTr>();

            // *** Get rows from each Birth Event Organizer ***
            if (this.BirthEventOrganizers != null)
                foreach (var org in this.BirthEventOrganizers.Values)
                    returnList.AddRange(org.GetRows());

            return returnList; 
        }
    }
}
