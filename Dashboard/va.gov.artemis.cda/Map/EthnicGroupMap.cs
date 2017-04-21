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
    public class EthnicGroupMap
    {        
        //^DIC(10.2,1,0)="HISPANIC OR LATINO^H^2135-2^2135-2^H"
        //^DIC(10.2,2,0)="NOT HISPANIC OR LATINO^N^2186-5^2186-5^N"
        //^DIC(10.2,3,0)="DECLINED TO ANSWER^D^0000-0^^D"
        //^DIC(10.2,4,0)="UNKNOWN BY PATIENT^U^9999-4^^U"

        private static Dictionary<string, Hl7EthnicGroup> map;

        private static void Init()
        {
            if (map == null)
            {
                // Key = VistA Value
                // Value = HL7 Cda Value 

                map = new Dictionary<string, Hl7EthnicGroup>();

                map.Add("2135-2", Hl7EthnicGroup.HispanicLatino);
                map.Add("2186-5", Hl7EthnicGroup.NonHispanicLatino);
            }
        }

        public static Hl7EthnicGroup GetHl7EthnicGroup(string vistaEthnicity)
        {
            Hl7EthnicGroup returnEthnicity = Hl7EthnicGroup.Unknown;

            Init();

            map.TryGetValue(vistaEthnicity, out returnEthnicity);

            return returnEthnicity; 
        }
    }
}
