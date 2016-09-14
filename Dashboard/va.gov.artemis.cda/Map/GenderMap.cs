using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.CDA.Common;

namespace VA.Gov.Artemis.CDA.Map
{
    public static class GenderMap
    {
        private static Dictionary<string, Hl7Gender> map;

        private static void Init()
        {
            if (map == null)
            {
                // Key = VistA Value
                // Value = HL7 Cda Value 

                map = new Dictionary<string, Hl7Gender>();

                map.Add("M", Hl7Gender.Male);
                map.Add("F", Hl7Gender.Female); 
            }
        }

        public static Hl7Gender GetHl7Gender(string vistaGender)
        {
            Hl7Gender returnGender = Hl7Gender.Unknown;

            Init();

            map.TryGetValue(vistaGender, out returnGender); 

            return returnGender;
        }
    }
}
