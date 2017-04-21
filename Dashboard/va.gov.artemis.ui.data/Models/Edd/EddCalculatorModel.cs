// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.UI.Data.Models.Patient;

namespace VA.Gov.Artemis.UI.Data.Models.Edd
{
    public class EddCalculatorModel: PatientRelatedModel
    {
        public EddItem LMP { get; set; }
        public EddItem Conception { get; set; }
        public EddItem Ultrasound { get; set; }
        public EddItem Embryo { get; set; }
        public EddItem Other { get; set; }
        public EddItem EddOnly { get; set; }

        [Display(Name="Final EDD")]
        public string FinalEdd { get; set; }

        public EddItemType FinalBasedOn { get; set; }

        public string PregnancyIen { get; set; }

        public string ReturnUrl { get; set; }

        public EddCalculatorModel()
        {
            this.LMP = new EddItem() { ItemType = EddItemType.LMP };
            this.Conception = new EddItem() { ItemType = EddItemType.Conception };
            this.Ultrasound = new EddItem() { ItemType = EddItemType.Ultrasound };
            this.Embryo = new EddItem() { ItemType = EddItemType.Embryo };
            this.Other = new EddItem() { ItemType = EddItemType.Other };
            this.EddOnly = new EddItem() { ItemType = EddItemType.EddOnly };
        }

        public List<EddItem> ToList()
        {
            List<EddItem> returnList = new List<EddItem>();

            returnList.Add(LMP);
            returnList.Add(Conception);
            returnList.Add(Ultrasound);
            returnList.Add(Embryo);
            returnList.Add(Other);
            returnList.Add(EddOnly);

            return returnList; 
        }

        public bool IsValid()
        {
            bool returnVal = true;

            if (string.IsNullOrWhiteSpace(this.FinalEdd))
            {
                this.ValidationMessage = "Please select the Final EDD";
                returnVal = false;
            }

            return returnVal;
        }

        public string ValidationMessage { get; set; }
    }
}
