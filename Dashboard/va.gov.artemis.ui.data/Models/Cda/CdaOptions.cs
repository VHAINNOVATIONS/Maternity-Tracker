// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.CDA;
using VA.Gov.Artemis.UI.Data.Models.Patient;

namespace VA.Gov.Artemis.UI.Data.Models.Cda
{
    public class CdaOptions: PatientRelatedModel
    {
        public static string[] DateRangeDescriptions = new string[] { "All", "Last Year", "Last 6 Months", "Last 3 Months", "Custom" };
        public enum DateRange { All, LastYear, Last6Months, Last3Months, Custom }

        //public BasePatient Patient { get; set; }

        public IheDocumentType DocumentType { get; set; }

        [Display(Name="Recipient First Name")]
        public string IntendedRecipientFirstName { get; set; }
        
        [Display(Name = "Recipient Last Name")]
        public string IntendedRecipientLastName { get; set; }

        [Display(Name = "Recipient Organization Name")]
        public string IntendedRecipientOrganization { get; set; }

        [Display(Name="Date Range")]
        public DateRange SelectedDateRange { get; set; }

        private DateTime customFromDate; 
        private DateTime customToDate;

        [Display(Name="From")]
        public DateTime FromDate
        {
            get
            {
                DateTime returnDate = DateTime.MinValue;

                switch (SelectedDateRange) 
                {
                    case DateRange.All:
                        returnDate = DateTime.MinValue; 
                        break; 
                    case DateRange.Custom:
                        returnDate = this.customFromDate; 
                        break; 
                    case DateRange.LastYear:
                        returnDate = DateTime.Now.Subtract(new TimeSpan(365, 0,0,0));
                        break; 
                    case DateRange.Last6Months:
                        returnDate = DateTime.Now.Subtract(new TimeSpan(183, 0, 0, 0)); 
                        break; 
                    case DateRange.Last3Months:
                        returnDate = DateTime.Now.Subtract(new TimeSpan(91, 0, 0, 0)); 
                        break; 
                }
                return returnDate;
            }
            set
            {
                this.customFromDate = value;
            }
        }

        [Display(Name="To")]
        public DateTime ToDate 
        {
            get 
            {
                DateTime returnDate = DateTime.MinValue;

                switch (this.SelectedDateRange)
                {
                    case DateRange.Custom:
                        returnDate = this.customToDate;
                        break;
                }

                return returnDate; 
            }
            set 
            {
                this.customToDate = value; 
            }
        }

        public string ValidationMessage { get; set; }

        public bool Validate()
        {
            // *** Manual validation of intended recipient ***

            bool returnVal = true;

            this.ValidationMessage = ""; 

            // *** Check for no entry ***
            if (string.IsNullOrWhiteSpace(this.IntendedRecipientOrganization))
                if (string.IsNullOrWhiteSpace(this.IntendedRecipientFirstName))
                    if (string.IsNullOrWhiteSpace(this.IntendedRecipientLastName))
                    {
                        this.ValidationMessage = "Please enter an intended recipient";
                        returnVal = false; 
                    }

            // *** Must have first and last or organization ***
            if (string.IsNullOrWhiteSpace(this.IntendedRecipientFirstName) != string.IsNullOrWhiteSpace(this.IntendedRecipientLastName))
            {
                this.ValidationMessage = "A first and last name must be entered";
                returnVal = false;
            }

            return returnVal; 
        }

        [Display(Name="Selected Item")]
        public string SelectedItemIen { get; set; }

        public Dictionary<CdaOptions.DateRange, string> dateRangeDictionary {get; set; }
        public Dictionary<string, string> SourceTypeDictionary{get; set; }
        public Dictionary<string, string> SelectDictionary {get; set; }

        public CdaOptions()
        {
            this.SelectDictionary = new Dictionary<string, string>();
            this.dateRangeDictionary = new Dictionary<DateRange, string>();
            this.SourceTypeDictionary = new Dictionary<string, string>();

            //this.sourceDictionary.Add("OBNote", "OB H&P Consult");
            this.SourceTypeDictionary.Add("DateRange", "Date Range");

            for (int i = 0; i < CdaOptions.DateRangeDescriptions.Length; i++)
                dateRangeDictionary.Add((DateRange)i, DateRangeDescriptions[i]);
        }

        public string DocumentName
        {
            get
            {
                return CdaUtility.DocumentTypeName[(int)this.DocumentType];
            }
        }

    }
}
