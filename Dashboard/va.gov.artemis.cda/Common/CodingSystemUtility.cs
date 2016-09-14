using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.CDA.Common
{
    public class CodingSystemUtility
    {
        private static string[] descriptions = new string[] {"None", "LOINC", "SNOMED-CT", "OTHER", "VHA" };
        private static string[] ids = new string[]{"", "2.16.840.1.113883.6.1", "2.16.840.1.113883.6.96", "", "2.16.840.1.113883.6.233" };

        public static string GetDescription(CodingSystem codingSystem)
        {
            return descriptions[(int)codingSystem];
        }

        public static string GetSystemId(CodingSystem codingSystem)
        {
            return ids[(int)codingSystem];
        }

        public static Dictionary<string, CodingSystem> GetCodingSystemSelection()
        {
            Dictionary<string, CodingSystem> returnList = new Dictionary<string, CodingSystem>();

            returnList.Add("None", CodingSystem.None);
            returnList.Add("LOINC", CodingSystem.Loinc);
            returnList.Add("SNOMED-CT", CodingSystem.SnomedCT);
            
            // TODO: Re-add when VistA supports
            //returnList.Add("OTHER", CodingSystem.Other);
            // returnList.Add("VHA", CodingSystem.Vha); 

            return returnList;
        }

        public static CodingSystem GetCodingSystemName(string codingSystemName)
        {
            CodingSystem returnVal = CodingSystem.None;

            switch (codingSystemName)
            {
                case "LOINC":
                case "LNC":
                    returnVal = CodingSystem.Loinc;
                    break;
                case "SNOMED CT":
                case "SNOMED":
                case "SNOMED-CT":
                case "SCT":
                    returnVal = CodingSystem.SnomedCT;
                    break; 
                case "OTHER":
                    returnVal = CodingSystem.Other;
                    break;
                case "VHA":
                    returnVal = CodingSystem.Vha;
                    break; 
            }

            return returnVal; 
        }
    }
}
