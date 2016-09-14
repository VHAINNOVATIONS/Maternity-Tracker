using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.CDA;
using VA.Gov.Artemis.CDA.Common;
using VA.Gov.Artemis.CDA.Observations;
using VA.Gov.Artemis.Commands.Vpr.Data;
using VA.Gov.Artemis.UI.Data.Models.Cda.ValueCodes;
using VA.Gov.Artemis.UI.Data.Models.Observations;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.UI.Data.Cda
{
    /// <summary>
    /// Creates observations for use in CDA documents
    /// </summary>
    public static class CdaObservationFactory
    {
        // *** Template id's for the observations created by this factory ***
        private const string PregnancyObservationTemplateId = "1.3.6.1.4.1.19376.1.5.3.1.4.13.5";
        private const string SimpleObservationTemplateId = "1.3.6.1.4.1.19376.1.5.3.1.4.13";
        private const string FamilyHistoryObservationTemplateId = "1.3.6.1.4.1.19376.1.5.3.1.4.13.3";
        private const string CcdFamilyHistoryObservationTemplateId = "2.16.840.1.113883.10.20.1.22";
        private const string SocialHistoryObservationTemplateId = "1.3.6.1.4.1.19376.1.5.3.1.4.13.4";
        private const string CcdSocialHistoryObservationTemplateId = "2.16.840.1.113883.10.20.1.33";
        private const string CcdProblemEntryTemplateId = "2.16.840.1.113883.10.20.1.28";
        private const string ProblemEntryTemplateId = "1.3.6.1.4.1.19376.1.5.3.1.4.5";
        private const string CcdVitalSignsTemplateId = "2.16.840.1.113883.10.20.1.31";
        private const string VitalSignsTemplateId = "1.3.6.1.4.1.19376.1.5.3.1.4.13.2";

        /// <summary>
        /// Creates an observation where the value is a date
        /// </summary>
        /// <param name="observation"></param>
        /// <returns></returns>
        public static CdaDateObservation CreateDateObservation(Observation observation)
        {
            CdaDateObservation returnVal;

            // TODO: What if this date is in another format ?

            // *** Attempt to parse the date ***
            DateTime tempDate = VistaDates.ParseDateString(observation.Value, VistaDates.VistADateOnlyFormat);

            // *** Check if we have a date ***
            if (tempDate == DateTime.MinValue)
                returnVal = null;
            else
            {
                // *** Create the observation ***
                returnVal = new CdaDateObservation();

                // *** Add the date ***
                returnVal.Value = tempDate;

                // *** Add Id, Status ***
                returnVal.Id = Guid.NewGuid().ToString(); //observation.Ien;
                returnVal.Status = Hl7ProblemActStatus.completed;

                // *** Create code ***
                returnVal.Code = new CdaCode() { CodeSystem = observation.CodeSystem, Code = observation.Code, DisplayName = observation.Description };
            }

            return returnVal;
        }

        /// <summary>
        /// Creates an observation where the value is a boolean 
        /// </summary>
        /// <param name="observation"></param>
        /// <returns></returns>
        public static CdaBoolObservation CreateBoolObservation(Observation observation)
        {
            CdaBoolObservation returnVal;

            // *** Try to parse the boolean value ***
            bool val = false;
            if (bool.TryParse(observation.Value, out val))
            {
                // *** If parsed ***

                // *** Create boolean observation ***
                returnVal = new CdaBoolObservation();
                returnVal.Value = val;

                // *** Add Id, Status ***
                returnVal.Id = Guid.NewGuid().ToString(); //observation.Ien;
                returnVal.Status = Hl7ProblemActStatus.completed;

                // *** Create code ***
                returnVal.Code = new CdaCode() { CodeSystem = observation.CodeSystem, Code = observation.Code, DisplayName = observation.Description };
            }
            else
                returnVal = null;

            return returnVal;
        }

        /// <summary>
        /// Create an observation where the value has unit information 
        /// </summary>
        /// <param name="observation"></param>
        /// <returns></returns>
        public static CdaPqObservation CreatePqObservation(Observation observation)
        {
            CdaPqObservation returnVal;

            bool ok = false;

            // *** First get the integer value ***
            int val = -1;
            double val2 = 0;

            if (int.TryParse(observation.Value, out val))
                ok = true;
            else if (double.TryParse(observation.Value, out val2))
                ok = true;

            if (ok)
            {
                // *** Create the observation ***
                returnVal = new CdaPqObservation();

                // *** Add amount, unit information ***
                returnVal.Value = observation.Value;
                returnVal.Unit = observation.Unit;

                // *** Add Id, status ***
                returnVal.Id = Guid.NewGuid().ToString(); // observation.Ien;
                returnVal.Status = Hl7ProblemActStatus.completed;

                // *** Add code ***
                returnVal.Code = new CdaCode() { CodeSystem = observation.CodeSystem, Code = observation.Code, DisplayName = observation.Description };

                returnVal.EffectiveTime = new CdaEffectiveTime() { High = observation.EntryDate };
            }
            else
                returnVal = null;

            return returnVal;
        }

        public static CdaCodeObservation CreateCodeObservation(Observation observation)
        {
            CdaCodeObservation returnVal = new CdaCodeObservation();

            // *** Add Id, status ***
            returnVal.Id = Guid.NewGuid().ToString(); //observation.Ien;
            returnVal.Status = Hl7ProblemActStatus.completed;

            // *** Determine if negation indicator is needed ***
            bool val = false;
            if (bool.TryParse(observation.Value, out val))
                if (val == false)
                    returnVal.NegationIndicator = true;

            // *** Add code ***
            returnVal.Value = new CdaCode() { CodeSystem = observation.CodeSystem, Code = observation.Code, DisplayName = observation.Description };

            return returnVal;
        }

        public static CdaCodeObservation CreateCodeObservation(CodingSystem codeSystem, string code, string description)
        {
            CdaCodeObservation returnVal = new CdaCodeObservation();

            // *** Add Id, status ***
            returnVal.Id = Guid.NewGuid().ToString(); //observation.Ien;
            returnVal.Status = Hl7ProblemActStatus.completed;

            // *** Add code ***
            returnVal.Value = new CdaCode() { CodeSystem = codeSystem, Code = code, DisplayName = description };

            return returnVal;
        }

        public static CdaIntObservation CreateIntObservation(Observation observation)
        {
            CdaIntObservation returnVal;

            int tempVal = -1;
            if (int.TryParse(observation.Value, out tempVal))
            {
                returnVal = new CdaIntObservation();

                // *** Add Id, status ***
                returnVal.Id = Guid.NewGuid().ToString(); //observation.Ien;
                returnVal.Status = Hl7ProblemActStatus.completed;

                // *** Add code ***
                returnVal.Code = new CdaCode() { CodeSystem = observation.CodeSystem, Code = observation.Code, DisplayName = observation.Description };

                // *** Add value ***
                returnVal.Value = tempVal;
            }
            else
                returnVal = null;

            return returnVal;
        }

        public static CdaTextObservation CreateTextObservation(Observation observation)
        {
            CdaTextObservation returnVal = new CdaTextObservation();

            // *** Add Id, status ***
            returnVal.Id = Guid.NewGuid().ToString(); //observation.Ien;
            returnVal.Status = Hl7ProblemActStatus.completed;

            // *** Add code ***
            returnVal.Code = new CdaCode() { CodeSystem = observation.CodeSystem, Code = observation.Code, DisplayName = observation.Description };

            // *** Add value, try narrative ***
            if (string.IsNullOrWhiteSpace(observation.Value))
                returnVal.Value = observation.Narrative; 
            else
                returnVal.Value = observation.Value;

            returnVal.EffectiveTime = new CdaEffectiveTime() { High = observation.EntryDate };

            return returnVal;
        }

        public static CdaCodeObservation CreateFamilyHistoryObservation(Observation observation)
        {
            CdaCodeObservation returnVal = CreateCodeObservation(observation);

            if (returnVal != null)
            {
                returnVal.TemplateIds = new CdaTemplateIdList(
                    FamilyHistoryObservationTemplateId,
                    SimpleObservationTemplateId,
                    CcdFamilyHistoryObservationTemplateId
                    );

                returnVal.Relationship = observation.Relationship;

                // *** All the family observations from OB H&P Initial are diagnoses ***
                returnVal.Code = new CdaCode() { CodeSystem = CodingSystem.SnomedCT, Code = "282291009", DisplayName = "Diagnosis" };
            }

            return returnVal;
        }

        public static CdaCodeObservation CreateUnknownFamilyHistoryObservation()
        {
            CdaCodeObservation returnVal = new CdaCodeObservation();

            // *** Add Id, status ***
            returnVal.Id = Guid.NewGuid().ToString(); //observation.Ien;
            returnVal.Status = Hl7ProblemActStatus.completed;

            // *** Add code ***
            returnVal.Value = new CdaCode() { CodeSystem = CodingSystem.SnomedCT, Code = "407559004", DisplayName = "Family History Unknown" };

            // *** All the family observations from OB H&P Initial are diagnoses ***
            returnVal.Code = new CdaCode() { CodeSystem = CodingSystem.SnomedCT, Code = "282291009", DisplayName = "Diagnosis" };

            returnVal.TemplateIds = new CdaTemplateIdList(
                FamilyHistoryObservationTemplateId,
                SimpleObservationTemplateId,
                CcdFamilyHistoryObservationTemplateId
                );

            return returnVal;
        }        

        public static CdaPqObservation CreateSocialPqObservation(Observation observation)
        {
            CdaPqObservation returnVal = CreatePqObservation(observation);

            if (returnVal != null)
                returnVal.TemplateIds = new CdaTemplateIdList(CcdSocialHistoryObservationTemplateId, SimpleObservationTemplateId, SocialHistoryObservationTemplateId);

            return returnVal;
        }

        public static CdaCodeObservation CreateSocialCodeObservation(Observation observation)
        {
            CdaCodeObservation returnVal = CreateCodeObservation(observation);

            returnVal.TemplateIds = new CdaTemplateIdList(CcdSocialHistoryObservationTemplateId, SimpleObservationTemplateId, SocialHistoryObservationTemplateId);

            // *** Code should be a category ***
            //switch (observation.Category)
            //{
            //    case "Social History: Diet":
            //        returnVal.Code = new CdaCode() { CodeSystem = CodingSystem.SnomedCT, Code = "364393001", DisplayName = "Diet" };
            //        break;
            //    case "Social History: Employment":
            //        returnVal.Code = new CdaCode() { CodeSystem = CodingSystem.SnomedCT, Code = "364703007", DisplayName = "Employment" };
            //        break;
            //    case "Social History: Toxic":
            //        returnVal.Code = new CdaCode() { CodeSystem = CodingSystem.SnomedCT, Code = "425400000", DisplayName = "Toxic Exposure" };
            //        break;
            //    case "Social History: Drug Use":
            //        returnVal.Code = new CdaCode() { CodeSystem = CodingSystem.SnomedCT, Code = "363908000", DisplayName = "Drug Use" };
            //        break;
            //    case "Social History: Other":
            //        returnVal.Code = new CdaCode() { CodeSystem = CodingSystem.SnomedCT, Code = "228272008", DisplayName = "Other Social History" };
            //        break;
            //}

            returnVal.Code = new CdaCode() { CodeSystem = observation.CodeSystem, Code = observation.Code, DisplayName = observation.Description };

            if (!string.IsNullOrWhiteSpace(observation.Narrative))
                returnVal.Comment = observation.Narrative; 

            return returnVal;
        }

        public static CdaCodeObservation CreateProblemObservation(Observation observation)
        {
            CdaCodeObservation returnVal = CreateCodeObservation(observation);

            if (returnVal != null)
            {
                returnVal.TemplateIds = new CdaTemplateIdList(
                    CcdProblemEntryTemplateId,
                    ProblemEntryTemplateId);

                returnVal.EffectiveTime = new CdaEffectiveTime() { Low = observation.EntryDate };

                returnVal.Code = new CdaCode() { CodeSystem = CodingSystem.SnomedCT, Code = "404684003", DisplayName = "Finding" };

                returnVal.Comment = observation.Narrative;
            }

            return returnVal;
        }

        public static CdaCodeObservation CreateUnknownProblemObservation()
        {
            CdaCodeObservation returnVal = new CdaCodeObservation(); 

            // *** Add Id, status ***
            returnVal.Id = Guid.NewGuid().ToString(); //observation.Ien;
            returnVal.Status = Hl7ProblemActStatus.completed;

            // *** Add code ***
            returnVal.Value = new CdaCode() { CodeSystem = CodingSystem.SnomedCT, Code = "396782006", DisplayName = "Past Medical History Unknown" };

            returnVal.TemplateIds = new CdaTemplateIdList(
                CcdProblemEntryTemplateId,
                ProblemEntryTemplateId);

//            returnVal.EffectiveTime = new CdaEffectiveTime() { Low = observation.ObservationDate };

            returnVal.Code = new CdaCode() { CodeSystem = CodingSystem.SnomedCT, Code = "404684003", DisplayName = "Finding" };

            return returnVal;
        }

        public static CdaCodeObservation CreateProblemObservation(Problem problem)
        {
            CdaCodeObservation returnVal = new CdaCodeObservation();

            // *** Add Id, status ***
            returnVal.Id = Guid.NewGuid().ToString(); 
            returnVal.Status = Hl7ProblemActStatus.completed;

            // *** Determine if negation indicator is needed ***
            //bool val = false;
            //if (bool.TryParse(observation.Value, out val))
            //    if (val == false)
            //        returnVal.NegationIndicator = true;

            // *** Add code ***
            returnVal.Value = new CdaCode() { CodeSystem =  CodingSystem.Icd9, Code = problem.Icd.Value, DisplayName = problem.ItemName.Value };

            returnVal.TemplateIds = new CdaTemplateIdList(
                CcdProblemEntryTemplateId,
                ProblemEntryTemplateId);

            returnVal.EffectiveTime = new CdaEffectiveTime(); 
            
            if (problem.Onset != null) 
                returnVal.EffectiveTime.Low = problem.Onset.ToDateTime();

            returnVal.Code = new CdaCode() { CodeSystem = CodingSystem.SnomedCT, Code = "404684003", DisplayName = "Finding" };

            return returnVal;
        }

        public static CdaIntObservation CreatePregnancyHistoryIntObservation(Observation observation)
        {
            CdaIntObservation returnVal = CreateIntObservation(observation);

            if (returnVal != null)
            {
                returnVal.TemplateIds = new CdaTemplateIdList(SimpleObservationTemplateId, PregnancyObservationTemplateId);

                returnVal.EffectiveTime = new CdaEffectiveTime() { Value = observation.EntryDate };
            }

            return returnVal;
        }

        public static CdaTextObservation CreatePregnancyHistoryTextObservation(Observation observation)
        {
            CdaTextObservation returnVal = CreateTextObservation(observation);

            if (returnVal != null)
            {
                returnVal.TemplateIds = new CdaTemplateIdList(SimpleObservationTemplateId, PregnancyObservationTemplateId);

                returnVal.EffectiveTime = new CdaEffectiveTime() { Value = observation.EntryDate };                                
            }

            return returnVal;
        }

        public static CdaBoolObservation CreatePregnancyHistoryBoolObservation(Observation observation)
        {
            CdaBoolObservation returnVal = CreateBoolObservation(observation);

            if (returnVal != null)
            {
                returnVal.TemplateIds = new CdaTemplateIdList(SimpleObservationTemplateId, PregnancyObservationTemplateId);
                returnVal.EffectiveTime = new CdaEffectiveTime() { Value = observation.EntryDate };
            }

            return returnVal;
        }

        public static CdaCeObservation CreatePregnancyStatusObservation(bool patientIsPregnant)
        {
            CdaCeObservation returnVal = new CdaCeObservation();

            // *** Pregnancy History Template ***
            returnVal.TemplateIds = new CdaTemplateIdList(SimpleObservationTemplateId, PregnancyObservationTemplateId);

            // *** Add Id, status ***
            returnVal.Id = Guid.NewGuid().ToString();
            returnVal.Status = Hl7ProblemActStatus.completed;

            // *** Negation Indicator ***
            returnVal.NegationIndicator = !patientIsPregnant;

            // *** Status is a finding ***
            //returnVal.Code = new CdaCode() { CodeSystem = CodingSystem.SnomedCT, Code = "404684003", DisplayName = "Finding" };
            returnVal.Code = new CdaCode() { CodeSystem = CodingSystem.Loinc, Code = "11449-6", DisplayName = "Pregnancy Status" };

            // *** Value contains pregnancy status + negation indicator ***
            returnVal.Value = new CdaCode() { CodeSystem = CodingSystem.Loinc, Code = "11449-6", DisplayName = "Pregnancy Status" };
            
            return returnVal;
        }

        public static CdaPqObservation CreatePregnancyHistoryPqObservation(Observation observation)
        {
            CdaPqObservation returnVal = CreatePqObservation(observation);

            if (returnVal != null)
            {
                returnVal.TemplateIds = new CdaTemplateIdList(SimpleObservationTemplateId, PregnancyObservationTemplateId);
                returnVal.EffectiveTime = new CdaEffectiveTime() { Value = observation.EntryDate };
            }

            return returnVal;
        }

        public static CdaDateObservation CreatePregnancyHistoryDateObservation(Observation observation)
        {
            CdaDateObservation returnVal = CreateDateObservation(observation);

            if (returnVal != null)
                returnVal.TemplateIds = new CdaTemplateIdList(SimpleObservationTemplateId, PregnancyObservationTemplateId);

            return returnVal;
        }

        public static CdaPqObservation CreateVitalSignsObservation(Observation observation)
        {
            CdaPqObservation returnVal = CreatePqObservation(observation);

            if (returnVal != null)
            {
                returnVal.TemplateIds = new CdaTemplateIdList(SimpleObservationTemplateId, CcdVitalSignsTemplateId, VitalSignsTemplateId);

                returnVal.EffectiveTime = new CdaEffectiveTime() { High = observation.EntryDate };
            }

            return returnVal;
        }

        public static CdaSimpleObservation CreateObservation(POCD_MT000040Observation pocdObservation)
        {
            CdaSimpleObservation returnVal = null;

            if (pocdObservation.value != null)
                if (pocdObservation.value.Length > 0)
                {
                    ANY first = pocdObservation.value[0];

                    if (first is INT)
                        returnVal = new CdaIntObservation(pocdObservation);
                    else if (first is TS)
                        returnVal = new CdaDateObservation(pocdObservation);
                    else if (first is PQ)
                        returnVal = new CdaPqObservation(pocdObservation);
                    else if (first is ST)
                        returnVal = new CdaTextObservation(pocdObservation);                      
                }

            return returnVal;
        }

        public static CdaBoolObservation CreateAdvanceDirectiveObservation(Observation observation)
        {
            CdaBoolObservation returnVal = CdaObservationFactory.CreateBoolObservation(observation);

            // *** NOTE: These are ID's in the specification but do not validate with the NIST tool
            //returnVal.TemplateIds.AddId("2.16.840.1.113883.10.20.1.17");
            //returnVal.TemplateIds.AddId("1.3.6.1.4.1.19376.1.5.3.1.4.13.7");

            if (returnVal != null)
            {
                // *** NOTE: This template ID validates with NIST *** 
                returnVal.TemplateIds.AddId("2.16.840.1.113883.10.20.1.25");

                returnVal.Mood = x_ActMoodDocumentObservation.RQO;

                returnVal.EffectiveTime = new CdaEffectiveTime() { Value = observation.EntryDate };

            }

            return returnVal; 
        }

        public static CdaAllergy CreateLatexAllergy(List<Observation> list)
        {
            CdaAllergy returnVal = null; 

            Observation latexObs = list.FirstOrDefault(o => o.Code == "300916003");

            if (latexObs != null)
            {
                returnVal = new CdaAllergy();

                if (latexObs.Negation)
                    returnVal.AllergyText = "NO Latex Allergy";
                else
                    returnVal.AllergyText = "Latex Allergy";

                returnVal.EffectiveTime = new CdaEffectiveTime() { Low = latexObs.EntryDate };

                returnVal.Id = Guid.NewGuid().ToString();
                returnVal.IntoleranceType = Hl7ObservationIntoleranceType.Allergy;
                returnVal.Status = CdaConcernStatus.Actve;
                returnVal.Substance = "Latex";
                returnVal.NegationIndicator = latexObs.Negation;
                returnVal.Value = new CdaCode()
                {
                    Code = "300916003",
                    CodeSystem = CodingSystem.SnomedCT,
                    DisplayName = "Latex Allergy"
                };
            }

            return returnVal;
        }

        internal static CdaDateObservation CreateEddObservation()
        {
            CdaDateObservation returnVal = new CdaDateObservation();

            returnVal.TemplateIds.AddId("1.3.6.1.4.1.19376.1.5.3.1.4.13");
            returnVal.TemplateIds.AddId("1.3.6.1.4.1.19376.1.5.3.1.1.11.2.3.1");
            returnVal.Status = Hl7ProblemActStatus.completed;
            returnVal.Code = new CdaCode() { CodeSystem = CodingSystem.Loinc, Code = "11778-8", DisplayName = "Estimated Delivery Date" };

            return returnVal; 
        }

        internal static CdaPqObservation CreateLabObservation(Lab lab)
        {
            CdaPqObservation returnVal = new CdaPqObservation();

            returnVal.Mood = x_ActMoodDocumentObservation.EVN; 
            returnVal.TemplateIds.AddId("1.3.6.1.4.1.19376.1.3.1.6");

            // *** Add Id, status ***
            returnVal.Id = Guid.NewGuid().ToString(); // observation.Ien;
            returnVal.Status = Hl7ProblemActStatus.completed;

            // *** Effective Time ***
            if (lab.Resulted != null) 
                returnVal.EffectiveTime = new CdaEffectiveTime() { High = lab.Resulted.ToDateTime() };

            // *** Value *** 
            if (lab.Result != null)
            {
                decimal val = 0.0m;
                if (decimal.TryParse(lab.Result.Value, out val))
                    returnVal.Value = lab.Result.Value;
            }

            // *** Units ***
            if (lab.Units != null) 
                returnVal.Unit = lab.Units.Value; 

            // *** Code ***
            if (lab.Loinc != null)
                if (!string.IsNullOrWhiteSpace(lab.Loinc.Value))
                    returnVal.Code = new CdaCode()
                    {
                        CodeSystem = CodingSystem.Loinc,
                        Code = lab.Loinc.Value,
                        DisplayName = lab.Test.Value
                    };

            if (returnVal.Code == null)
            {
                // *** Use VUID if there is one ***
                string id = "";
                if (lab.VuId != null)
                    if (!string.IsNullOrWhiteSpace(lab.VuId.Value))
                    {
                        id = lab.VuId.Value;

                        returnVal.Code = new CdaCode()
                        {
                            CodeSystem = CodingSystem.Vha,
                            Code = id,
                            DisplayName = lab.Test.Value
                        };
                    }
            }

            if (returnVal.Code == null)
                returnVal.Code = new CdaCode() { DisplayName = lab.Test.Value }; 

            // *** Reference Range ***
            CdaReferenceRange range = new CdaReferenceRange();

            if (lab.Low != null)
            {
                decimal val = 0.0m;
                if (decimal.TryParse(lab.Low.Value, out val))
                    range.Low = lab.Low.Value;
            }

            if (lab.High != null)
            {
                decimal val = 0.0m;
                if (decimal.TryParse(lab.High.Value, out val))
                    range.High = lab.High.Value;
            }

            if (lab.Units != null)
                range.Units = lab.Units.Value;

            returnVal.ReferenceRange = range; 

            // *** Interpretation Code ***
            if (lab.Interpretation != null)
                returnVal.InterpretationCode = lab.Interpretation.Value; 

            return returnVal;
        }

        public static CdaCodeObservation CreateObservation(POCD_MT000040Procedure item)
        {
            CdaCodeObservation returnVal = new CdaCodeObservation();

            CdaProcedure tempProc = new CdaProcedure(item);

            returnVal.Id = tempProc.Id;
            returnVal.Code = tempProc.Code;
            returnVal.EffectiveTime = tempProc.EffectiveTime;
            returnVal.Value = new CdaCode() { DisplayName = "" };

            return returnVal;
        }

        public static CdaCodeObservation CreateVisitSummaryCodeObservation(Observation observation)
        {
            CdaCodeObservation returnVal = new CdaCodeObservation();

            // *** Add Id, status ***
            returnVal.Id = Guid.NewGuid().ToString(); //observation.Ien;
            returnVal.Status = Hl7ProblemActStatus.completed;

            // *** Add code ***
            returnVal.Code = new CdaCode() { CodeSystem = observation.CodeSystem, Code = observation.Code, DisplayName = observation.Description };

            // *** Add value ***
            returnVal.Value = GetVisitSummaryValueCode(observation);

            // *** Add date ***
            returnVal.EffectiveTime = new CdaEffectiveTime() { High = observation.EntryDate };

            return returnVal;
        }

        private static CdaCode GetVisitSummaryValueCode(Observation observation)
        {
            CdaCode returnCode;

            AlbuminDictionary albuminDictionary = new AlbuminDictionary();
            EdemaDictionary edemaDictionary = new EdemaDictionary();
            FetalMovementDictionary fetalMovementDictionary = new FetalMovementDictionary();             
            FetalPresentationDictionary fetalPresentationDictionary = new FetalPresentationDictionary();
            GlucoseDictionary glucoseDictionary = new GlucoseDictionary();
            PainDictionary painDictionary = new PainDictionary(); 


            string valueCode = "";

            Dictionary<string, string> lookupDictionary = null; 

            switch (observation.Code)
            {
                case "11876-0":
                case "11877-8":
                    lookupDictionary = fetalPresentationDictionary; 
                    break;
                    
                case "57088-7":
                    lookupDictionary = fetalMovementDictionary;
                    break;

                case "1753-3":
                    lookupDictionary = albuminDictionary; 
                    break;

                case "2349-9":
                case "25428-4":
                    lookupDictionary = glucoseDictionary;
                    break;

                case "44966-0":
                    lookupDictionary = edemaDictionary;
                    break;

                case "38208-5":
                    lookupDictionary = painDictionary;
                    break; 
            }

            if (lookupDictionary != null) 
                if (lookupDictionary.ContainsKey(observation.Value))
                    valueCode = lookupDictionary[observation.Value]; 

            if (!string.IsNullOrWhiteSpace(valueCode))
                if (valueCode.Contains("-"))
                    returnCode = new CdaCode() { CodeSystem = CodingSystem.Loinc, Code = valueCode, DisplayName = observation.Value };
                else
                    returnCode = new CdaCode() { CodeSystem = CodingSystem.SnomedCT, Code = valueCode, DisplayName = observation.Value };
            else
                returnCode = new CdaCode(); 

            return returnCode; 
        }
    }
}
