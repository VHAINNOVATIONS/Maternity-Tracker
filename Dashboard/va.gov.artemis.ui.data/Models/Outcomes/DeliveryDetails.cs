// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.CDA.Common;
using VA.Gov.Artemis.Commands.Dsio.Observation;
using VA.Gov.Artemis.UI.Data.Models.Observations;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.UI.Data.Models.Outcomes
{
    //•	Normal spontaneous vaginal delivery (NSVD)
    //•	Forcep or vacuum delivery
    //•	Failed forcep or vacuum delivery
    //•	Cesarean delivery
    //•	Other

    public class DeliveryDetails : ObservationConstructable
    {
        private const string nsvd = "Normal Spontaneous Vaginal Delivery (NSVD)";
        private const string forcep = "Forcep or Vacuum Delivery";
        private const string failedForcep = "Failed Forcep or Vacuum Delivery";
        private const string cesarean = "Cesarean Delivery";
        private const string vaginal = "Vaginal Delivery";
        private const string other = "Other";

        private int gestationalAgeWeeks;
        private int gestationalAgeDays; 

        // *** Don't need observation ***
        [SkipObservation]
        public int GestationalAgeWeeks
        {
            get
            {
                return gestationalAgeWeeks;
            }
            set
            {
                this.gestationalAgeWeeks = value;
                this.gestationalAge = (this.gestationalAgeWeeks * 7 + this.gestationalAgeDays).ToString();
            }
        }

        [SkipObservation]
        public int GestationalAgeDays
        {
            get
            {
                return gestationalAgeDays;
            }
            set
            {
                this.gestationalAgeDays = value;
                this.gestationalAge = (this.gestationalAgeWeeks * 7 + this.gestationalAgeDays).ToString();
            }
        }

        [SkipObservation]
        public string GestationalAgeDescription
        {
            get
            {
                string returnVal = "Unknown";
                if ((this.gestationalAgeDays > 0) || (this.gestationalAgeWeeks > 0))
                    if (this.gestationalAgeDays >= 0 && this.gestationalAgeDays <= 6)
                        if (this.gestationalAgeWeeks >= 0 && this.gestationalAgeWeeks <= 50)
                            returnVal = string.Format("{0}w {1}d", this.gestationalAgeWeeks, this.gestationalAgeDays);

                return returnVal;
            }
        }

        // *** Delivery Method ***
        public bool NormalSpontaneousVaginalDelivery { get; set; }
        public bool ForcepVacuumDelivery { get; set; }
        public bool FailedForcepVacuumDelivery { get; set; }
        public bool CesareanDelivery { get; set; }
        public bool VaginalDelivery { get; set; }
        public bool OtherDelivery { get; set; }

        [IsNarrative]
        public string OtherDeliveryDetails { get; set; }

        public bool BottleFeeding { get; set; }
        public bool BreastFeeding { get; set; }
        public bool FormulaFeeding { get; set; }

        public string DaysInHospital { get; set; }

        [IsNarrative]
        [CdaCodingInfo(CodeSystem = CodingSystem.SnomedCT, Code = "198609003", DisplayName = "Complication of pregnancy, childbirth and/or the puerperium")]
        public string PostPartumComplications { get; set; }

        [IsNarrative]
        public string Notes { get; set; }

        public List<BabyDetails> Babies { get; set; }

        public DeliveryDetails() : base() { }

        public DeliveryDetails(List<Observation> list) : base(list) { }

        protected override void Construct(List<Observation> list)
        {
            this.PopulateProperties(this, list);
        }

        public override List<Observation> GetObservations(string patientDfn, string pregnancyIen, string babyIen)
        {
            return base.GetObservations(this, patientDfn, pregnancyIen, babyIen);
        }

        public override string ObservationCategory { get { return "DeliveryDetails"; } }

        public List<string> GetDeliveryTypeDescription()
        {
            List<string> returnList = new List<string>(); 

            if (this.NormalSpontaneousVaginalDelivery)
                returnList.Add(nsvd);

            if (this.ForcepVacuumDelivery)
                returnList.Add(forcep); 

            if (this.FailedForcepVacuumDelivery)
                returnList.Add(failedForcep);

            if (this.CesareanDelivery)
                returnList.Add(cesarean);

            if (this.VaginalDelivery)
                returnList.Add(vaginal);

            if (this.OtherDelivery)
                returnList.Add(other);

            return returnList; 
        }

        public static string GetDeliveryTypeDescription(string propName)
        {
            string returnVal = "";

            switch (propName)
            {
                case "NormalSpontaneousVaginalDelivery":
                    returnVal = nsvd; 
                    break; 
                case "ForcepVacuumDelivery":
                    returnVal = forcep; 
                    break;
                case "FailedForcepVacuumDelivery":
                    returnVal = failedForcep; 
                    break;
                case "CesareanDelivery":
                    returnVal = cesarean; 
                    break;
                case "VaginalDelivery":
                    returnVal = vaginal;
                    break;
                case "OtherDelivery":
                    returnVal = other; 
                    break;
            }

            return returnVal; 
        }

        [CdaCodingInfo(CodeSystem = CodingSystem.Loinc, Code = "57071-3", DisplayName = "Obstetric Delivery Method")]
        public string ObstetricDeliveryMethod
        {
            get
            {
                string returnVal = "";

                List<string> tempList = this.GetDeliveryTypeDescription();

                if (tempList != null)
                    returnVal = string.Join(", ", tempList.ToArray());                

                return returnVal; 
            }
            set { }        
        }

        private string gestationalAge;

        [CdaCodingInfo(CodeSystem = CodingSystem.SnomedCT, Code = "412726003", DisplayName = "Gestational Age at Birth")]
        public string GestationalAge
        {
            get
            {
                return gestationalAge;
            }
            set
            {
                int totalDays = -1;
                if (int.TryParse(value, out totalDays))
                {
                    gestationalAge = value;
                    this.gestationalAgeWeeks = (int)totalDays / 7; 
                    this.gestationalAgeDays = totalDays % 7; 
                }
                else
                    gestationalAge = ""; 
            }
        }

        // Other...

        // *** Mother Discharge Date 46503-9 ***
        [CdaCodingInfo(CodeSystem = CodingSystem.Loinc, Code = "46503-9", DisplayName = "Mother Discharge Date")]
        public string MotherDischargeDate { get; set; }

        [SkipObservation]
        public string DisplayMotherDischargeDate
        {
            get
            {
                return this.MotherDischargeDate; 
            }
            set
            {
                string temp = VistaDates.StandardizeDateFormat(value);

                if (!string.IsNullOrWhiteSpace(temp))
                    this.MotherDischargeDate = temp; 
            }
        }

        // *** Delivery Hospital 62330-6 ***
        [CdaCodingInfo(CodeSystem = CodingSystem.Loinc, Code = "62330-6", DisplayName = "Delivery Hospital")]
        public string DeliveryHospital { get; set; }

        // *** Delivery Provider ***
        [CdaCodingInfo(CodeSystem = CodingSystem.Loinc, Code = "52526-1", DisplayName = "Attending Physician Name")]
        public string DeliveryProvider { get; set; }

        // Delivery..
        // *** Type of cesarean incision ***
        // NOTE: Include as narrative...
        [CdaCodingInfo(CodeSystem = CodingSystem.SnomedCT, Code = "11466000", DisplayName = "Cesarean Delivery")]
        public string CesareanIncisionType { get; set; }

        // Treatment...

        // *** Hospitalization Tx 57076-2 ***
        [IsNarrative]
        [CdaCodingInfo(CodeSystem = CodingSystem.Loinc, Code = "57076-2", DisplayName = "Postpartum Hospitalization Treatment")]
        [Display(Name = "Postpartum Hospitalization Treatment")]
        public string PpHospitalTreatment { get; set; }

        // *** Hospitalization Tx: Procedures 29554-3 ***
        [IsNarrative]
        [CdaCodingInfo(CodeSystem = CodingSystem.Loinc, Code = "29554-3", DisplayName = "Postpartum Hospitalization Procedures")]
        [Display(Name = "Postpartum Hospitalization Procedures")]
        public string PpHospitalProcedures { get; set; }

        // *** Hospitalization Tx: Discharge Diet 42344-2 ***
        [IsNarrative]
        [CdaCodingInfo(CodeSystem = CodingSystem.Loinc, Code = "42344-2", DisplayName = "Postpartum Hospitalization Discharge Diet")]
        [Display(Name = "Postpartum Hospitalization Discharge Diet")]
        public string PpHospitalDischargeDiet { get; set; }

        // Postpartum...
        // *** Social - Depression Screening (428221000124108) ***
        [IsNarrative]
        [CdaCodingInfo(CodeSystem = CodingSystem.SnomedCT, Code = "428221000124108", DisplayName = "Postpartum Depression Screening")]
        public string PpDepressionScreening { get; set; }

        // *** Social - IPV (706892001) ***
        [IsNarrative]
        [CdaCodingInfo(CodeSystem = CodingSystem.SnomedCT, Code = "706892001", DisplayName = "Risk of Intimate Partner Violence")]

        public string PpIpv { get; set; }

        // *** Care Plan 61145-9 ***
        [IsNarrative]
        [CdaCodingInfo(CodeSystem = CodingSystem.Loinc, Code = "61145-9", DisplayName = "Plan of Care")]
        [Display(Name = "Postpartum Hosptial Care Plan")]
        public string CarePlan { get; set; }
        
    }
}
