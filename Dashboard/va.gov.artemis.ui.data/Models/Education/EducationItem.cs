using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.CDA.Common;
using VA.Gov.Artemis.UI.Data.Models.Common;

namespace VA.Gov.Artemis.UI.Data.Models.Education
{
    public class EducationItem
    {
        public string Ien { get; set; }
        public string Description { get; set; }
        public string Category { get; set; }

        [Display(Name="Education Type")]
        public EducationItemType ItemType { get; set; }

        public string Url { get; set; }
        public string Code { get; set; }

        public CodingSystem CodingSystem { get; set; }

        //[Display(Name="Code")]
        //public string CodePlusSystem
        //{
        //    get
        //    {
        //        string full = this.CodingSystem.ToString();
        //        string letter = full.Substring(0, 1);

        //        return string.Format("{0}:{1}", letter, this.Code);
        //    }
        //    set
        //    {
        //        if (string.IsNullOrWhiteSpace(value))
        //        {
        //            this.Code = "";
        //            this.CodingSystem = CodingSystem.None;
        //        }
        //        else
        //        {
        //            string letter = value.Substring(0, 1);

        //            if (letter == "S")
        //                this.CodingSystem = Common.CodingSystem.SnomedCT;
        //            else if (letter == "L")
        //                this.CodingSystem = CodingSystem.Loinc; 

        //            this.Code = value.Substring(2, value.Length - 2);
        //        }
        //    }
        //}

        public string ItemTypeDescription
        {
            get
            {
                string[] descriptions = new string[] { "Unknown", "Discussion Topic", "Link To Material", "Printed Material", "Enrollment", "Other" };

                return descriptions[(int)this.ItemType];
            }
        }

        [Display(Name="Code")]
        public string CodeDetail
        {
            get
            {
                string returnVal = "";

                if (!string.IsNullOrWhiteSpace(this.Code))
                    returnVal = string.Format("{0} - {1}", this.CodingSystem, this.Code); 

                return returnVal;
            }
        }

    }
}
