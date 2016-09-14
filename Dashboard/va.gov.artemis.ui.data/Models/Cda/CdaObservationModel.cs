using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.CDA.Common;
using VA.Gov.Artemis.CDA.Observations;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.UI.Data.Models.Cda
{
    public class CdaObservationModel
    {
        public string EffectiveTime { get; set; }
        public string CodeSystem { get; set; }
        public string Code { get; set; }
        public string DisplayName { get; set; }
        public string NegationInd { get; set; }
        public string Status { get; set; }
        public string Value { get; set; }
        public bool SelectedForImport { get; set; }
        public int BabyNumber { get; set; }

        public static CdaObservationModel Create(CdaSimpleObservation obs)
        {
            CdaObservationModel returnVal = new CdaObservationModel();

            // TODO: Support low/high 
            // TODO: Show time 

            returnVal.EffectiveTime = obs.EffectiveTime.High.ToString(VistaDates.UserDateFormat);

            if (obs.Code != null)
            {
                returnVal.CodeSystem = CodingSystemUtility.GetDescription(obs.Code.CodeSystem);
                returnVal.Code = obs.Code.Code;
                returnVal.DisplayName = obs.Code.DisplayName;
            }

            returnVal.NegationInd = (obs.NegationIndicator) ? "True" : "False";

            returnVal.Status = obs.Status.ToString();

            returnVal.Value = obs.DisplayValue; 

            return returnVal; 
        }
    }
}
