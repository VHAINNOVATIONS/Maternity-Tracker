using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.CDA;
using VA.Gov.Artemis.CDA.Common;
using VA.Gov.Artemis.CDA.DocumentationOf;
using VA.Gov.Artemis.CDA.IHE;
using VA.Gov.Artemis.CDA.IHE.Sections;
using VA.Gov.Artemis.CDA.Map;
using VA.Gov.Artemis.CDA.Observations;
using VA.Gov.Artemis.CDA.Participant;
using VA.Gov.Artemis.CDA.RecordTarget;
using VA.Gov.Artemis.CDA.ValueSets;
using VA.Gov.Artemis.Commands.Vpr.Data;
using VA.Gov.Artemis.UI.Data.Cda;
using VA.Gov.Artemis.UI.Data.Models.Edd;
using VA.Gov.Artemis.UI.Data.Models.Observations;
using VA.Gov.Artemis.UI.Data.Models.Pregnancy;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.UI.Data.Models.Cda
{
    public static class CdaSectionFactory
    {
        public static CodedVitalSignsSection CreateVitalsSubSection(VprPatientResult vprData)
        {
            CodedVitalSignsSection returnVal = new CodedVitalSignsSection();

            if (vprData.Vitals != null)
                if (vprData.Vitals.Count > 0)
                {
                    // TODO: Create multiple organizers...

                    foreach (var item in vprData.Vitals[0].Measurements)
                    {
                        if (item.Name.Equals("Blood Pressure", StringComparison.CurrentCultureIgnoreCase))
                        {
                            // *** Split single measurement into 2 ***

                            // *** Create systolic ***
                            Observation tempObservation = new Observation();

                            tempObservation.EntryDate = vprData.Vitals[0].Taken.ToDateTime();
                            tempObservation.Value = Util.Piece(item.Value, "/", 1);
                            tempObservation.Unit = item.Units;

                            CdaCode tempCode = GetVitalsCode("SYSTOLIC");
                            tempObservation.CodeSystem = tempCode.CodeSystem;
                            tempObservation.Code = tempCode.Code;
                            tempObservation.Description = tempCode.DisplayName;

                            CdaPqObservation vitalObservation = CdaObservationFactory.CreateVitalSignsObservation(tempObservation);

                            returnVal.Observations.Add(vitalObservation);

                            // *** Create diastolic ***
                            tempObservation.Value = Util.Piece(item.Value, "/", 2);
                            tempCode = GetVitalsCode("DIASTOLIC");
                            tempObservation.CodeSystem = tempCode.CodeSystem;
                            tempObservation.Code = tempCode.Code;
                            tempObservation.Description = tempCode.DisplayName;

                            vitalObservation = CdaObservationFactory.CreateVitalSignsObservation(tempObservation);

                            returnVal.Observations.Add(vitalObservation);
                        }
                        else
                        {
                            Observation tempObservation = new Observation();

                            tempObservation.EntryDate = vprData.Vitals[0].Taken.ToDateTime();
                            tempObservation.Value = item.Value;
                            tempObservation.Unit = item.Units;

                            CdaCode tempCode = GetVitalsCode(item.Name);
                            if (tempCode != null)
                            {
                                tempObservation.CodeSystem = tempCode.CodeSystem;
                                tempObservation.Code = tempCode.Code;
                                tempObservation.Description = tempCode.DisplayName;

                                CdaPqObservation vitalObservation = CdaObservationFactory.CreateVitalSignsObservation(tempObservation);

                                returnVal.Observations.Add(vitalObservation);
                            }
                        }
                    }
                }


            return returnVal;
        }

        private static CdaCode GetVitalsCode(string name)
        {
            //            9279-1
            //RESPIRATION RATE
            ///min
            //PQ
            //8867-4
            //HEART BEAT
            //2710-2
            //OXYGEN SATURATION
            //%
            //8480-6
            //INTRAVASCULAR SYSTOLIC
            //mm[Hg]
            //8462-4
            //INTRAVASCULAR DIASTOLIC
            //8310-5
            //BODY TEMPERATURE
            //Cel or [degF]
            //8302-2
            //BODY HEIGHT (MEASURED)
            //m, cm,[in_us] or [in_uk]
            //8306-3
            //BODY HEIGHT^LYING
            //8287-5
            //CIRCUMFRENCE.OCCIPITAL-FRONTAL (TAPE MEASURE)
            //3141-9
            //BODY WEIGHT (MEASURED)
            //kg, g, [lb_av] or [oz_av]

            //<vital>
            //<entered value='3160518.104236' />
            //<facility code='500' name='VAMC ALBANY' />
            //<location code='242' name='242' />
            //<measurements>
            //<measurement id='955' name='BLOOD PRESSURE' value='120/80' units='mm[Hg]' high='210/110' low='100/60' />
            //<measurement id='956' name='HEIGHT' value='74' units='in' metricValue='187.96' metricUnits='cm' />
            //<measurement id='958' name='PULSE' value='78' units='/min' high='120' low='60' />
            //<measurement id='957' name='PAIN' value='0' />
            //<measurement id='954' name='PULSE OXIMETRY' value='76' units='%' high='100' low='50' >
            //<qualifiers>
            //<qualifier name='VENTILATOR' />
            //</qualifiers>
            //</measurement>
            //<measurement id='959' name='RESPIRATION' value='24' units='/min' high='30' low='8' />
            //<measurement id='960' name='TEMPERATURE' value='98.4' units='F' metricValue='36.9' metricUnits='C' high='102' low='95' />
            //<measurement id='961' name='WEIGHT' value='150' units='lb' metricValue='68.18' metricUnits='kg' />
            //</measurements>
            //<taken value='3160518.104124' />
            //</vital>
            //</vitals>
            CdaCode returnVal = new CdaCode() { CodeSystem = CodingSystem.Loinc };

            switch (name)
            {
                case "HEIGHT":
                    returnVal.Code = "8302-2";
                    returnVal.DisplayName = "BODY HEIGHT (MEASURED)";
                    break;
                case "PULSE":
                    returnVal.Code = "8867-4";
                    returnVal.DisplayName = "HEART BEAT";
                    break;
                case "PULSE OXIMETRY":
                    returnVal.Code = "2710-2";
                    returnVal.DisplayName = "OXYGEN SATURATION";
                    break;
                case "RESPIRATION":
                    returnVal.Code = "9279-1";
                    returnVal.DisplayName = "RESPIRATION RATE";
                    break;
                case "TEMPERATURE":
                    returnVal.Code = "8310-5";
                    returnVal.DisplayName = "BODY TEMPERATURE";
                    break;
                case "WEIGHT":
                    returnVal.Code = "3141-9";
                    returnVal.DisplayName = "BODY WEIGHT (MEASURED)";
                    break;
                case "SYSTOLIC":
                    returnVal.Code = "8480-6";
                    returnVal.DisplayName = "INTRAVASCULAR SYSTOLIC";
                    break;
                case "DIASTOLIC":
                    returnVal.Code = "8462-4";
                    returnVal.DisplayName = "INTRAVASCULAR DIASTOLIC";
                    break;
                default:
                    returnVal = null;
                    break;
            }

            return returnVal;
        }

        public static CodedPhysicalExamSection CreatePhysicalExamSection(List<Observation> list)
        {
            CodedPhysicalExamSection returnVal = new CodedPhysicalExamSection();

            if (list != null)
            {
                Observation physicalExamObservation = list.FirstOrDefault(o => o.Category == "Physical Exam");

                if (physicalExamObservation != null)
                    returnVal.AddNarrative(physicalExamObservation.Code, physicalExamObservation.Value);
            }

            return returnVal;
        }

        public static PregnancyHistorySection CreatePregnancyHistorySection(List<Observation> observationList, bool patientIsPregnant, List<PregnancyDetails> pregnanciesList)
        {
            // *** Creates a pregnancy history section containing:
            // ***         General information about pregnancies
            // ***         Pregnancy specific information
            // ***         Baby/Outcome information 
            // ***         Pregnancy status 

            PregnancyHistorySection returnVal = new PregnancyHistorySection();

            // *** Check if there is something to work with ***
            if (observationList != null)
                if (observationList.Count > 0)
                    foreach (var obs in observationList)
                        if (!string.IsNullOrWhiteSpace(obs.BabyIen))
                        {
                            CdaSimpleObservation babyObs = null;
                            switch (obs.Code)
                            {
                                case "8339-4": // Birth weight
                                    obs.Unit = "g";
                                    babyObs = CdaObservationFactory.CreatePregnancyHistoryPqObservation(obs);
                                    break;
                                case "75207-1": // Stillborn
                                    babyObs = CdaObservationFactory.CreatePregnancyHistoryBoolObservation(obs);
                                    break;
                                case "9272-6": // 1 Minute APGAR
                                case "9274-2": // 5 Minute APGAR
                                    babyObs = CdaObservationFactory.CreatePregnancyHistoryIntObservation(obs);
                                    break;
                                case "32417-8": // Newborn ICU admittance diagnosis code 
                                    // TODO: To use these we need to collect DX code for NICU admit
                                    break;
                                case "45392-8": // First Name
                                case "46098-0": // Sex 
                                case "57075-4": // Newborn delivery information 
                                    babyObs = CdaObservationFactory.CreatePregnancyHistoryTextObservation(obs);
                                    break;
                                case "21112-8": // Birth Date + Time
                                    babyObs = CdaObservationFactory.CreatePregnancyHistoryDateObservation(obs);
                                    break;
                                default:
                                    // TODO: What to do with others ?
                                    break;
                            }

                            if (babyObs != null)
                                returnVal.AddBabyObservation(obs.PregnancyIen, obs.BabyNumber, babyObs);

                        }
                        else if (!string.IsNullOrWhiteSpace(obs.PregnancyIen))
                        {
                            CdaSimpleObservation pregObs = null;

                            // *** Make sure value is parsed for EDD observations ***
                            if (string.Equals(obs.Category, "EDD", StringComparison.CurrentCultureIgnoreCase))
                                obs.Value = EddUtility.GetObservationCoreValue(obs);

                            switch (obs.Code)
                            {
                                case EddUtility.EddCode: //"11778-8": // Delivery Date Estimated
                                case EddUtility.LmpDateCode: //"8665-2": // Last Menstrual Period Start Date
                                case "21112-8": // Birth Date 
                                    pregObs = CdaObservationFactory.CreatePregnancyHistoryDateObservation(obs);
                                    break;
                                case "49051-6": // GA @ Delivery in Weeks
                                    obs.Unit = "weeks";
                                    pregObs = CdaObservationFactory.CreatePregnancyHistoryPqObservation(obs);
                                    break;
                                case EddUtility.EstimatedGestationalAgeCode: //"11884-4": // Gestational Age Estimated
                                    obs.Unit = "weeks";
                                    pregObs = CdaObservationFactory.CreatePregnancyHistoryPqObservation(obs);
                                    break;
                                case "32396-9": // Length of Labor in Hours
                                    obs.Unit = "hours";
                                    pregObs = CdaObservationFactory.CreatePregnancyHistoryPqObservation(obs);
                                    break;

                                case "29300-1": // Delivery Procedure 
                                    // TODO: Need procedure code.  How to handle?
                                    break;

                                case "62330-6": // Birth Hospital Facility Name
                                case "52829-9": // Place of Service
                                    pregObs = CdaObservationFactory.CreateTextObservation(obs);
                                    break;

                                case "57071-3": // Obstetric Delivery Method
                                case "8722-1": // Surgical Operation Note Anesthesia
                                    pregObs = CdaObservationFactory.CreateTextObservation(obs);
                                    break;
                            }

                            if (pregObs != null)
                                returnVal.AddPregnancyObservation(obs.PregnancyIen, pregObs);
                        }
                        else if (obs.Category == "Pregnancy History")
                        {
                            CdaSimpleObservation histObs;
                            if (obs.CodeSystem != CodingSystem.None)
                            {
                                histObs = CdaObservationFactory.CreatePregnancyHistoryIntObservation(obs);

                                if (histObs != null)
                                {
                                    CdaSimpleObservation existing = returnVal.Observations.FirstOrDefault(o => o.Code.Code == histObs.Code.Code);

                                    if (existing == null)
                                        returnVal.Observations.Add(histObs);
                                    else if (existing.EffectiveTime.Value < histObs.EffectiveTime.Value)
                                    {
                                        returnVal.Observations.Remove(existing);
                                        returnVal.Observations.Add(histObs);
                                    }
                                }
                            }
                        }

            // *** Add pregnancy date ranges ***
            if (pregnanciesList != null)
                foreach (var preg in pregnanciesList)
                    returnVal.AddPregnancyDetails(preg.Ien, preg.StartDate, preg.EndDate, preg.Description);

            // *** Create pregnancy status observation ***
            returnVal.PregnancyStatusObservation = CdaObservationFactory.CreatePregnancyStatusObservation(patientIsPregnant);

            // *** Place pregnancy status in narrative ***
            string yesNo = (patientIsPregnant) ? "Pregnant" : "Not Pregnant";
            returnVal.Narrative = string.Format("Current Pregnancy Status: {0}", yesNo);

            return returnVal;
        }

        public static ReviewOfSystemsSection CreateReviewOfSystemsSection(List<Observation> list, ValueSet vs)
        {
            // *** Creates ROS section ***

            ReviewOfSystemsSection returnVal = new ReviewOfSystemsSection();

            // *** Check if something to work with ***
            if (list != null)
                foreach (var item in list)
                    if (item.Code == returnVal.Code) // Narrative ROS
                        returnVal.Narrative = item.Value;
                    else
                    {
                        // *** Check if exists in value set ***
                        ValueSetItem result = vs.Items.Find(r => r.Code == item.Code && r.CodeSystem == item.CodeSystem);

                        if (result != null)
                        {
                            switch (item.Code)
                            {
                                case "21840007": // LMP Date
                                case "67900009": // HCG+ Date
                                    DateTime itemDate = VistaDates.ParseDateString(item.Value, VistaDates.VistADateOnlyFormat);
                                    if (itemDate != DateTime.MinValue)
                                    {
                                        CdaSimpleObservation tempObs = CdaObservationFactory.CreateDateObservation(item);
                                        if (tempObs != null) 
                                            returnVal.MenstrualHistoryObservations.Add(tempObs);
                                    }
                                    break;
                                case "364307006": // Regularity of Menstrual Cycle
                                case "xx-onbcp": // On Birth Control Pills at Conception
                                    bool val = false;
                                    if (bool.TryParse(item.Value, out val))
                                    {
                                        CdaBoolObservation boolObs = CdaObservationFactory.CreateBoolObservation(item);
                                        if (boolObs != null) 
                                            returnVal.MenstrualHistoryObservations.Add(boolObs);
                                    }
                                    break;
                                case "364306002": // Frequency of Menstruation (Days)
                                case "398700009": // Age at menarche
                                    CdaPqObservation pqObs = CdaObservationFactory.CreatePqObservation(item);
                                    returnVal.MenstrualHistoryObservations.Add(pqObs);
                                    break;
                            }
                        }
                    }

            return returnVal;
        }

        public static CodedFamilyMedicalHistorySection CreateFamilyHistorySection(List<Observation> list, ValueSet familyHistoryValueSet)
        {
            CodedFamilyMedicalHistorySection returnVal = new CodedFamilyMedicalHistorySection();

            bool addIt = false;

            if (list != null)
                foreach (var item in list)
                {
                    addIt = false;

                    // *** Check if matching category ***
                    if (item.Category.Contains("Family Medical History"))
                        addIt = true;
                    else
                    {
                        // *** Check if exists in value set ***
                        ValueSetItem result = familyHistoryValueSet.Items.Find(r => r.Code == item.Code && r.CodeSystem == item.CodeSystem);

                        if (result != null)
                            addIt = true;
                    }

                    // *** Add if matching ***
                    if (addIt)
                    {
                        CdaCodeObservation famObservation = CdaObservationFactory.CreateFamilyHistoryObservation(item);
                        returnVal.AddObservation(famObservation.Relationship, famObservation);
                    }
                }

            if (returnVal.ObservationCount == 0)
                returnVal.UnknownObservation = CdaObservationFactory.CreateUnknownFamilyHistoryObservation();

            return returnVal;
        }

        public static CodedSocialHistorySection CreateSocialHistorySection(List<Observation> list)
        {
            // *** Creates the social history section ***

            CodedSocialHistorySection returnVal = new CodedSocialHistorySection();

            // *** PP Depression Screening, Risk of IPV ***
            string[] otherCodes = { "428221000124108", "706892001" }; 

            // *** Check if any observations are found ***
            if (list != null)
                foreach (var item in list)
                {
                    CdaSimpleObservation obsTemp = null;

                    if (item.Category.Contains("Social History"))
                    {
                        // *** Look for items containing social history ***

                        // *** Check if narrative observation based on loinc ***
                        if (item.Code == "29762-2") // Narrative LOINC code
                            returnVal.Narrative = item.Narrative;
                        else
                        {
                            string[] pqCodes = new string[] { "256235009", "229819007", "160573003" };

                            if (pqCodes.Contains(item.Code))
                                obsTemp = CdaObservationFactory.CreateSocialPqObservation(item);
                            else
                                obsTemp = CdaObservationFactory.CreateSocialCodeObservation(item);

                            if (obsTemp != null)
                                returnVal.Observations.Add(obsTemp);
                        }
                    }
                    else if (otherCodes.Contains(item.Code))
                    {
                        obsTemp = CdaObservationFactory.CreateSocialCodeObservation(item);

                        if (obsTemp != null)
                            returnVal.Observations.Add(obsTemp);
                    }
                }

            return returnVal;
        }

        public static CodedHistoryOfInfectionSection CreateHistoryOfInfectionSection(List<Observation> list, HistoryOfInfectionValueSet historyOfInfectionValueSet)
        {
            CodedHistoryOfInfectionSection returnVal = new CodedHistoryOfInfectionSection();

            // *** Get narrative observation ***
            Observation tempObs = GetSpecificObservation(list, returnVal.CodeSystem, returnVal.Code);

            if (tempObs != null)
                returnVal.Narrative = tempObs.Narrative;

            // *** Add observations to entries ***
            returnVal.Entries.Observations = GetMatchingProblemObservations(list, historyOfInfectionValueSet);

            return returnVal;
        }

        public static HistoryOfPastIllnessSection CreatePastIllnessSection(List<Observation> list, HistoryOfPastIllnessValueSet valueSet)
        {
            HistoryOfPastIllnessSection returnVal = new HistoryOfPastIllnessSection();

            // *** Get the narrative of the past illness ***
            Observation tempObs = GetSpecificObservation(list, returnVal.CodeSystem, returnVal.Code);

            if (tempObs != null)
                returnVal.Narrative = tempObs.Narrative;

            // *** Get the list of observations that match ***
            returnVal.Entries.Observations = GetMatchingProblemObservations(list, valueSet);

            if (returnVal.Entries.Observations == null || returnVal.Entries.Observations.Count == 0)
            {
                CdaCodeObservation unkObs = CdaObservationFactory.CreateUnknownProblemObservation();

                if (returnVal.Entries.Observations == null)
                    returnVal.Entries.Observations = new List<CdaCodeObservation>(); 

                returnVal.Entries.Observations.Add(unkObs);
            }

            return returnVal;
        }

        public static HistoryOfPresentIllnessSection CreatePresentIllnessSection(List<Observation> list)
        {
            HistoryOfPresentIllnessSection returnVal = new HistoryOfPresentIllnessSection();

            Observation tempObs = GetSpecificObservation(list, returnVal.CodeSystem, returnVal.Code);

            if (tempObs != null)
                returnVal.Narrative = tempObs.Narrative;

            return returnVal;
        }

        public static ChiefComplaintSection CreateChiefComplaintSection(List<Observation> list)
        {
            // *** Creates and populates the chief complaint section ***

            ChiefComplaintSection returnVal = new ChiefComplaintSection();

            Observation tempObs = GetSpecificObservation(list, returnVal.CodeSystem, returnVal.Code);

            if (tempObs != null)
                returnVal.Narrative = tempObs.Narrative;

            return returnVal;
        }

        private static Observation GetSpecificObservation(List<Observation> list, CodingSystem codeSystem, string code)
        {
            Observation returnVal = null;

            // *** Check for sometihng to work with ***
            // *** Loop through list of observations, looking for match ***

            //if (list != null)
            //    if (list.Count > 0)
            //        foreach (Observation observation in list)
            //        {
            //            if (observation.CodeSystem == codeSystem)
            //                if (observation.Code == code)
            //                {
            //                    // *** Create cda observation populate ***

            //                    //returnVal = new CdaObservation()
            //                    //{
            //                    //    Id = observation.Ien,
            //                    //    Code = new CdaCode() { Code = observation.Code, DisplayName = CodingSystemUtility.GetDescription(codeSystem) },
            //                    //    Value = observation.Value,
            //                    //    EffectiveTime = observation.ObservationDate
            //                    //};
            //                    returnVal = observation;

            //                }
            //        }

            returnVal = list.FirstOrDefault(o => o.CodeSystem == codeSystem && o.Code == code);

            return returnVal;
        }

        private static List<CdaCodeObservation> GetMatchingProblemObservations(List<Observations.Observation> observationList, ValueSet valueSet)
        {
            List<CdaCodeObservation> returnList = new List<CdaCodeObservation>();

            // *** Check for sometihng to work with ***
            // *** Loop through list of observations, looking for matches ***

            if (observationList != null)
                if (observationList.Count > 0)
                    foreach (Observations.Observation observation in observationList)
                    {
                        ValueSetItem result = valueSet.Items.Find(r => r.Code == observation.Code && r.CodeSystem == observation.CodeSystem);

                        if (result != null)
                        {
                            CdaCodeObservation tempObs = CdaObservationFactory.CreateProblemObservation(observation);

                            // *** Check for latex allergy negation ***
                            if (observation.Code == "300916003")
                                if (observation.Negation)
                                    tempObs.NegationIndicator = true;                                    

                            returnList.Add(tempObs);
                        }
                    }

            return returnList;
        }

        public static CdaAllergies CreateAllergiesSection(ReactionList reactionList)
        {
            CdaAllergies returnVal = new CdaAllergies();

            if (reactionList != null)
                if (reactionList.Allergies != null)
                    if (reactionList.Allergies.Count > 0)
                        foreach (Allergy allergy in reactionList.Allergies)
                        {
                            if (allergy.Assessment == null)
                            {
                                CdaAllergy cdaAllergy = new CdaAllergy() { Id = Guid.NewGuid().ToString() };

                                cdaAllergy.AllergyText = (allergy.ItemName == null) ? "" : allergy.ItemName.Value;

                                cdaAllergy.IntoleranceType = (allergy.AllergyType == null) ? Hl7ObservationIntoleranceType.Unknown : ObservationIntoleranceMap.GetIntoleranceType(allergy.AllergyType.Code);

                                if (allergy.DrugIngredients != null)
                                    if (allergy.DrugIngredients.Count > 0)
                                        foreach (NameElement drugIngredient in allergy.DrugIngredients)
                                            if (string.IsNullOrWhiteSpace(cdaAllergy.Substance))
                                                cdaAllergy.Substance = drugIngredient.Name;
                                            else
                                                cdaAllergy.Substance += drugIngredient.Name;

                                if (allergy.DrugClasses != null)
                                    if (allergy.DrugClasses.Count > 0)
                                        foreach (NameElement drugClass in allergy.DrugClasses)
                                            if (string.IsNullOrWhiteSpace(cdaAllergy.Substance))
                                                cdaAllergy.Substance = drugClass.Name;
                                            else
                                                cdaAllergy.Substance += drugClass.Name;

                                if (allergy.Source != null)
                                    cdaAllergy.Status = AllergyStatusMap.GetAllergyStatus(allergy.Source.Value);

                                if (allergy.Entered != null)
                                {
                                    DateTime effectiveTime = Util.GetDateTime(allergy.Entered.Value);

                                    if (cdaAllergy.Status == CdaConcernStatus.Actve)
                                        cdaAllergy.EffectiveTime = new CdaEffectiveTime() { Low = effectiveTime };
                                    else
                                        cdaAllergy.EffectiveTime = new CdaEffectiveTime() { High = effectiveTime };
                                }

                                if (!string.IsNullOrWhiteSpace(cdaAllergy.AllergyText))
                                    returnVal.Allergies.Add(cdaAllergy);
                            }
                            else if (!allergy.Assessment.Value.Equals("not done", StringComparison.CurrentCultureIgnoreCase))
                            {
                                // TODO: Add assessment not done...

                            }
                        }

            return returnVal;
        }

        //private static void UpdatePregnancyHistory(AphpDocument aphp, PregnancyHistory pregHist)
        //{
        //    if (pregHist != null)
        //        foreach (DsioObservation obs in pregHist.Observations.Values)
        //            if (!string.IsNullOrWhiteSpace(obs.Value))
        //            {
        //                DateTime tempDateTime = VistaDates.ParseDateString(obs.Date, VistaDates.VistADateFormatFour);
        //                aphp.PregnancyHistorySection.AddObservation(obs.Ien, obs.Code, obs.Description, tempDateTime, obs.Value);
        //            }
        //}

        public static CdaDocumentationOf CreateDocumentationOf()
        {
            // TODO: Get real providers that are needed 

            CdaDocumentationOf returnVal = new CdaDocumentationOf();

            ////returnVal.ServiceEventStart = new DateTime(2000, 12, 12);
            ////returnVal.ServiceEventEnd = DateTime.Now; 

            //returnVal.EffectiveTime.Low = new DateTime(2000, 12, 12);
            //returnVal.EffectiveTime.High = DateTime.Now; 

            //CdaPerformer performer = new CdaPerformer(); 
            //performer.Npi.Value = "12345";
            //performer.Address.StreetAddress1 = "123 Something"; 
            //performer.Address.City = "City"; 
            //performer.Address.State = "TX"; 
            //performer.Address.ZipCode = "32323";

            //performer.WorkPhone.Number = "8009008000";

            //performer.Provider.Name.First = "Joe"; 
            //performer.Provider.Name.Last = "Test";

            //returnVal.PerformerList.Add(performer);

            return returnVal;
        }

        public static CdaCustodian CreateCustodian(CdaProviderOrganization org)
        {
            // *** Custodian is copied from Provider Organization ***

            CdaCustodian returnVal = new CdaCustodian();

            if (org.AddressList != null)
                if (org.AddressList.Count > 0)
                    returnVal.Address = org.AddressList[0];

            returnVal.Npi = org.NPI;

            returnVal.OrganizationName = org.Name;

            if (org.TelephoneList != null)
                if (org.TelephoneList.Count > 0)
                    returnVal.PhoneNumber = org.TelephoneList[0];

            return returnVal;
        }

        public static CdaProviderOrganization CreateProviderOrganization(PatientDemographics patientDemographics, string provOrgPhone)
        {
            CdaProviderOrganization provOrg = new CdaProviderOrganization();

            if (patientDemographics != null)
                if (patientDemographics.Patient != null)
                    if (patientDemographics.Patient.Facilities != null)
                        if (patientDemographics.Patient.Facilities.Count > 0)
                        {
                            Facility fac = patientDemographics.Patient.Facilities[0];
                            provOrg.Name = fac.Name;

                            // *** NPI ***
                            provOrg.NPI = new CdaNpi() { Value = fac.Npi };

                            if (fac.Address != null)
                            {
                                CdaAddress addr = new CdaAddress();
                                addr.StreetAddress1 = fac.Address.StreetLine1;
                                addr.StreetAddress2 = fac.Address.StreetLine2;
                                addr.City = fac.Address.City;
                                addr.State = fac.Address.State;
                                addr.ZipCode = fac.Address.ZipCode;

                                addr.Use = Hl7AddressUse.WorkPlace;

                                provOrg.AddressList.Add(addr);
                            }

                            provOrg.TelephoneList.Add(new CdaTelephone() { Usage = Hl7TelephoneUsage.WorkPlace, Number = provOrgPhone });
                        }

            return provOrg;
        }

        public static CdaParticipantList CreateParticipants(VprPatientResult vprData)
        {
            CdaParticipantList returnList = CreateSupportParticipants(vprData.Demographics);

            CdaParticipantList spouseList = CreateSpouseParticipants(vprData.Participant);

            returnList.AddRange(spouseList);

            CdaParticipantList fatherList = CreateFatherParticipants(vprData.Participant);

            returnList.AddRange(fatherList);

            return returnList;
        }

        private static CdaParticipantList CreateSupportParticipants(PatientDemographics patientDemographics)
        {
            CdaParticipantList returnList = new CdaParticipantList();

            if (patientDemographics.Patient != null)
                if (patientDemographics.Patient.Supports != null)
                    if (patientDemographics.Patient.Supports.Count > 0)
                        foreach (Support sup in patientDemographics.Patient.Supports)
                        {
                            CdaParticipant newParticipant = new CdaParticipant();

                            newParticipant.RoleClass = ParticipantRoleMap.GetHl7RoleClass(sup.ContactType);

                            // *** Name ***
                            string last = Util.Piece(sup.Name, ",", 1);
                            string first = Util.Piece(sup.Name, ",", 2);

                            newParticipant.Name = new CdaName() { First = first, Last = last };

                            // *** Address ***
                            if (sup.Address != null)
                            {
                                CdaAddress addr = new CdaAddress();
                                addr.StreetAddress1 = sup.Address.StreetLine1;
                                addr.StreetAddress2 = sup.Address.StreetLine2;
                                addr.City = sup.Address.City;
                                addr.State = sup.Address.State;
                                addr.ZipCode = sup.Address.ZipCode;
                                addr.Use = Hl7AddressUse.Home;

                                newParticipant.Address = addr;
                            }

                            // *** Phone Numbers ***
                            foreach (PhoneNumber number in sup.PhoneNumbers)
                            {
                                CdaTelephone tempTel = new CdaTelephone();
                                tempTel.Number = number.Value;
                                tempTel.Usage = TelephoneUsageMap.GetHl7TelephoneUsage(number.UsageType);

                                newParticipant.PhoneNumbers.Add(tempTel);

                            }

                            returnList.Add(newParticipant);
                        }

            return returnList;
        }

        private static CdaParticipantList CreateSpouseParticipants(Family vprFamily)
        {
            CdaParticipantList returnList = new CdaParticipantList();

            if (vprFamily != null)
                if (vprFamily.PatientFamily != null)
                    if (vprFamily.PatientFamily.FamilyMembers != null)
                        if (vprFamily.PatientFamily.FamilyMembers.Count > 0)
                            foreach (FamilyMember member in vprFamily.PatientFamily.FamilyMembers)
                            {
                                IheParticipant newParticipant = GetCdaParticipant(member);

                                if (newParticipant.ParticipantType == IheParticipantType.Spouse)
                                    returnList.Add(newParticipant);
                            }

            if (returnList.Count == 0)
            {
                IheParticipant unknownSpouse = new IheParticipant() { ParticipantType = IheParticipantType.Spouse, RoleClass = Hl7RoleClass.PersonalRelationship };
                returnList.Add(unknownSpouse);
            }

            return returnList;
        }

        private static CdaParticipantList CreateFatherParticipants(Family vprFamily)
        {
            CdaParticipantList returnList = new CdaParticipantList();

            if (vprFamily != null)
                if (vprFamily.PatientFamily != null)
                    if (vprFamily.PatientFamily.FathersOfFetus != null)
                        if (vprFamily.PatientFamily.FathersOfFetus.Count > 0)
                            foreach (VA.Gov.Artemis.Commands.Vpr.Data.FatherOfFetus father in vprFamily.PatientFamily.FathersOfFetus)
                            {
                                CdaParticipant newParticipant = GetCdaParticipant(father);

                                returnList.Add(newParticipant);
                            }

            if (returnList.Count == 0)
            {
                IheParticipant unknownFather = new IheParticipant() { ParticipantType = IheParticipantType.FatherOfFetus, RoleClass = Hl7RoleClass.PersonalRelationship };
                returnList.Add(unknownFather);
            }

            return returnList;
        }

        private static IheParticipant GetCdaParticipant(FamilyMember member)
        {
            IheParticipant newParticipant;

            Hl7RoleClass tempRoleClass = ParticipantRoleMap.GetHl7RoleClass(member.Relationship);

            if (tempRoleClass == Hl7RoleClass.PersonalRelationship)
            {
                IheParticipant tempPart = new IheParticipant();

                switch (member.Relationship.ToUpper())
                {
                    case "SPOUSE":
                        tempPart.ParticipantType = IheParticipantType.Spouse;
                        break;
                    case "FOF":
                        tempPart.ParticipantType = IheParticipantType.FatherOfFetus;
                        break;
                }

                newParticipant = tempPart;
            }
            else
                newParticipant = new IheParticipant();

            newParticipant.RoleClass = tempRoleClass;

            // *** Name ***
            string last = Util.Piece(member.Name, ",", 1);
            string first = Util.Piece(member.Name, ",", 2);

            newParticipant.Name = new CdaName() { First = first, Last = last };

            // *** Address ***
            if (member.Address != null)
            {
                CdaAddress addr = new CdaAddress();
                addr.StreetAddress1 = member.Address.StreetLine1;
                addr.StreetAddress2 = member.Address.StreetLine2;
                addr.City = member.Address.City;
                addr.State = member.Address.State;
                addr.ZipCode = member.Address.ZipCode;
                addr.Use = Hl7AddressUse.Home;

                newParticipant.Address = addr;
            }

            // *** Phone Numbers ***            
            foreach (PhoneNumber number in member.PhoneNumbers)
            {
                CdaTelephone tempTel = new CdaTelephone();
                tempTel.Number = number.Value;
                tempTel.Usage = TelephoneUsageMap.GetHl7TelephoneUsage(number.UsageType);

                newParticipant.PhoneNumbers.Add(tempTel);
            }

            if (newParticipant.PhoneNumbers.Count == 0)
                newParticipant.PhoneNumbers.Add(new CdaTelephone() { NullFlavor = "UNK" });

            return newParticipant;
        }

        public static CdaRecordTarget CreateLabRecordTarget(PatientDemographics result)
        {
            CdaRecordTarget recordTarget = CdaSectionFactory.CreateRecordTarget(result);

            recordTarget.TemplateIds.AddId("1.3.6.1.4.1.19376.1.3.3.1.3"); 

            return recordTarget;
        }

        public static CdaRecordTarget CreateRecordTarget(PatientDemographics result)
        {
            CdaRecordTarget recordTarget = new CdaRecordTarget();

            if (result != null)
                if (result.Patient != null)
                {
                    // *** Last Name ***
                    if (result.Patient.LastName != null)
                        recordTarget.Patient.Name.Last = result.Patient.LastName.Value;

                    // *** First Name ***
                    if (result.Patient.FirstName != null)
                        recordTarget.Patient.Name.First = result.Patient.FirstName.Value;

                    // *** Gender ***
                    if (result.Patient.Gender != null)
                        recordTarget.Patient.Gender = GenderMap.GetHl7Gender(result.Patient.Gender.Value);

                    // *** SSN ***
                    if (result.Patient.SocialSecurityNumber != null)
                    {
                        string temp = result.Patient.SocialSecurityNumber.Value;

                        if (result.Patient.SocialSecurityNumber.Value != null)
                            if (temp.Length == 9)
                                temp = string.Format("{0}-{1}-{2}", temp.Substring(0, 3), temp.Substring(3, 2), temp.Substring(5, 4));

                        recordTarget.SSN = temp;
                    }

                    // *** DOB ***
                    if (result.Patient.DateOfBirth != null)
                        recordTarget.Patient.DateOfBirth = Util.GetDateTime(result.Patient.DateOfBirth.Value);

                    // *** Address ***
                    if (result.Patient.Address != null)
                    {
                        CdaAddress addr = new CdaAddress();
                        addr.StreetAddress1 = result.Patient.Address.StreetLine1;
                        addr.StreetAddress2 = result.Patient.Address.StreetLine2;
                        addr.City = result.Patient.Address.City;
                        addr.State = result.Patient.Address.State;
                        addr.ZipCode = result.Patient.Address.ZipCode;
                        addr.Use = Hl7AddressUse.Home;

                        recordTarget.PatientAddressList.Add(addr);
                    }

                    // *** Phone Numbers ***
                    foreach (PhoneNumber number in result.Patient.PhoneNumbers)
                    {
                        CdaTelephone tempTel = new CdaTelephone();
                        tempTel.Number = number.Value;
                        tempTel.Usage = TelephoneUsageMap.GetHl7TelephoneUsage(number.UsageType);

                        recordTarget.PatientTelephoneList.Add(tempTel);
                    }

                    // *** Marital Status ***
                    if (result.Patient.MaritalStatus != null)
                        recordTarget.Patient.MaritalStatus = MaritalStatusMap.GetHl7MaritalStatus(result.Patient.MaritalStatus.Value);

                    // *** Ethnicity ***
                    if (result.Patient.Ethnicities != null)
                        if (result.Patient.Ethnicities.Count > 0)
                            recordTarget.Patient.EthnicGroup = EthnicGroupMap.GetHl7EthnicGroup(result.Patient.Ethnicities[0].Value);

                    // *** Race ***
                    if (result.Patient.Races != null)
                        if (result.Patient.Races.Count > 0)
                            recordTarget.Patient.Race = RaceMap.GetHl7Race(result.Patient.Races[0].Value);

                    // *** Religion Not Required (TODO IF TIME) ***
                    //if (result.Patient.Religion != null)
                    //    recordTarget.Patient.Religion = ReligionMap.GetHl7Religion(result.Patient.Religion.Value); 

                }

            return recordTarget;
        }

        public static CdaProviderAuthor CreateAuthor(VprPatientResult vprData)
        {
            // *** Creates a cdaAuthor from the vpr data ***

            CdaProviderAuthor providerAuthor = new CdaProviderAuthor();

            // *** Check that we have something to work with ***
            if (vprData.Author != null)
                if (vprData.Author.CurrentUser != null)
                {
                    // *** Create a current user ***
                    CurrentUser usr = vprData.Author.CurrentUser;

                    // *** Address ***
                    if (usr.Address != null)
                    {
                        providerAuthor.AssignedPerson.Address.StreetAddress1 = usr.Address.StreetLine1;
                        providerAuthor.AssignedPerson.Address.StreetAddress2 = usr.Address.StreetLine2;
                        providerAuthor.AssignedPerson.Address.City = usr.Address.City;
                        providerAuthor.AssignedPerson.Address.State = usr.Address.State;
                        providerAuthor.AssignedPerson.Address.ZipCode = usr.Address.ZipCode;
                        providerAuthor.AssignedPerson.Address.Use = Hl7AddressUse.WorkPlace;
                    }

                    // *** Parse Name ***
                    if (usr.Name != null)
                    {
                        providerAuthor.AssignedPerson.Person.Name.First = Util.Piece(usr.Name.Value, ",", 2);
                        providerAuthor.AssignedPerson.Person.Name.Last = Util.Piece(usr.Name.Value, ",", 1);
                    }

                    // *** Phone Number ***
                    foreach (PhoneNumber pNum in usr.PhoneNumbers)
                    {
                        CdaTelephone tel = new CdaTelephone();
                        tel.Number = pNum.Value;
                        tel.Usage = TelephoneUsageMap.GetHl7TelephoneUsage(pNum.UsageType);

                        providerAuthor.AssignedPerson.TelephoneList.Add(tel);
                    }

                    // *** Npi ***
                    if (usr.Npi != null)
                        providerAuthor.AssignedPerson.NPI.Value = usr.Npi.Value;

                }


            return providerAuthor;
        }

        public static MedicationsSection CreateMedicationSection(List<Medication> list)
        {
            MedicationsSection returnVal = new MedicationsSection();

            foreach (Medication med in list)
            {
                CdaMedication temp = new CdaMedication();
                //{
                //     Description = med.Products[0].Name, 
                //     Start = med.Start.ToDateTime(), 
                //     Stop = med.Stop.ToDateTime()
                //};

                temp.Id = Guid.NewGuid().ToString();

                if (med.Products != null)
                    if (med.Products.Count > 0)
                        temp.Description = med.Products[0].Name;

                if (string.IsNullOrWhiteSpace(temp.Description))
                    temp.Description = "Unknown Medication";

                temp.EffectiveTime = new CdaEffectiveTime();

                if (med.Start != null)
                    temp.EffectiveTime.Low = med.Start.ToDateTime();

                if (med.Stop != null)
                    temp.EffectiveTime.High = med.Stop.ToDateTime();

                if (med.Products != null)
                    if (med.Products.Count > 0)
                        if (med.Products[0].VaGeneric != null)
                        {
                            ProductElement prod = med.Products[0].VaGeneric;

                            temp.ProductCode = new CdaCode()
                            {
                                Code = prod.VuId,
                                DisplayName = prod.Name,
                                CodeSystem = CodingSystem.Vha,
                                Reference = temp.ReferenceId
                            };

                            returnVal.Medications.Add(temp);
                        }

            }

            if (returnVal.Medications.Count == 0)
            {
                CdaCode code = new CdaCode() { Code = "182904002", CodeSystem = CodingSystem.SnomedCT, DisplayName = "Drug Treatment Unknown" };

                CdaMedication med = new CdaMedication()
                {
                    Description = code.DisplayName,
                    ProductCode = code,
                    EffectiveTime = new CdaEffectiveTime() { Value = DateTime.Now },
                    Id = Guid.NewGuid().ToString()
                };

                med.ProductCode.Reference = med.ReferenceId; 

                returnVal.Medications.Add(med); 
            }

            return returnVal;
        }

        public static AdvanceDirectiveSection CreateAdvanceDirectivesSection(List<Observation> list)
        {
            AdvanceDirectiveSection returnVal = new AdvanceDirectiveSection();

            Observation obs = list.FirstOrDefault(o => o.Code == "(xx-bld-transf-ok)");

            if (obs != null)
            {
                CdaBoolObservation bloodObservation = CdaObservationFactory.CreateAdvanceDirectiveObservation(obs);

                returnVal.Observations.Add(bloodObservation);
            }

            return returnVal;
        }

        public static CarePlanSection CreateApsCarePlanSection(List<Observation> list)
        {
            CarePlanSection returnVal = new CarePlanSection();

            Observation obs = list.FirstOrDefault(o => o.Code == "(xx-anest-cons-pland)");

            if (obs != null)
            {
                CdaBoolObservation boolObs = CdaObservationFactory.CreateBoolObservation(obs);
                if (boolObs != null)
                {
                    boolObs.EffectiveTime = new CdaEffectiveTime() { Value = obs.EntryDate };
                    returnVal.Observations.Add(boolObs);
                }
            }

            obs = list.FirstOrDefault(o => o.Code == "(xx-type-of-anesth-pland)");

            if (obs != null)
            {
                CdaTextObservation textObs = CdaObservationFactory.CreateTextObservation(obs);
                textObs.EffectiveTime = new CdaEffectiveTime() { Value = obs.EntryDate };
                returnVal.Observations.Add(textObs);
            }

            return returnVal;
        }

        public static ProblemsSection CreateProblemsSection(List<Observation> list, ProblemList problemList)
        {
            ProblemsSection returnVal = new ProblemsSection();

            // *** Get the narrative of the past illness ***
            Observation tempObs = GetSpecificObservation(list, returnVal.CodeSystem, returnVal.Code);

            if (tempObs != null)
                returnVal.Narrative = tempObs.Narrative;

            // *** Get the list of observations that match ***
            returnVal.Entries.Observations = GetActiveProblemObservations(problemList);

            return returnVal;
        }

        private static List<CdaCodeObservation> GetActiveProblemObservations(ProblemList problemList)
        {
            List<CdaCodeObservation> returnList = new List<CdaCodeObservation>();

            // *** Check for sometihng to work with ***
            // *** Loop through list of observations, looking for matches ***

            if (problemList != null)
                if (problemList.Problems.Count > 0)
                    foreach (Problem problem in problemList.Problems)
                    {
                        if (problem.Status.Code.Equals("a", StringComparison.CurrentCultureIgnoreCase))
                        {
                            CdaCodeObservation tempObs = CdaObservationFactory.CreateProblemObservation(problem);

                            returnList.Add(tempObs);
                        }
                    }

            if (returnList.Count == 0)
            {
                Observation obs = new Observation() { Code = "160245001", CodeSystem = CodingSystem.SnomedCT, Description = "No current problems or disability" };

                CdaCodeObservation tempObs = CdaObservationFactory.CreateProblemObservation(obs); 

                returnList.Add(tempObs);            
            }

            return returnList;
        }

        internal static EstimatedDeliveryDatesSection CreateEddSection(List<Observation> list)
        {
            EstimatedDeliveryDatesSection returnVal = new EstimatedDeliveryDatesSection();

            IEnumerable<Observation> eddObservations = list
                .Where(o => o.Category == "EDD");

            // *** Get one of each ***
            Dictionary<string, Observation> eddDictionary = new Dictionary<string, Observation>();

            foreach (Observation obs in eddObservations)
                if (!eddDictionary.ContainsKey(obs.Code))
                    eddDictionary.Add(obs.Code, obs);
                else if (eddDictionary[obs.Code].EntryDate < obs.EntryDate)
                    eddDictionary[obs.Code] = obs; 

            // *** Create empty top observation ***
            returnVal.EstimatedDeliveryDate = CdaObservationFactory.CreateEddObservation(); 

            // *** 
            // *** Loop adding ***
            foreach (string key in eddDictionary.Keys) 
            {
                Observation tempObs = eddDictionary[key];

                CdaDateObservation supportingObs = new CdaDateObservation();
                supportingObs.Id = Guid.NewGuid().ToString();
                supportingObs.Status = Hl7ProblemActStatus.completed;
                supportingObs.EffectiveTime = new CdaEffectiveTime() { Value = tempObs.EntryDate };

                string valPiece1 = Util.Piece(tempObs.Value, "|", 1);
                string valPiece2 = Util.Piece(tempObs.Value, "|", 2);
                string valPiece3 = Util.Piece(tempObs.Value, "|", 3);

                bool isFinal = false;
                bool.TryParse(valPiece2, out isFinal);
                
                switch (tempObs.Code)
                {
                    case EddUtility.EddFromLMPCode: //"11779-6": // EDD from LMP

                        // *** Create EDD from LMP supporting observation ***
                        supportingObs.Code = new CdaCode() { Code = tempObs.Code, CodeSystem =  CodingSystem.Loinc, DisplayName = tempObs.Description };
                        supportingObs.Value = VistaDates.ParseDateString(valPiece1, VistaDates.VistADateOnlyFormat);

                        // *** Create LMP observation ***
                        CdaDateObservation lmpObs = new CdaDateObservation();
                        lmpObs.Id = Guid.NewGuid().ToString();
                        lmpObs.Status = Hl7ProblemActStatus.completed;
                        //lmpObs.Code = new CdaCode() { CodeSystem = CodingSystem.Loinc, Code = "8665-2", DisplayName = "Last Menstrual Period" };
                        lmpObs.Code = new CdaCode() { CodeSystem = CodingSystem.Loinc, Code = EddUtility.LmpDateCode, DisplayName = "Last Menstrual Period" };
                        string lmp = EddUtility.GetLmpFromEdd(valPiece1);
                        lmpObs.Value = VistaDates.ParseDateString(lmp, VistaDates.VistADateOnlyFormat);
                        lmpObs.EffectiveTime = new CdaEffectiveTime() { High = tempObs.EntryDate };

                        // *** Add LMP obs as supporting ***
                        supportingObs.SupportingObservations.Add(lmpObs);

                        break; 

                    case EddUtility.EstimatedGestationalAgeCode: // "11884-4": // GA
                    case "OtherEdd":
                        
                        // *** Create EDD obs ***
                        supportingObs.Code = new CdaCode() { Code = EddUtility.IheOtherEDDCode, CodeSystem = CodingSystem.Loinc, DisplayName = "EDD from Physician Exam" };
                        string edd = EddUtility.GetEddFromGA(valPiece1, valPiece3);
                        supportingObs.Value = VistaDates.ParseDateString(edd, VistaDates.VistADateOnlyFormat);

                        DateTime on = VistaDates.ParseDateString(valPiece1, VistaDates.VistADateOnlyFormat);
                        if (on != DateTime.MinValue)
                        {
                            // *** Create GA observation ***
                            CdaPqObservation gaObs = new CdaPqObservation();
                            gaObs.Id = Guid.NewGuid().ToString();
                            gaObs.Status = Hl7ProblemActStatus.completed;
                            gaObs.Code = new CdaCode() { CodeSystem = tempObs.CodeSystem, Code = tempObs.Code, DisplayName = tempObs.Description };
                            gaObs.Value = valPiece3;
                            gaObs.Unit = "days";
                            gaObs.EffectiveTime = new CdaEffectiveTime() { High = on };

                            // *** Add GA obs to supporting ***
                            supportingObs.SupportingObservations.Add(gaObs);
                        }

                        break; 

                    case EddUtility.EddCode: // "11778-8": // EDD 

                        // *** Create EDD obs ***
                        supportingObs.Code = new CdaCode() { Code = EddUtility.IheOtherEDDCode, CodeSystem = CodingSystem.Loinc, DisplayName = "EDD from Physician Exam" };
                        supportingObs.Value = VistaDates.ParseDateString(valPiece1, VistaDates.VistADateOnlyFormat);

                        break; 

                    default:

                        EddItemType itemType = EddUtility.GetItemType(tempObs.Code);

                        supportingObs.Code = new CdaCode() { Code = EddUtility.IheOtherEDDCode, CodeSystem = CodingSystem.Loinc, DisplayName = "EDD from Physician Exam" };
                        string edd2 = EddUtility.GetEddFromDate(itemType, valPiece1);
                        supportingObs.Value = VistaDates.ParseDateString(edd2, VistaDates.VistADateOnlyFormat);

                        // *** Create level 2 observation ***
                        CdaDateObservation dateObs = new CdaDateObservation();
                        dateObs.Id = Guid.NewGuid().ToString();
                        dateObs.Status = Hl7ProblemActStatus.completed;
                        dateObs.Code = new CdaCode() { CodeSystem = CodingSystem.Loinc, Code = tempObs.Code, DisplayName = tempObs.Description };                        
                        dateObs.Value = VistaDates.ParseDateString(valPiece1, VistaDates.VistADateOnlyFormat);
                        dateObs.EffectiveTime = new CdaEffectiveTime() { High = tempObs.EntryDate };

                        break; 
                }

                // *** Add supporting to supporting ***
                returnVal.EstimatedDeliveryDate.SupportingObservations.Add(supportingObs);

                // *** If final, update EDD and Author ***
                if (isFinal)
                {
                    returnVal.EstimatedDeliveryDate.Value = supportingObs.Value;
                    returnVal.EstimatedDeliveryDate.Author = CdaSectionFactory.CreateAuthor(tempObs.EnteredBy, tempObs.EntryDate);
                    returnVal.EstimatedDeliveryDate.EffectiveTime = new CdaEffectiveTime() { Value = tempObs.EntryDate };
                }

            }

            return returnVal; 
        }

        private static CdaProviderAuthor CreateAuthor(string providerName, DateTime obsDate)
        {
            CdaProviderAuthor returnVal = new CdaProviderAuthor()
            {
                AssignedPerson = new CdaAssignedPerson()
                {
                    Person = new CdaPerson()
                    {
                        Name = new CdaName()
                        {
                            First = Util.Piece(providerName, ",", 2),
                            Last = Util.Piece(providerName, ",", 1)
                        }
                    }
                },
                Time = obsDate
            };

            return returnVal; 
        }

        internal static AntepartumVisitSummarySection CreateVisitSummarySection(List<Observation> list)
        {
            AntepartumVisitSummarySection returnVal = new AntepartumVisitSummarySection();

            list = list.OrderBy(o => o.ExamDate).ToList(); 

            foreach (var item in list)
                switch (item.Code)
                {
                    case "8348-5": // Pre-Pregnancy Weight
                        returnVal.PrepregnancyWeight = CdaObservationFactory.CreatePqObservation(item);
                        break;

                    case "11884-4": // PQ
                    case "57067-1":
                    case "11727-5":
                    case "11881-0":
                    case "11709-7":
                    case "11785-3":
                    case "11867-9":
                    case "11961-0":
                    case "8480-6":
                    case "8462-4":
                    case "3141-9":
                    case "57070-5":
                        CdaPqObservation pqObs = CdaObservationFactory.CreatePqObservation(item);
                        if (pqObs != null)
                        {
                            pqObs.EffectiveTime = new CdaEffectiveTime() { High = item.ExamDate };
                            returnVal.Organizer.Observations.Add(pqObs);
                        }
                        break;

                    case "57088-7": // CO
                    case "1753-3":
                    case "2349-9":
                    case "25428-4":
                    case "44966-0":
                    case "38208-5":
                    case "11876-0": // CD
                    case "11877-8":
                        CdaCodeObservation cdObs = CdaObservationFactory.CreateVisitSummaryCodeObservation(item); 
                        if (cdObs != null) 
                        {
                            cdObs.EffectiveTime = new CdaEffectiveTime() { High = item.ExamDate };
                            returnVal.Organizer.Observations.Add(cdObs);
                        }
                        break;

                    case "57069-7": // BL
                        CdaBoolObservation blObs = CdaObservationFactory.CreateBoolObservation(item);
                        if (blObs != null)
                        {
                            blObs.EffectiveTime = new CdaEffectiveTime() { High = item.ExamDate };
                            returnVal.Organizer.Observations.Add(blObs);
                        }
                        break;

                    case "48767-8": // ED
                        CdaTextObservation edObs = CdaObservationFactory.CreateTextObservation(item);
                        if (edObs != null) 
                        {
                            edObs.EffectiveTime = new CdaEffectiveTime() { High = item.ExamDate };
                            returnVal.Organizer.Observations.Add(edObs);
                        }
                        break;
                }

            return returnVal;
        }

        internal static PatientEducationSection CreateEducationSection(CdaSource cdaSource)
        {
            PatientEducationSection returnSection = new PatientEducationSection();

            StringBuilder sb = new StringBuilder();

            ValueSet vs;
            if (cdaSource.ValueSets.TryGetValue(ValueSetType.AntepartumEducation, out vs))
            {

                if (cdaSource.EducationItems != null)
                    foreach (var item in cdaSource.EducationItems)
                    {
                        ValueSetItem match = vs.Items.FirstOrDefault(i => i.CodeSystem == item.CodingSystem && i.Code == item.Code);

                        if (match != null)
                        {

                            CdaProcedure proc = new CdaProcedure(item.CompletedOn, item.CodingSystem, item.Code, item.Description);

                            returnSection.Procedures.Add(proc);
                        }
                    }

                if (cdaSource.Observations != null)
                {

                    foreach (var obs in cdaSource.Observations)
                    {
                        ValueSetItem match = vs.Items.FirstOrDefault(i => i.CodeSystem == obs.CodeSystem && i.Code == obs.Code);

                        if (match != null)
                        {
                            CdaProcedure proc = new CdaProcedure(obs.EntryDate, obs.CodeSystem, obs.Code, obs.Description);

                            returnSection.Procedures.Add(proc);
                        }
                    }
                }
            }

            return returnSection; 
        }

        internal static List<LabResultsSection> CreateLabSections(VprPatientResult vprPatientResult)
        {
            List<LabResultsSection> returnList = new List<LabResultsSection>();

            // *** Create a dictionary ***
            Dictionary<string, LabResultsSection> labDictionary = new Dictionary<string, LabResultsSection>();

            // *** Loop through labs ***
            foreach (var item in vprPatientResult.Labs)
            {
                // *** Check if this is a new group or not ***
                if (!labDictionary.ContainsKey(item.GroupName.Value))
                {
                    // *** New group ***

                    LabResultsSection section = new LabResultsSection(); 
                
                    // *** Get the section code ***
                    CdaCode sectionCode = CdaUtility.GetLabSectionCode(item.GroupName.Value);

                    // *** Set the section code ***
                    section.Code = sectionCode;

                    VprDateTime collected = new VprDateTime() { Value = item.Collected.Value };
                    
                    // *** Set title ***
                    section.SectionTitle = string.Format("{0}: {1}", sectionCode.DisplayName, collected.ToDateTime().ToShortDateString());

                    section.Narrative = string.Format("Specimen: {0} Collected: {1}", item.Specimen.Name, collected.ToDateTime()); 

                    // *** Add to dictionary ***
                    labDictionary.Add(item.GroupName.Value, section);
                }

                // *** Get the lab observation ***
                CdaPqObservation obs = CdaObservationFactory.CreateLabObservation(item); 

                // *** Add observation *** 
                labDictionary[item.GroupName.Value].LabObservations.Add(obs); 
            }

            return labDictionary.Values.ToList(); 
        }

        internal static CarePlanSection CreateCarePlanSection(List<Observation> list)
        {
            CarePlanSection returnVal = new CarePlanSection(); 

            List<Observation> stati = list.Where(o => o.Code == "61145-9" && o.CodeSystem == CodingSystem.Loinc).ToList();

            Observation mostRecent = null; 

            foreach (var item in stati)
            {
                if (string.IsNullOrWhiteSpace(item.BabyIen))
                    if (mostRecent == null)
                        mostRecent = item;
                    else if (mostRecent.EntryDate < item.EntryDate)
                        mostRecent = item; 
            }

            if (mostRecent != null)
                returnVal.Narrative = mostRecent.Narrative;

            return returnVal;
        }

        internal static Dictionary<string, NewbornStatusSection> CreateNewbornStatusSections(List<Observation> list)
        {
            Dictionary<string, NewbornStatusSection> returnVal = new Dictionary<string, NewbornStatusSection>();

            List<Observation> stati = list.Where(o => o.Code == "57077-0" && o.CodeSystem == CodingSystem.Loinc).ToList();

            foreach (var item in stati)
            {
                NewbornStatusSection section = new NewbornStatusSection() { Narrative = item.Narrative };

                returnVal.Add(item.BabyIen.ToString(), section); 
            }

            return returnVal; 
        }

        internal static Dictionary<string, NewbornCarePlanSection> CreateNewbornCarePlanSections(List<Observation> list)
        {
            Dictionary<string, NewbornCarePlanSection> returnVal = new Dictionary<string, NewbornCarePlanSection>();

            //List<Observation> stati = list.Where(o => o.Code == "61145-9" && o.CodeSystem == CodingSystem.Loinc).ToList();

            //foreach (var item in stati)
            //{
            //    if (!string.IsNullOrWhiteSpace(item.BabyIen))
            //    {
            //        NewbornCarePlanSection section = new NewbornCarePlanSection() { Narrative = item.Narrative, BabyNumber = item.BabyNumber };

            //        returnVal.Add(item.BabyIen.ToString(), section);
            //    }
            //}

            foreach (var obs in list)
            {
                if (!string.IsNullOrWhiteSpace(obs.BabyIen))
                {
                    string key = obs.BabyIen;

                    switch (obs.Code)
                    {
                        case "61145-9":

                            if (!returnVal.ContainsKey(key))
                            {
                                NewbornCarePlanSection section = new NewbornCarePlanSection() { BabyNumber = obs.BabyNumber };
                                returnVal.Add(obs.BabyIen.ToString(), section);
                            }

                            returnVal[key].Narrative = obs.Narrative;

                            break;

                        case "18711-2":

                            if (!string.IsNullOrWhiteSpace(obs.Value))
                            {
                                if (!returnVal.ContainsKey(key))
                                {
                                    NewbornCarePlanSection section = new NewbornCarePlanSection() { BabyNumber = obs.BabyNumber };
                                    returnVal.Add(obs.BabyIen.ToString(), section);
                                }

                                returnVal[key].PediatricianName = obs.Value;
                            }

                            break;
                    }
                }
            }

            return returnVal; 
        }

        internal static Dictionary<string, NewbornDeliveryInfoSection> CreateNewbornDeliveryInfoSections(List<Observation> list)
        {
            Dictionary<string, NewbornDeliveryInfoSection> returnVal = new Dictionary<string, NewbornDeliveryInfoSection>();

            foreach (var obs in list)
            {
                if (!string.IsNullOrWhiteSpace(obs.BabyNumber))
                {
                    CdaSimpleObservation babyObs = null;
                    switch (obs.Code)
                    {
                        case "8339-4": // Birth weight
                            obs.Unit = "g";
                            babyObs = CdaObservationFactory.CreatePregnancyHistoryPqObservation(obs);
                            break;
                        case "75207-1": // Stillborn
                            babyObs = CdaObservationFactory.CreatePregnancyHistoryBoolObservation(obs);
                            break;
                        case "9272-6": // 1 Minute APGAR
                        case "9274-2": // 5 Minute APGAR
                            babyObs = CdaObservationFactory.CreatePregnancyHistoryIntObservation(obs);
                            break;
                        case "32417-8": // Newborn ICU admittance diagnosis code 
                            // TODO: To use these we need to collect DX code for NICU admit
                            break;
                        case "45392-8": // First Name
                        case "46098-0": // Sex 
                        case "57075-4": // Newborn delivery information 
                        case "29545-1":
                            babyObs = CdaObservationFactory.CreatePregnancyHistoryTextObservation(obs);
                            break;

                        case "9554-3": // Procedures

                            if (!returnVal.ContainsKey(obs.BabyNumber))
                                returnVal.Add(obs.BabyNumber, new NewbornDeliveryInfoSection() { BabyNumber = obs.BabyNumber });

                            returnVal[obs.BabyNumber].ProceduresInterventions.Narrative = obs.Narrative; 

                            break; 

                        case "72310004": // Circumcision
                            babyObs = CdaObservationFactory.CreateTextObservation(obs); 

                            if (babyObs != null)
                            {
                                if (!returnVal.ContainsKey(obs.BabyNumber))
                                    returnVal.Add(obs.BabyNumber, new NewbornDeliveryInfoSection() { BabyNumber = obs.BabyNumber });

                                returnVal[obs.BabyNumber].ProceduresInterventions.Observations.Add(babyObs);

                                // Make sure it does not get added again below..
                                babyObs = null; 
                            }

                            break; 
                    }

                    if (babyObs != null)
                    {
                        if (!returnVal.ContainsKey(obs.BabyNumber))
                            returnVal.Add(obs.BabyNumber, new NewbornDeliveryInfoSection() { BabyNumber = obs.BabyNumber });

                        returnVal[obs.BabyNumber].PhysicalExam.Subsections["10210-3"].Observations.Add(babyObs);
                    }
                }
            }

            return returnVal; 
        }

        internal static LaborDeliveryEventsSection CreateLaborDeliverySection(List<Observation> list)
        {
            LaborDeliveryEventsSection returnVal = new LaborDeliveryEventsSection();

            //string[] obsCodes = { "75092-7", "62330-6", "52526-1", "412726003" };

            foreach (var obs in list)
            {
                CdaSimpleObservation addObs = null;

                switch (obs.Code)
                {
                    case "46503-9": // Maternal Discharge Date
                    case "75092-7": // Delivery Date 
                        addObs = CdaObservationFactory.CreateDateObservation(obs);
                        if (addObs != null) 
                            addObs.EffectiveTime = new CdaEffectiveTime() { High = obs.EntryDate }; 
                        break;

                    case "198609003": // Complications
                    case "52526-1": // Attending Physician 
                    case "62330-6": // Delivery Facility 
                    case "57071-3": // Obstetric Delivery Method
                        addObs = CdaObservationFactory.CreateTextObservation(obs);
                        break;

                    case "412726003": // GA at birth
                        int totalDays;
                        if (int.TryParse(obs.Value, out totalDays))
                        {
                            obs.Unit = "weeks";
                            int weeks = (int)totalDays / 7;
                            obs.Value = weeks.ToString(); 
                            addObs = CdaObservationFactory.CreatePqObservation(obs);
                        }
                        break;

                    case "11636-8": // Number of births (live)
                        addObs = CdaObservationFactory.CreateIntObservation(obs); 
                        break;
                }

                if (addObs != null)
                    returnVal.Observations.Add(addObs);
            }

            return returnVal; 
        }

        internal static PostpartumHospitalizationTreatmentSection CreatePostpartumHospitalizationTreatmentSection(List<Observation> list)
        {
            PostpartumHospitalizationTreatmentSection returnVal = new PostpartumHospitalizationTreatmentSection();

            Observation tempObs = list.FirstOrDefault(o => o.Code == "57076-2");

            if (tempObs != null)
                returnVal.Narrative = tempObs.Narrative;

            tempObs = list.FirstOrDefault(o => o.Code == "29554-3");

            if (tempObs != null)
                returnVal.ProceduresInterventionsSection.Narrative = tempObs.Narrative;

            tempObs = list.FirstOrDefault(o => o.Code == "42344-2");

            if (tempObs != null)
                returnVal.DischargeDietSection.Narrative = tempObs.Narrative; 
            
            return returnVal; 
        }
    }
}
