// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.CDA.Common;

namespace VA.Gov.Artemis.CDA.Map
{
    public class RaceMap
    {
        private static Dictionary<string, Hl7Race> map;

        private static void Init()
        {
            if (map == null)
            {
                // Key = VistA Value
                // Value = HL7 Cda Value 

                map = new Dictionary<string, Hl7Race>();

                map.Add("2054-5", Hl7Race.AfricanAmerican);
                map.Add("1002-5", Hl7Race.AmericanIndian);
                map.Add("2028-9", Hl7Race.Asian);
                map.Add("2076-8", Hl7Race.PacificIslander);
                map.Add("2106-3", Hl7Race.White); 

            }
        }

        public static Hl7Race GetHl7Race(string vistaRace)
        {
            Hl7Race returnRace = Hl7Race.Unknown;

            Init();

            map.TryGetValue(vistaRace, out returnRace); 

            return returnRace;
        }

    }
}
