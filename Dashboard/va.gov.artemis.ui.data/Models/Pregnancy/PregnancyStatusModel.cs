// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.UI.Data.Models.Patient;

namespace VA.Gov.Artemis.UI.Data.Models.Pregnancy
{
    public class PregnancyStatusModel: PatientRelatedModel
    {
        public string OriginalPregnancyStatusDescription
        {
            get
            {
                return (this.Patient.Pregnant) ? "Pregnant" : "Not Pregnant";
            }
        }

        public string OutcomeDate { get; set; }
        
        //public PregnancyOutcomeType OutcomeType { get; set; }

        //public Dictionary<PregnancyOutcomeType, string> OutcomeList
        //{
        //    get
        //    {
        //        return PregnancyOutcomeUtility.OutcomeList; 
        //    }
        //}

        public Dictionary<string, string> StatusList
        {
            get
            {
                Dictionary<string, string> returnList = new Dictionary<string, string>();

                returnList.Add("", ""); 
                returnList.Add(true.ToString(), "Pregnant");
                returnList.Add(false.ToString(), "Not Pregnant"); 

                return returnList;
            }
        }

        //public string TodaysPregnancyStatus
        //{
        //    get
        //    {
        //        return this.Patient.Pregnant.ToString();
        //    }
        //    set
        //    {
        //        bool newVal;

        //        if (bool.TryParse(value, out newVal))
        //            this.Patient.Pregnant = newVal;

        //    }
        //}

        public string NewPregnancyStatus { get; set; }

        public Nullable<bool> NewPregnancyStatusVal
        {
            get
            {
                Nullable<bool> returnVal = null;

                bool newVal;

                if (bool.TryParse(this.NewPregnancyStatus, out newVal))
                    returnVal = newVal;

                return returnVal;
            }
        }

        public string ReturnUrl { get; set; }

        public string LMP { get; set; }

        public string EDD { get; set; }
    }   
}
