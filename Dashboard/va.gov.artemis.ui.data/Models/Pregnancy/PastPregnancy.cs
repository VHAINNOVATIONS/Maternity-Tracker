using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.UI.Data.Models.Pregnancy
{
    public class PastPregnancy
    {
        public string Ien { get; set; }

        [Display(Name = "Date")]
        public string PregnancyDateDisplay
        {
            get
            {
                string returnVal = "";

                if (this.PregnancyDate != DateTime.MinValue)
                    returnVal = this.PregnancyDate.ToString("MMMM yyyy");

                return returnVal;
            }
        }

        public DateTime PregnancyDate { get; set; }
       
        public string Outcome { get; set; }

        [Display(Name="Gestational Age")]
        public string GestationalAge { get; set; }

        [Display(Name="Birth Weight")]
        public List<string> BirthWeight { get; set; }

        public List<string> Sex { get; set; }

        [Display(Name="Delivery Type")]
        public List<string> DeliveryType { get; set; }

        [Display(Name="Place of Delivery")]
        public string PlaceOfDelivery { get; set; }

        //[Display(Name="Preterm Labor")]
        //public string PretermLabor { get; set; }

        public string Comments { get; set; }

        public PastPregnancy()
        {
            this.BirthWeight = new List<string>();
            this.Sex = new List<string>();
            this.DeliveryType = new List<string>(); 
        }

        [Display(Name="High Risk")]
        public bool HighRisk { get; set; }

        public string HighRiskDetails { get; set; }

        public DateTime Created { get; set; }

        public bool Deletable
        {
            get
            {
                return (this.Created.Date == DateTime.Now.Date);
            }
        }
    }
}
