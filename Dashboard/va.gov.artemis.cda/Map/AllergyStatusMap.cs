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
    public class AllergyStatusMap
    {
        private static Dictionary<string, CdaConcernStatus> map { get; set; }

        private static void Init()
        {
            if (map == null)
            {
                // Key = VistA Value
                // Value = HL7 Cda Value

                map = new Dictionary<string, CdaConcernStatus>();

                map.Add("O", CdaConcernStatus.Actve);
                map.Add("H", CdaConcernStatus.Completed);
            }
        }

        public static CdaConcernStatus GetAllergyStatus(string vistaStatus)
        {
            CdaConcernStatus returnVal = CdaConcernStatus.Unknown;

            Init();

            map.TryGetValue(vistaStatus.ToUpper(), out returnVal);

            return returnVal;
        }
    }
}
