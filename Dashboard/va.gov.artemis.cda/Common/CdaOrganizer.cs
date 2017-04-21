// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.CDA.Observations;

namespace VA.Gov.Artemis.CDA.Common
{
    /// <summary>
    /// An base organizer to be used within the CDA document
    /// </summary>
    public abstract class CdaOrganizer
    {
        // *** Basic properties that all have ***
        public x_ActClassDocumentEntryOrganizer ClassCode { get; set; }
        public CdaEffectiveTime EffectiveTime { get; set; }
        public List<CdaSimpleObservation> Observations { get; set; }

        // *** Abstract properties and methods that need to be implemented ***
        protected abstract CdaTemplateIdList TemplateIds { get; }
        protected abstract CdaCode OrganizerCode { get; }
        protected abstract List<POCD_MT000040Component4> GetAdditionalComponents();
        public abstract List<object> GetAdditionalText();
        protected abstract string Caption { get; }
        
        public CdaOrganizer()
        {
            this.Observations = new List<CdaSimpleObservation>();
            this.EffectiveTime = new CdaEffectiveTime(); 
        }

        /// <summary>
        /// Generates an entry containing the organizer
        /// </summary>
        /// <returns>A CDA entry object</returns>
        public virtual POCD_MT000040Entry ToPocdOrganizerEntry()
        {
            // *** Create an entry ***
            POCD_MT000040Entry newEntry = new POCD_MT000040Entry();

            // *** Create organizer ***
            POCD_MT000040Organizer organizer = this.ToPocdOrganizer();

            // ***  Add it to entry ***
            if (organizer != null)
                newEntry.Item = organizer; 

            return newEntry;  
        }

        /// <summary>
        /// Generates the organizer (without an entry)
        /// </summary>
        /// <returns>A CDA organizer object</returns>
        public virtual POCD_MT000040Organizer ToPocdOrganizer() 
        {
            // *** Create organizer ***
            POCD_MT000040Organizer organizer = new POCD_MT000040Organizer();

            // *** Set the organizer attributes ***
            organizer.classCode = this.ClassCode;
            organizer.moodCode = "EVN";

            // *** Template Id's ***
            organizer.templateId = this.TemplateIds.ToPocd(); 

            // *** Organizer Code ***
            organizer.code = this.OrganizerCode.ToCD();

            // *** Organizer shall have id ***
            organizer.id = new II[] { new II() { root = Guid.NewGuid().ToString() } };

            organizer.statusCode = new CS() { code = "completed" };

            // *** Start/End of pregnancy ***
            organizer.effectiveTime = this.EffectiveTime.ToIvlTs();

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

            // *** Get any additional components that the organizer may need ***
            List<POCD_MT000040Component4> additional = this.GetAdditionalComponents();

            // *** Add them if they exist ***
            if (additional != null)
                if (additional.Count > 0)
                    componentList.AddRange(additional); 

            // *** Add component array to organizer ***
            organizer.component = componentList.ToArray();

            return organizer; 
        }

        /// <summary>
        /// Creates a table based on observations ***
        /// </summary>
        /// <returns>A StrucDocTable</returns>
        protected virtual StrucDocTable GetEntriesTable()
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
                    new StrucDocTh() { Text = new string[] { "Description" } },
                    new StrucDocTh() { Text = new string[] { "Value" } },
                    new StrucDocTh() { Text = new string[] { "Comment" } },
                };

                // *** Create Body Information ***
                returnTable.tbody = new StrucDocTbody[] { new StrucDocTbody() };
                List<StrucDocTr> trList = new List<StrucDocTr>();

                // *** Sort list to put positives first ***
                this.Observations.Sort(delegate(CdaSimpleObservation x, CdaSimpleObservation y)
                {
                    return x.NegationIndicator.CompareTo(y.NegationIndicator);
                });

                // *** Create a Row for each observation ***
                foreach (CdaSimpleObservation obs in this.Observations)
                {
                    // *** Create the row ***
                    StrucDocTr tr = new StrucDocTr() { ID = obs.ReferenceId };

                    // *** Create a list of TD ***
                    List<StrucDocTd> tdList = new List<StrucDocTd>();

                    // *** Add TD's ***
                    tdList.Add(new StrucDocTd() { Text = new string[] { obs.Code.DisplayName } });

                    StrucDocTd td = new StrucDocTd() { Text = new string[] { obs.DisplayValue } };
                    tdList.Add(td);

                    tdList.Add(new StrucDocTd() { Text = new string[] { obs.Comment } });

                    tr.Items = tdList.ToArray();

                    trList.Add(tr);
                }

                // *** Get additional rows needed by parent ***
                List<StrucDocTr> additionalRows =  this.GetAdditionalRows();
                if (additionalRows != null)
                    trList.AddRange(additionalRows); 

                // *** Add rows to body ***
                returnTable.tbody[0].tr = trList.ToArray();

                returnTable.caption = new StrucDocCaption() { Text = new string[] { this.Caption } };
            }

            return returnTable;
        }

        /// <summary>
        /// Gets the rows only for this organizer.  Override in derived class to implement additional rows
        /// </summary>
        /// <returns>A list of StrucDocTr rows</returns>
        protected virtual List<StrucDocTr> GetAdditionalRows()
        {
            return null;
        }

    }
}
