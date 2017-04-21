// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Commands.Dsio.Checklist;

namespace VA.Gov.Artemis.UI.Data.Models.Checklist
{
    public class ChecklistItem
    {
        public string Ien { get; set; }
        public string Category { get; set; }
        public string Description { get; set; }

        [Display(Name="Type")]
        public DsioChecklistItemType ItemType { get; set; }

        [Display(Name="Due Calculation")]
        public DsioChecklistCalculationType DueCalculationType { get; set; }

        [Display(Name="Calculation Value")]
        public int DueCalculationValue { get; set; }

        public string EducationItemIen { get; set; }

        public string Link { get; set; }

        public virtual string Due
        {
            get
            {
                string returnVal = "";
                                
                switch (this.DueCalculationType)
                {
                    case DsioChecklistCalculationType.Initial:
                        returnVal = "Immediately";
                        break;
                    case DsioChecklistCalculationType.WeeksGa:
                        returnVal = string.Format("{0} Weeks", this.DueCalculationValue);
                        break;
                    case DsioChecklistCalculationType.TrimesterGa:
                        string[] suffix = new string[] { "", "st", "nd", "rd" };
                        returnVal = string.Format("{0}{1} Trimester", this.DueCalculationValue, suffix[this.DueCalculationValue]);
                        break;
                    case DsioChecklistCalculationType.WeeksPostpartum:
                        returnVal = string.Format("{0} Weeks Postpartum", this.DueCalculationValue);
                        break;
                }

                return returnVal;
            }
        }

        public string ItemTypeDescription
        {
            get
            {
                return ChecklistItemTypeUtility.GetItemTypeDescription(this.ItemType);
            }
        }

        public virtual int DueDays
        {
            get
            {
                int returnVal = -1; 

                //=IF(E5="Initial",0,IF(E5="Weeks Gestation",F5*7, IF(E5="Trimester",F5*14*7, IF(E5="Weeks Postpartum",280 +F5*7))))

                switch (this.DueCalculationType)
                {
                    case DsioChecklistCalculationType.Initial:
                        returnVal = 0;
                        break;
                    case DsioChecklistCalculationType.WeeksGa:
                        returnVal = this.DueCalculationValue * 7; 
                        break;
                    case DsioChecklistCalculationType.TrimesterGa:
                        returnVal = this.DueCalculationValue * 14 * 7; 
                        break;
                    case DsioChecklistCalculationType.WeeksPostpartum:
                        returnVal = this.DueCalculationValue * 7 + 280; 
                        break;
                }

                return returnVal; 
            }
        }

        public virtual bool IsValid()
        {
            bool returnVal = true;

            if (string.IsNullOrWhiteSpace(this.Description))
            {
                this.ValidationMessage = "Please enter a valid description";
                returnVal = false;
            }
            else if ((this.ItemType == DsioChecklistItemType.EducationItem) &&
              (string.IsNullOrWhiteSpace(this.EducationItemIen)))
            {
                this.ValidationMessage = "Please select an education item";
                returnVal = false;
            }
            else if (this.DueCalculationType == DsioChecklistCalculationType.Unknown)
            {
                this.ValidationMessage = "Please enter item due information";
                returnVal = false;
            }
            else if (this.ItemType == DsioChecklistItemType.Unknown)
            {
                this.ValidationMessage = "Please select the type of item";
                returnVal = false;
            }

            return returnVal;
        }

        public string ValidationMessage { get; set; }

    }

}
