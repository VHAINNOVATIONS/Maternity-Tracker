using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.UI.Data.Models.Education
{
    public class PatientEducationItem: EducationItem 
    {
        public string PatientDfn { get; set; }

        [Display(Name = "Completed")]
        public DateTime CompletedOn { get; set; }

        [Display(Name="Completed By")]
        public string CompletedBy { get; set; }

        public string EducationItemIen { get; set; }

        public PatientEducationItem() {}

        public PatientEducationItem(EducationItem baseItem)
        {
            PropertyInfo[] props = typeof(EducationItem).GetProperties();

            foreach (PropertyInfo pi in props)
            {
                object orig = pi.GetValue(baseItem);
                if (pi.CanWrite)
                    pi.SetValue(this, orig);
            }
        }

        [Display(Name = "Completed")]
        public string CompletedOnDisplay
        {
            get
            {
                string returnVal = "";

                if (this.CompletedOn != DateTime.MinValue)
                    returnVal = this.CompletedOn.ToString(VistaDates.UserDateTimeFormat);

                return returnVal;
            }
        }

    }
}
