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
    public class ObservationIntoleranceMap
    {
        private static Dictionary<string, Hl7ObservationIntoleranceType> map { get; set; }

        private static void Init()
        {
            if (map == null)
            {
                // Key = VistA Value
                // Value = HL7 Cda Value 

                map = new Dictionary<string, Hl7ObservationIntoleranceType>();

                // TODO: What are possible values here ?
                map.Add("D", Hl7ObservationIntoleranceType.DrugAllergy);
                map.Add("DF", Hl7ObservationIntoleranceType.FoodAllergy);
                map.Add("O", Hl7ObservationIntoleranceType.Allergy);
                map.Add("F", Hl7ObservationIntoleranceType.FoodAllergy);

            }
        }

        public static Hl7ObservationIntoleranceType GetIntoleranceType(string vistaType)
        {
            Hl7ObservationIntoleranceType returnVal = Hl7ObservationIntoleranceType.Allergy;

            Init();

            map.TryGetValue(vistaType.ToUpper(), out returnVal); 

            return returnVal; 
        }
    }
}
