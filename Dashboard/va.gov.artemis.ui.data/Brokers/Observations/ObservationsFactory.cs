// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.CDA.Common;
using VA.Gov.Artemis.Commands.Dsio.Observation;
using VA.Gov.Artemis.UI.Data.Models.Edd;
using VA.Gov.Artemis.UI.Data.Models.Observations;
using VA.Gov.Artemis.UI.Data.Models.Pregnancy;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.UI.Data.Brokers.Observations
{
    public static class ObservationsFactory
    {
        public static string NextContactCode { get { return "NextContactDate"; } }
        public static string LastContactCode { get { return "LastContactDate"; } }
        public static string NextChecklistCode { get { return "NextChecklistDate"; } }

        public static string ContactCategory { get { return "Contact"; } }
        public static string ChecklistCategory { get { return "Checklist"; } }

        public static string OutcomeCategory { get { return "Outcome"; } }
        public static string OutcomeTypeCode { get { return "OutcomeType"; } }

        public static string PregnancyCategory { get { return "Pregnancy"; } }
        public static string FetusBabyCountCode { get { return "FetusBabyCount"; } } 

        public static Observation CreateNextContactObservation(string patientDfn, DateTime nextContactDue)
        {
            return CreateObservation(patientDfn, nextContactDue, NextContactCode, "Contact", "The patient is due to be contacted on {0}"); 
        }

        public static Observation CreateLastContactObservation(string patientDfn, DateTime lastContactDate)
        {
            return CreateObservation(patientDfn, lastContactDate, LastContactCode, "Contact", "The last contact with the patient occurred on {0}");
        }

        public static Observation CreateNextChecklistObservation(string patientDfn, DateTime nextChecklistDate)
        {
            return CreateObservation(patientDfn, nextChecklistDate, NextChecklistCode, "Checklist", "The next checklist item is due on {0}");
        }

        public static List<Observation> CreateOutcomeObservations(string patientDfn, PregnancyOutcomeType outcomeType, string outcomeDate, string pregIen)
        {
            List<Observation> returnList = new List<Observation>();

            Observation obs = new Observation()
            {
                PatientDfn = patientDfn,
                Category = OutcomeCategory,
                PregnancyIen = pregIen,
                Code = OutcomeTypeCode,
                CodeSystem = CDA.Common.CodingSystem.Other,  //Observation.OtherCodeSystem,
                EntryDate = DateTime.Now, //.ToString(VistaDates.VistADateFormatFour),
                Description = "Pregnancy Outcome",
                Value = outcomeType.ToString()
            };

            returnList.Add(obs);

            if ((outcomeType == PregnancyOutcomeType.FullTermDelivery) || (outcomeType == PregnancyOutcomeType.PretermDelivery))
            {
                obs = new Observation()
                {
                    PatientDfn = patientDfn,
                    Category = OutcomeCategory,
                    PregnancyIen = pregIen,
                    Code = "75092-7",
                    CodeSystem = CodingSystem.Loinc, //Observation.LoincCodeSystem,
                    EntryDate = DateTime.Now, //.ToString(VistaDates.VistADateFormatFour),
                    Description = "Birth Date of Fetus",
                    Value = outcomeDate
                };

                returnList.Add(obs);
            }

            return returnList;
        }

        private static Observation CreateObservation(string patientDfn, DateTime nextContactDue, string code, string category, string descriptionFormat) 
        {
            // *** Create the observation ***
            Observation obs = new Observation();

            obs.PatientDfn = patientDfn;
            obs.Ien = "";
            obs.EntryDate = DateTime.Now; //.ToString(VistaDates.VistADateFormatFour);
            obs.PregnancyIen = "";
            obs.BabyIen = "";
            obs.Category = category;
            obs.CodeSystem = CodingSystem.Other; //Observation.OtherCodeSystem;
            obs.Code = code;
            obs.Description = string.Format(descriptionFormat, nextContactDue.ToString(VistaDates.VistADateOnlyFormat));
            obs.Value = nextContactDue.ToString(VistaDates.VistADateOnlyFormat);

            return obs; 
        }

        //public static List<Observation> GetObservations(object obj, string patientDfn, string pregnancyIen, string babyIen)
        //{
        //    List<Observation> returnList = new List<Observation>();

        //    PropertyInfo[] props = obj.GetType().GetProperties();

        //    foreach (PropertyInfo pi in props)
        //    {
        //        object orig = pi.GetValue(obj);
        //        if (pi.CanWrite)
        //        {                    
        //            var tempVal = pi.GetValue(obj);

        //            if (tempVal != null)
        //            {
        //                Observation obs = GetObservationPrototype(obj, patientDfn, pregnancyIen, babyIen);

        //                obs.Code = pi.Name;
        //                obs.Value = tempVal.ToString();

        //                returnList.Add(obs);
        //            }
        //        }
        //    }

        //    return returnList;
        //}

        //public static Observation GetObservationPrototype(object obj, string patientDfn, string pregnancyIen, string babyIen)
        //{
        //    Observation returnVal = new Observation();

        //    returnVal.PatientDfn = patientDfn;
        //    returnVal.PregnancyIen = pregnancyIen;
        //    returnVal.BabyIen = babyIen;
        //    returnVal.Category = obj.GetType().Name;
        //    returnVal.Date = DateTime.Now.ToString(VistaDates.VistADateFormatFour);
        //    returnVal.CodeSystem = Observation.OtherCodeSystem;

        //    return returnVal;
        //}

        public static Observation CreateFetusBabyCountObservation(string patientDfn, string pregIen, int fetusBabyCount)
        {
            Observation obs = new Observation()
            {
                PatientDfn = patientDfn,
                Category = PregnancyCategory,
                PregnancyIen = pregIen,
                Code = FetusBabyCountCode,
                CodeSystem = CodingSystem.Other, //Observation.OtherCodeSystem,
                EntryDate = DateTime.Now, //.ToString(VistaDates.VistADateFormatFour),
                Description = "Fetus/Baby Count",
                Value = fetusBabyCount.ToString()
            };

            return obs; 
        }

        public static Observation CreateLmpObservation(string patientDfn, string pregIen, string lmp, bool approximate)
        {
            Observation obs = new Observation()
            {
                PatientDfn = patientDfn,
                Category = PregnancyCategory,
                PregnancyIen = pregIen,
                Code = EddUtility.LmpDateCode,
                CodeSystem = CodingSystem.Loinc,  //Observation.LoincCodeSystem,
                EntryDate = DateTime.Now, //.ToString(VistaDates.VistADateFormatFour),
                Description = "Last Menstrual Period",                
            };

            if (approximate)
                obs.Value = string.Format("{0}|{1}", lmp, "A");
            else
                obs.Value = lmp; 

            return obs;
        }
    }
}
