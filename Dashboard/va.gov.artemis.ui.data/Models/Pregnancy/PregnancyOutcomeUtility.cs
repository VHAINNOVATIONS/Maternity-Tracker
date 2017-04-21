// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.UI.Data.Models.Pregnancy
{
    public static class PregnancyOutcomeUtility
    {
        private static string[] descriptions = new string[] {
                    "Unknown", 
                    "Full Term Delivery (Live Infant 37 or More Weeks)",
                    "Preterm Delivery (Live Infant 20-36 Weeks 6 Days)",
                    "Spontaneous Abortion (Pregnancy Loss Prior to 20 Weeks)", 
                    "Fetal Demise/Stillbirth", 
                    "Pregnancy Termination", 
                    "Ectopic Pregnancy"
                };

        public static Dictionary<PregnancyOutcomeType, string> OutcomeList
        {
            get
            {     
                Dictionary<PregnancyOutcomeType, string> returnVal = new Dictionary<PregnancyOutcomeType, string>();

                foreach (PregnancyOutcomeType pregType in Enum.GetValues(typeof(PregnancyOutcomeType)))
                    returnVal.Add(pregType, descriptions[(int)pregType]);

                return returnVal;
            }
        }

        public static string GetDescription(PregnancyOutcomeType outcomeType)
        {
            return descriptions[(int)outcomeType];
        }
    }
}
