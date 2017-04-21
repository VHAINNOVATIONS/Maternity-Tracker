// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.UI.Data.Models.Patient;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.UI.Data.Models.Pregnancy
{
    public class PregnancyDetails
    {
        public PregnancyDetails()
        {
            this.PlannedLaborDeliveryFacility = "Unknown";
            this.FatherOfFetus = "Unknown";
            this.Obstetrician = "Unknown";
            this.Babies = new List<Baby>(); 
        }

        public string Ien { get; set; }
        public string PatientDfn { get; set; }

        [Display(Name = "Type")]
        public PregnancyRecordType RecordType { get; set; }

        [Display(Name = "Father of Baby")]
        public string FatherOfFetus { get; set; }
                
        public string FatherOfFetusIen { get; set; }

        public DateTime EDD {get; set; }

        // *** EDD Basis for above EDD ***
        public string EddBasis { get; set; }

        // *** EDD Is Final for above EDD ***
        public Nullable<bool> EddIsFinal { get; set; }
        public string EddIsFinalDisplay
        {
            get
            {
                string returnVal = "";

                if (this.EddIsFinal.HasValue)
                    returnVal = (this.EddIsFinal.Value) ? "Yes" : "No";

                return returnVal;
            }
        }

        [Display(Name = "Estimated Delivery Date")]
        public string DisplayEdd
        {
            get
            {
                string returnVal = "";

                if (this.EDD == DateTime.MinValue)
                    returnVal = "Unknown";
                else
                    returnVal = this.EDD.ToString(VistaDates.UserDateFormat); 

                return returnVal;
            }
            set
            {
                string temp = VistaDates.StandardizeDateFormat(value);

                if (!string.IsNullOrWhiteSpace(temp))
                    this.EDD = VistaDates.ParseDateString(temp, VistaDates.VistADateOnlyFormat);
            }
        }

        public string EditableEdd
        {
            get
            {
                string returnVal = "";

                if (this.EDD != DateTime.MinValue)
                    returnVal = this.DisplayEdd;

                return returnVal;
            }
            set
            {
                this.DisplayEdd = value;
            }
        }

        [Display(Name = "Start Date")]
        public DateTime StartDate { get; set; }

        [Display(Name = "Outcome Date")]
        public DateTime EndDate { get; set; }

        public string Obstetrician { get; set; }
        public string ObstetricianIen { get; set; }

        [Display(Name = "Labor & Delivery Facility")]
        public string PlannedLaborDeliveryFacility { get; set; }
        public string PlannedLaborDeliveryFacilityIen { get; set; }

        [Display(Name = "Gestational Age")]
        public string GestationalAge
        {
            get
            {
                string returnVal = "";

                if (this.EDD != DateTime.MinValue)
                {
                    int ga = this.GestationalAgeInDays;

                    if (ga <= 42 * 7)
                    {
                        int wholeWeeks = (int)ga / 7;
                        int remainderDays = ga % 7;

                        returnVal = string.Format("{0} weeks {1} days", wholeWeeks, remainderDays);
                    }
                    else
                        returnVal = "N/A";
                }
                else
                    returnVal = "Unknown"; 

                return returnVal;
            }
        }
        
        public string Trimester
        {
            get
            {
                string returnVal = "";

                if (this.EDD != DateTime.MinValue)
                {
                    int ga = this.GestationalAgeInDays;

                    if (ga > 42 * 7)
                        returnVal = "N/A";
                    else
                    {
                        if (this.GestationalAgeInDays <= (14 * 7))
                            returnVal = "1st";
                        else if (this.GestationalAgeInDays <= (28 * 7))
                            returnVal = "2nd";
                        else
                            returnVal = "3rd";
                    }
                }
                else
                    returnVal = "Unknown"; 

                return returnVal;
            }
        }

        private int GestationalAgeInDays
        {
            get
            {
                return this.GetGestationAgeInDays(DateTime.Now); 
            }
        }

        [Display(Name = "Start Date")]
        public string DisplayStartDate
        {
            get
            {
                string returnVal = "";

                if (this.StartDate != DateTime.MinValue)
                    returnVal = this.StartDate.ToString(VistaDates.UserDateFormat);
                else
                    returnVal = "Unknown";

                return returnVal;
            }
            set
            {
                string temp = VistaDates.StandardizeDateFormat(value);

                if (!string.IsNullOrWhiteSpace(temp))
                    this.StartDate = VistaDates.ParseDateString(temp, VistaDates.VistADateOnlyFormat);
            }
        }

        [Display(Name = "Delivery (or other outcome) Date")]
        public string DisplayEndDate
        {
            get
            {
                string returnVal = "";

                if (this.EndDate != DateTime.MinValue)
                    returnVal = this.EndDate.ToString(VistaDates.UserDateFormat);

                return returnVal;
            }
            set
            {
                string temp = VistaDates.StandardizeDateFormat(value);

                if (!string.IsNullOrWhiteSpace(temp))
                    this.EndDate = VistaDates.ParseDateString(temp, VistaDates.VistADateOnlyFormat);
            }
        }

        public ClinicalDateType LmpDateType { get; set; }

        public string Lmp { get; set; }

        public string LmpDisplay
        {
            get
            {
                return (string.IsNullOrWhiteSpace(this.Lmp)) ? "Unknown" : this.Lmp;
            }
        }

        //public string LmpEdit
        //{
        //    get
        //    {
        //        string returnVal = "";

        //        if (this.Lmp != DateTime.MinValue)
        //            returnVal = this.Lmp.ToString(VistaDates.UserDateFormat);

        //        return returnVal;
        //    }
        //    set
        //    {
        //        string temp = VistaDates.StandardizeDateFormat(value);

        //        if (!string.IsNullOrWhiteSpace(temp))
        //            this.EndDate = VistaDates.ParseDateString(temp, VistaDates.VistADateOnlyFormat);
        //    }
        //}

        public int FetusBabyCount { get; set; }

        public string MultiplePregnancyDescription
        {
            get
            {
                string returnVal;

                if (this.FetusBabyCount < 1)
                    returnVal = "Unknown";
                else if (this.FetusBabyCount == 1)
                    returnVal = "No - Singleton";
                else
                    returnVal = "Yes - " + FetusBabyCount.ToString();

                return returnVal;
            }
        }

        public string Description
        {
            get
            {
                string returnVal = "";

                if (this.RecordType == PregnancyRecordType.Current)
                    returnVal = string.Format("Current Pregnancy (Due {0})", this.DisplayEdd);
                else
                {
                    string endDate = (string.IsNullOrWhiteSpace(this.DisplayEndDate)) ? "Unknown" : this.DisplayEndDate; 
                    returnVal = string.Format("Past Pregnancy ({0} - {1})", this.DisplayStartDate, endDate);
                }
                return returnVal;
            }
        }

        public List<Baby> Babies { get; set; }

        public string GetGestationalAgeOn(DateTime dateTime)
        {
            string returnVal = "";

            if (this.EDD != DateTime.MinValue)
            {
                int ga = GetGestationAgeInDays(dateTime);

                if (ga <= 42 * 7)
                {
                    int wholeWeeks = (int)ga / 7;
                    int remainderDays = ga % 7;

                    returnVal = string.Format("{0} weeks {1} days", wholeWeeks, remainderDays);
                }
            }            

            return returnVal; 
        }

        private int GetGestationAgeInDays(DateTime on)
        {
            int returnVal = -1;
            
            // *** Count number of days until EDD ***
            TimeSpan difference = this.EDD.Subtract(on);
            int daysUntilEdd = (int)difference.TotalDays + 1;

            // *** 40 Weeks * 7 days/week = total pregnancy days - days left ***
            returnVal = 40 * 7 - daysUntilEdd;

            return returnVal;
        }

        public bool HighRisk { get; set; }
        public string HighRiskDetails { get; set; }

        public DateTime Created { get; set; }

        public string GestationalAgeAtDelivery { get; set; }
        public string LengthOfLabor { get; set; }
        public string TypeOfDelivery { get; set; }
        public string Anesthesia { get; set; }
        public string PretermDelivery { get; set; }
        public string Outcome { get; set; }
        public string Comment { get; set; }
    }
}
