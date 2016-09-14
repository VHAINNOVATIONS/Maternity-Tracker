using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.UI.Data.Models.Outcomes
{
    public static class BabyUtilities
    {
        public static string GetBabyDisplayWeight(string totalWeight)
        {
            string returnVal = "Unknown"; 

            int tempWeight = -1;
            if (int.TryParse(totalWeight, out tempWeight))
                returnVal = GetBabyDisplayWeight(tempWeight); 

            return returnVal;
        }

        public static string GetBabyDisplayWeight(int totalWeight)
        {
            string returnVal = "Unknown";

            if (totalWeight > 0)
            {
                // *** Convert grams to total ounces ***
                int totOz = GramsToOunces(totalWeight);
                
                // *** Get lbs and oz ***
                int lbs = totOz / 16;
                int oz = totOz % 16;

                // *** Format final string ***
                returnVal = string.Format("{0}g ({1} lbs. {2} oz.)", totalWeight, lbs, oz);
            }

            return returnVal; 
        }

        public static int GramsToOunces(int grams)
        {
            // *** Convert any grams to ounces (max int) ***
            return (int)Math.Round(grams * .03527396);
        } 

        public static string GetBabyDescription(string babyNum)
        {
            string returnVal = "Baby";

            string[] babyId = { "A", "B", "C", "D", "E", "F", "G", "H", "I" };

            int babyIdx = -1;
            if (int.TryParse(babyNum, out babyIdx))
                if (babyIdx > 0)
                    if (babyIdx < 10)
                        returnVal = string.Format("Baby {0}", babyId[babyIdx - 1]);

            return returnVal;
        }
    }
}
