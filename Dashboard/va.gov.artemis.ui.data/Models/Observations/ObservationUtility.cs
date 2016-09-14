using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.CDA.Common;
using VA.Gov.Artemis.Commands.Dsio.Observation;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.UI.Data.Models.Observations
{
    public static class ObservationUtility
    {
        public static Observation GetObservation(DsioObservation dsioObs)
        {
            Observation returnVal = new Observation()
            {
                Ien = dsioObs.Ien,
                BabyIen = dsioObs.BabyIen,
                BabyNumber = dsioObs.BabyNum,
                Category = dsioObs.Category,
                Code = dsioObs.Code.Code,
                Description = dsioObs.Code.DisplayName,
                EnteredBy = dsioObs.EnteredBy,
                PatientDfn = dsioObs.PatientDfn,
                PregnancyIen = dsioObs.PregnancyIen,
                Value = dsioObs.Value, 
                Narrative = dsioObs.Narrative,
                Unit = dsioObs.Unit, 
                ExchangeDocumentIen = dsioObs.ExchangeDocumentIen           
            };

            returnVal.CodeSystem = CodingSystemUtility.GetCodingSystemName(dsioObs.Code.CodeSystemName);

            returnVal.EntryDate = VistaDates.FlexParse(dsioObs.EntryDate);
            returnVal.ExamDate = VistaDates.FlexParse(dsioObs.ExamDate); 

            returnVal.Relationship = CdaRoleCode.GetHl7FamilyMember(dsioObs.Relationship);

            returnVal.Negation = dsioObs.Negation.Equals("true", StringComparison.CurrentCultureIgnoreCase);

            return returnVal;
        }

        public static DsioObservation GetDsioObservation(Observation observation)
        {
            DsioObservation returnVal = new DsioObservation()
            {
                Ien = observation.Ien,
                BabyIen = observation.BabyIen,
                Category = observation.Category,                
                EnteredBy = observation.EnteredBy,
                PatientDfn = observation.PatientDfn,
                PregnancyIen = observation.PregnancyIen,
                Value = observation.Value, 
                Narrative = observation.Narrative,
                Unit = observation.Unit, 
                ExchangeDocumentIen = observation.ExchangeDocumentIen
            };

            returnVal.Code.Code = observation.Code;
            returnVal.Code.DisplayName = observation.Description;            
            returnVal.Code.CodeSystemName = CodingSystemUtility.GetDescription(observation.CodeSystem);

            returnVal.ExamDate = observation.ExamDate.ToString(VistaDates.VistADateFormatFour);
            returnVal.EntryDate = observation.EntryDate.ToString(VistaDates.VistADateFormatFour);

            returnVal.Negation = (observation.Negation) ? "true" : "false";

            return returnVal; 
        }
    }
}
