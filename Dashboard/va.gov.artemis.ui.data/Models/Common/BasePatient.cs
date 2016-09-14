using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.UI.Data.Models.Text4Baby;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.UI.Data.Models.Common
{
    public class BasePatient
    {
        public string Dfn { get; set; }

        [Display(Name = "Last")]
        public string LastName { get; set; }

        [Display(Name = "First")]
        public string FirstName { get; set; }

        [Display(Name = "Last 4")]
        public string Last4 { get; set; }

        [Display(Name = "SSN")]
        public string FullSSN { get; set; }

        public DateTime DateOfBirth { get; set; }
        
        //public string DateOfBirthInexact { get; set; }
        public InexactDate DateOfBirthInexact { get; set; }

        // *** True if no patient or not found ***
        public bool NotFound { get; set; }

        [Display(Name = "DOB")]
        public string FormattedDob
        {
            get
            {
                string returnVal;

                if ((this.DateOfBirth == DateTime.MinValue) && (this.DateOfBirthInexact != null))
                    returnVal = this.DateOfBirthInexact.ToString(); 
                else 
                    returnVal = this.DateOfBirth.ToString(VistaDates.UserDateFormat);

                return returnVal;
            }
        }

        public string Age
        {
            get
            {
                // *** Calculate age based on dob or dob inexact ***

                string returnVal = "";

                DateTime dobToUse = DateTime.MinValue; 
                int tempAge = 0;

                // *** Determine which date to use for calculation ***
                if (this.DateOfBirth != DateTime.MinValue)
                    dobToUse = this.DateOfBirth;
                else if (this.DateOfBirthInexact != null)
                    if (this.DateOfBirthInexact.Approximation != DateTime.MinValue)
                        dobToUse = this.DateOfBirthInexact.Approximation;

                // *** If we have something to use, do calculation ***
                if (dobToUse != DateTime.MinValue)
                {
                    tempAge = DateTime.Now.Year - dobToUse.Year;
                    if (DateTime.Now.DayOfYear < dobToUse.DayOfYear)
                        tempAge -= 1;

                    returnVal = tempAge.ToString();
                }

                return returnVal; 
            }
        }

        public string Name
        {
            get
            {
                return string.Format("{0}, {1}", this.LastName, this.FirstName);
            }
        }

        public string FormattedSSN
        {
            get
            {
                string returnVal = "";

                if (!string.IsNullOrWhiteSpace(this.FullSSN))
                    if (this.FullSSN.Length == 9)
                        returnVal = this.FullSSN.Insert(5, "-").Insert(3, "-");
                    
                if (string.IsNullOrWhiteSpace(returnVal))
                    returnVal = this.FullSSN; 

                return returnVal; 
            }
        }

        public string GravidaPara { get; set; }

        public bool Pregnant { get; set; }

        public DateTime LastLiveBirth { get; set; }

        public bool IsPostPartum
        {
            get
            {
                bool returnVal = false;

                DateTime tempDate;

                if (this.LastLiveBirth != DateTime.MinValue)
                {
                    tempDate = DateTime.Now.AddDays(7 * 12 * -1);

                    if (this.LastLiveBirth.Date >= tempDate)
                        returnVal = true; 
                }
                return returnVal; 
            }
        }

        public string StatusMessage
        {
            get
            {
                string returnVal = "";

                if (this.Pregnant)
                    returnVal = "Pregnant";
                else if (this.IsPostPartum)
                    returnVal = "Postpartum";
                else
                    returnVal = "Not Pregnant";

                if (this.Lactating)
                    returnVal += " / Lactating"; 

                return returnVal;
            }
        }

        public bool Lactating { get; set; }

        public string PostpartumDescription
        {
            get
            {
                string returnVal = "No";

                if (this.IsPostPartum)
                    returnVal = string.Format("Yes: Delivered on {0}", this.LastLiveBirth.ToString(VistaDates.VistADateOnlyFormat));

                return returnVal;
            }
        }

        public string LactatingDescription
        {
            get
            {
                return (this.Lactating) ? "Yes" : "No";
            }
        }

        [Display(Name="Home Phone")]
        public string HomePhone { get; set; }

        [Display(Name = "Work Phone")]
        public string WorkPhone { get; set; }

        [Display(Name = "Mobile Phone")]
        public string MobilePhone { get; set; }
        
        public DateTime LastContactDate { get; set; }
        public DateTime NextContactDue { get; set; }
        public DateTime NextChecklistDue { get; set; }

        [Display(Name="Last Contact")]
        public string LastContactDisplay
        {
            get
            {
                string returnVal = "";

                // TODO: Determine if time is also needed for display...may need vista changes. 

                if (this.LastContactDate != DateTime.MinValue)
                    returnVal = this.LastContactDate.ToString(VistaDates.UserDateFormat);

                return returnVal;
            }
        }

        [Display(Name="Next Contact")]
        public string NextContactDisplay
        {
            get
            {
                string returnVal = "";

                if (this.NextContactDue != DateTime.MinValue)
                    returnVal = this.NextContactDue.ToString(VistaDates.UserDateFormat);

                return returnVal;
            }
        }

        [Display(Name="Next Checklist Due")]
        public string NextChecklistDisplay
        {
            get
            {
                string returnVal = "";

                if (this.NextChecklistDue != DateTime.MinValue)
                    returnVal = this.NextChecklistDue.ToString(VistaDates.UserDateFormat);

                return returnVal;
            }
        }

        public string LastContactDescription
        {
            get
            {
                return (this.LastContactDate == DateTime.MinValue) ? "Unknown" : GetDateDescription(this.LastContactDate);
            }
        }

        public string NextContactDescription
        {
            get
            {
                return (this.NextContactDue == DateTime.MinValue) ? "Unknown" : GetDateDescription(this.NextContactDue);
            }
        }

        public string NextChecklistDescription
        {
            get
            {
                return (this.NextChecklistDue == DateTime.MinValue) ? "Unknown" : GetDateDescription(this.NextChecklistDue);
            }
        }

        private string GetDateDescription(DateTime origDate)
        {
            // *** Imprecise date description ***

            string returnVal = "";

            TimeSpan ts = DateTime.Now.Date.Subtract(origDate.Date);

            string pastFormat = "{0} {1} Ago";
            string futureFormat = "In {0} {1}"; 

            string[] intervals = new string[] {"days", "weeks", "months", "years"};

            if (ts.Days == 0)
                returnVal = "Today";
            else if (ts.Days == 1)
                returnVal = "Yesterday";
            else if (ts.Days == -1)
                returnVal = "Tomorrow";
            else if (ts.Days >= 730)
                returnVal = string.Format(pastFormat, ts.Days / 365, "Years");
            else if (ts.Days >= 60)
                returnVal = string.Format(pastFormat, ts.Days / 30, "Months");
            else if (ts.Days >= 14)
                returnVal = string.Format(pastFormat, ts.Days / 7, "Weeks");
            else if (ts.Days > 1)
                returnVal = string.Format(pastFormat, ts.Days, "Days");
            else if (ts.Days <= -730)
                returnVal = string.Format(futureFormat, Math.Abs(ts.Days / 365), "Years");
            else if (ts.Days <= -60)
                returnVal = string.Format(futureFormat, Math.Abs(ts.Days / 30), "Months");
            else if (ts.Days <= -14)
                returnVal = string.Format(futureFormat, Math.Abs(ts.Days / 7), "Weeks");
            else if (ts.Days < -1)
                returnVal = string.Format(futureFormat, Math.Abs(ts.Days), "Days");

            return returnVal;
        }

        public DateTime Lmp { get; set; }

        public string LmpDisplay
        {
            get
            {
                string returnVal = "";

                if (this.Lmp != DateTime.MinValue)
                    returnVal = this.Lmp.ToString(VistaDates.UserDateFormat);
                else
                    returnVal = "Unknown";

                return returnVal;
            }
        }

        [Display(Name = "High Risk")]
        public bool CurrentPregnancyHighRisk { get; set; }

        public string HighRiskDetails { get; set; }

        public Text4BabyStatus Text4BabyStatus { get; set; }
        
        public DateTime Text4BabyStatusUpdatedOn { get; set; }
        public string Text4BabyParticipantId { get; set; }

        public string ZipCode { get; set; }
        public string Email { get; set; }

        public string Text4BabyEnrollmentDescription
        {
            get
            {
                string returnVal = "";

                switch (this.Text4BabyStatus)
                {
                    case Text4BabyStatus.Unknown:
                        returnVal = "Unknown";
                        break;

                    case Text4BabyStatus.Enrolled:
                        returnVal = string.Format("Enrolled on {0}", this.Text4BabyStatusUpdatedOn.ToString(VistaDates.UserDateFormat));
                        break;

                    case Text4BabyStatus.NotInterested:
                        returnVal = "Not Interested";
                        break;
                }

                return returnVal;
            }
        }
    }       
}
