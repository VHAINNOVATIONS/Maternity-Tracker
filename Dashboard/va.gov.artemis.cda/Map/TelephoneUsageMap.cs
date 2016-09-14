using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.CDA.Common;

namespace VA.Gov.Artemis.CDA.Map
{
    public static class TelephoneUsageMap
    {
        private static Dictionary<string, Hl7TelephoneUsage> map;

        private static void Init()
        {
            if (map == null)
            {
                map = new Dictionary<string, Hl7TelephoneUsage>(); 

                map.Add("H", Hl7TelephoneUsage.PrimaryHome);
                map.Add("WP", Hl7TelephoneUsage.WorkPlace);
                map.Add("MC", Hl7TelephoneUsage.MobileContact);
            }

        }

        public static Hl7TelephoneUsage GetHl7TelephoneUsage(string vistaTelephoneUsage)
        {
            Hl7TelephoneUsage returnUsage = Hl7TelephoneUsage.Unknown;

            Init();

            map.TryGetValue(vistaTelephoneUsage, out returnUsage); 

            return returnUsage; 
        }

    }
}
