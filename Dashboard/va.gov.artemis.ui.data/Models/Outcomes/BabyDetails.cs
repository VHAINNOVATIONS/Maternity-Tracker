// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.CDA.Common;
using VA.Gov.Artemis.Commands.Dsio.Observation;
using VA.Gov.Artemis.UI.Data.Models.Observations;

namespace VA.Gov.Artemis.UI.Data.Models.Outcomes
{
    public class BabyDetails : ObservationConstructable
    {
        // *** Internal storage for birth weight in grams ***
        private string birthWeightGrams;

        [SkipObservation]
        public string Ien { get; set; }

        [SkipObservation]
        public string BabyNum { get; set; }

        [SkipObservation]
        public string BabyDescription
        {
            get
            {
                return BabyUtilities.GetBabyDescription(this.BabyNum); 
            }
        }

        [CdaCodingInfo(CodeSystem = CodingSystem.Loinc, Code = "45392-8", DisplayName="First Name")]
        public string FirstName { get; set; }

        [CdaCodingInfo(CodeSystem = CodingSystem.Loinc, Code = "46098-0", DisplayName = "Sex")]
        public Hl7Gender Gender { get; set; }

        [CdaCodingInfo(CodeSystem = CodingSystem.Loinc, Code = "8339-4", DisplayName = "Birth Weight")]
        public string BirthWeight 
        {
            get
            {  
                // *** If entered in pounds ounces, calculate grams ***
                if (this.EntryInPoundsOunces)
                    this.birthWeightGrams = GetGramsFromEnteredLbsOz(); 
                 
                return birthWeightGrams; 
            }
            set { this.birthWeightGrams = value; }
        }

        private string GetGramsFromEnteredLbsOz()
        {
            string returnVal = "";

            int tot = -1;

            // *** Get ounces from pounds ***
            int lbs = -1;
            if (int.TryParse(this.EntryWeightPounds, out lbs))
                tot = lbs * 16;

            // *** Get ounces entered ***
            int oz = -1;
            if (int.TryParse(this.EntryWeightOunces, out oz))
                tot += oz;

            if (tot > -1)
            {
                // *** Convert ounces to grams ***
                int grams = (int)Math.Round(tot / .03527396);

                returnVal = grams.ToString();
            }

            return returnVal; 
        }

        [SkipObservation]
        public string DisplayWeight
        {
            get
            {
                return BabyUtilities.GetBabyDisplayWeight(this.BirthWeight); 
            }
        }

        [SkipObservation]
        public bool EntryInPoundsOunces { get; set; }

        [SkipObservation]
        public string EntryWeightPounds {get; set; }

        [SkipObservation]
        public string EntryWeightOunces { get; set; }

        [CdaCodingInfo(CodeSystem = CodingSystem.Loinc, Code = "9272-6", DisplayName = "One Minute APGAR")]        
        public string OneMinuteApgar { get; set; }

        [CdaCodingInfo(CodeSystem = CodingSystem.Loinc, Code = "9274-2", DisplayName = "Five Minute APGAR")]
        public string FiveMinuteApgar { get; set; }
              
        // TODO: Find code for complications narrative or separate into coded problems/diagnoses
        [IsNarrative]
        public string Complications { get; set; }

        // TODO: No code found.  Can use code 32417-8 for admittance dx code
        public bool AdmittedToIcu { get; set; }

        [IsNarrative]
        [CdaCodingInfo(CodeSystem = CodingSystem.Loinc, Code = "57075-4", DisplayName = "Newborn Delivery Information")]
        public string Notes { get; set; }

        public BabyDetails() : base() { }

        public BabyDetails(List<Observation> list) : base(list) 
        {
            // *** Makes assumption that all baby iens/numbers are the same ***

            if (list != null)
                if (list.Count > 0)
                {
                    this.Ien = list[0].BabyIen;
                    this.BabyNum = list[0].BabyNumber = list[0].BabyNumber;
                }
        }

        protected override void Construct(List<Observation> list)
        {
            this.PopulateProperties(this, list);

            //if (!string.IsNullOrWhiteSpace(this.Notes))
            //    if (this.Notes.Contains("|"))
            //        this.Notes = this.Notes.Replace("|", Environment.NewLine);
        }

        public override List<Observation> GetObservations(string patientDfn, string pregnancyIen, string babyIen)
        {
            //if (!string.IsNullOrWhiteSpace(this.Notes))
            //    if (this.Notes.Contains(Environment.NewLine))
            //        this.Notes = this.Notes.Replace(Environment.NewLine, "|");

            return base.GetObservations(this, patientDfn, pregnancyIen, babyIen);
        }

        public override string ObservationCategory { get { return "BabyDetails"; } }

        //[IsNarrative]
        //[CdaCodingInfo(CodeSystem = CodingSystem.Loinc, Code = "57075-4", DisplayName = "Newborn Delivery Information")]
        //public string DeliveryInfo { get; set; }

        [IsNarrative]
        [CdaCodingInfo(CodeSystem = CodingSystem.Loinc, Code = "29545-1", DisplayName = "Physical Findings")]
        public string PhysicalExam { get; set; }

        [IsNarrative]
        [CdaCodingInfo(CodeSystem = CodingSystem.Loinc, Code = "9554-3", DisplayName = "Procedure Narrative")]
        public string Procedures { get; set; }

        [CdaCodingInfo(CodeSystem = CodingSystem.SnomedCT, Code = "72310004", DisplayName = "Circumcision")]
        public bool Circumcision { get; set; }

        [IsNarrative]
        [CdaCodingInfo(CodeSystem = CodingSystem.Loinc, Code = "57077-0", DisplayName = "Newborn Status at Maternal Discharge")]
        public string StatusAtMaternalDischarge { get; set; }

        [IsNarrative]
        [CdaCodingInfo(CodeSystem = CodingSystem.Loinc, Code = "61145-9", DisplayName = "Care Plan")]
        public string CarePlan { get; set; }

        [CdaCodingInfo(CodeSystem = CodingSystem.Loinc, Code = "18711-2", DisplayName = "Primary Practitioner Name")]
        public string Pediatrician { get; set; }

    }
}
