using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.CDA.Common;
using VA.Gov.Artemis.UI.Data.Models.Outcomes;
using VA.Gov.Artemis.UI.Data.Models.Patient;

namespace VA.Gov.Artemis.UI.Data.Models.Pregnancy
{
    public class BabyAddEdit: PatientRelatedModel
    {
        public string PregnancyIen { get; set; }

        public string ValidationMessage { get; set; }

        public BabyDetails Details { get; set; }

        public Dictionary<Hl7Gender, string> GenderList
        {
            get
            {
                Dictionary<Hl7Gender, string> returnList = new Dictionary<Hl7Gender, string>();

                returnList.Add(Hl7Gender.Unknown, "Unknown");
                returnList.Add(Hl7Gender.Female, "Female");
                returnList.Add(Hl7Gender.Male, "Male");

                return returnList; 
            }
        }

        public BabyAddEdit()
        {
            this.Details = new BabyDetails(); 
        }

        public bool IsValid()
        {
            bool returnVal = true;

            const string InvalidApgarMessage = "Please enter a valid APGAR score between 0 and 10";
            const string InvalidWeightMessage = "Please enter a valid weight"; 

            this.ValidationMessage = "";

            returnVal = IsValidIntegerInRange(this.Details.OneMinuteApgar, 0, 10);

            if (!returnVal)
                this.ValidationMessage = InvalidApgarMessage;
            else
            {
                returnVal = IsValidIntegerInRange(this.Details.FiveMinuteApgar, 0, 10);
                if (!returnVal)
                    this.ValidationMessage = InvalidApgarMessage;
            }

            if (returnVal)
            {
                if (this.Details.EntryInPoundsOunces)
                {
                    returnVal = IsValidIntegerInRange(this.Details.EntryWeightPounds, 0, 50);
                    if (!returnVal)
                        this.ValidationMessage = InvalidWeightMessage;
                    else
                    {
                        returnVal = IsValidIntegerInRange(this.Details.EntryWeightOunces, 0, 15);
                        if (!returnVal)
                            this.ValidationMessage = InvalidWeightMessage;
                    }
                }
                else
                {
                    returnVal = IsValidIntegerInRange(this.Details.BirthWeight, 0, 10000);
                    if (!returnVal)
                        this.ValidationMessage = InvalidWeightMessage;
                }
            }

            return returnVal; 
        }

        private bool IsValidIntegerInRange(string original, int lowest, int highest)
        {
            bool returnVal = false;

            int temp = -1;

            // *** First allow none ***
            if (string.IsNullOrWhiteSpace(original)) 
                returnVal = true; 
            else if (int.TryParse(original, out temp))
                if ((temp >= lowest) && (temp <= highest))
                    returnVal = true;
        
            return returnVal; 

        }
                
    }
}
