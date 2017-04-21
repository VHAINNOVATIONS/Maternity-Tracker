// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

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
    /// An organizer specific to a birth event (baby)
    /// </summary>
    public class BirthEventOrganizer: CdaOrganizer
    {        
        public string BabyNum { get; set; }

        protected override CdaTemplateIdList TemplateIds
        {
            get { return new CdaTemplateIdList("1.3.6.1.4.1.19376.1.5.3.1.4.13.5.2"); }
        }

        protected override CdaCode OrganizerCode
        {
            get { return new CdaCode() { CodeSystem = CodingSystem.SnomedCT, Code = "118215003", DisplayName = "Delivery Finding" }; }
        }

        protected override List<POCD_MT000040Component4> GetAdditionalComponents()
        {
            // *** No additional components needed ***
            return new List<POCD_MT000040Component4>(); 
        }

        /// <summary>
        /// Creates the organizer
        /// </summary>
        /// <returns>A CDA birth event organizer</returns>
        public override POCD_MT000040Organizer ToPocdOrganizer()
        {
            POCD_MT000040Organizer returnVal = base.ToPocdOrganizer();

            // *** Create subject from observations ***
            CdaSubject babySubject = this.CreateBabySubject();

            returnVal.subject = babySubject.ToPocdSubject(); 

            return returnVal; 
        }

        private CdaSubject CreateBabySubject()
        {
            // *** Create the subject of the section for the baby ***

            CdaSubject returnVal = new CdaSubject();

            if (this.Observations != null)
                foreach (var obs in this.Observations)
                {
                    switch (obs.Code.Code)
                    {
                        case "46098-0": // Sex 
                            CdaTextObservation tempObservation = obs as CdaTextObservation;
                            CdaGender gender = new CdaGender(obs.DisplayValue);
                            returnVal.Gender = gender.Value;  
                            break;
                        case "45392-8": // First Name
                            returnVal.FirstName = obs.DisplayValue;  
                            break;
                        case "21112-8": // Birth Date + Time
                            CdaDateObservation dateObs = obs as CdaDateObservation;
                            returnVal.BirthTime = dateObs.Value; 
                            break; 
                    }
                }

            return returnVal; 
        }

        public override List<object> GetAdditionalText()
        {
            return null; 
        }

        protected override string Caption
        {
            get { return this.GetBabyDescription(this.BabyNum);}
        }

        private string GetBabyDescription(string babyNum)
        {
            // *** Uses Baby X format for baby ***

            string returnVal = "Baby";

            string[] babyId = { "A", "B", "C", "D", "E", "F", "G", "H", "I" };

            int babyIdx = -1;
            if (int.TryParse(babyNum, out babyIdx))
                if (babyIdx > 0)
                    if (babyIdx < 10)
                        returnVal = string.Format("Baby {0}", babyId[babyIdx - 1]);

            return returnVal;
        }

        /// <summary>
        /// Gets a list of rows to add to an existing table 
        /// </summary>
        /// <returns>A list of StrucDocTr objects</returns>
        public List<StrucDocTr> GetRows()
        {
            List<StrucDocTr> returnList = new List<StrucDocTr>();

            // *** Check that there are observations ***
            if (this.Observations.Count > 0)
            {
                // *** Create a "header" which will be inside rows of table ***
                StrucDocTr headerRow = new StrucDocTr();
                headerRow.Items = new StrucDocTh[] { new StrucDocTh() { Text = new string[] { this.Caption }, colspan = "3" } };
                returnList.Add(headerRow);

                //// *** Sort list to put positives first ***
                //this.Observations.Sort(delegate(CdaSimpleObservation x, CdaSimpleObservation y)
                //{
                //    return x.NegationIndicator.CompareTo(y.NegationIndicator);
                //});

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

                    // *** Add TD's to list ***
                    tr.Items = tdList.ToArray();

                    // *** Add row to return ***
                    returnList.Add(tr);
                }

            }

            return returnList;
        }
    }
}
