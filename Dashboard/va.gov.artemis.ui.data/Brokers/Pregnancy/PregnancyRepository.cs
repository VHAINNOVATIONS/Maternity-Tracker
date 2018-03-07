// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using VA.Gov.Artemis.Commands.Dsio;
using VA.Gov.Artemis.Commands.Dsio.Base;
using VA.Gov.Artemis.Commands.Dsio.Observation;
using VA.Gov.Artemis.Commands.Dsio.Pregnancy;
using VA.Gov.Artemis.UI.Data.Brokers.Common;
using VA.Gov.Artemis.UI.Data.Brokers.Observations;
using VA.Gov.Artemis.UI.Data.Models.Common;
using VA.Gov.Artemis.UI.Data.Models.Observations;
using VA.Gov.Artemis.UI.Data.Models.Pregnancy;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.UI.Data.Brokers.Pregnancy
{
    public class PregnancyRepository : RepositoryBase, IPregnancyRepository
    {
        public PregnancyRepository(IRpcBroker newBroker) : base(newBroker)
        {

        }

        public IenResult SavePerson(string patientDfn, Person person)
        {
            // *** Performs operations to save the FOF ***

            IenResult result = new IenResult();

            if (this.broker != null)
            {
                // *** Create the command ***

                DsioSavePersonCommand command = new DsioSavePersonCommand(this.broker);

                // *** Get the linked person ***
                DsioLinkedPerson dsioFof = GetDsioPerson(patientDfn, person);

                // *** Add as argument ***
                command.AddCommandArguments(dsioFof);

                // *** Execute command ***
                RpcResponse response = command.Execute();

                // *** Set return values ***
                result.Success = (response.Status == RpcResponseStatus.Success);
                result.Message = response.InformationalMessage;

                if (result.Success)
                    result.Ien = command.Ien;
            }

            return result;
        }

        public PersonListResult GetPersons(string patientDfn, string personIen)
        {
            // *** Get a person or list of persons associated with a patient ***

            // *** Leave personIen empty to get a list of all associated persons ***

            PersonListResult result = new PersonListResult();

            // *** Create the command ***
            DsioGetPersonCommand command = new DsioGetPersonCommand(this.broker);

            // *** Add the arguments ***
            command.AddCommandArguments(patientDfn, personIen);

            // *** Execute the command ***
            RpcResponse response = command.Execute();

            // *** Add response to result ***
            result.SetResult(response.Status == RpcResponseStatus.Success, response.InformationalMessage);

            // *** Check for success ***
            if (result.Success)
            {
                result.TotalResults = command.TotalResults;

                if (result.TotalResults > 0)
                {
                    // *** Loop through all the persons ***
                    foreach (DsioLinkedPerson dsioPerson in command.PersonList)
                    {
                        // *** Convert from dsio person ***
                        Person person = GetPerson(dsioPerson);

                        // *** Add to result ***
                        result.PersonList.Add(person);
                    }
                }
            }

            return result;
        }

        private DsioLinkedPerson GetDsioPerson(string patientDfn, Person person)
        {
            // *** Gets MTD person from FOF ***

            DsioLinkedPerson dsioFof = new DsioLinkedPerson();

            // *** Set patient ***
            dsioFof.PatientDfn = patientDfn;

            // *** Set ID, may be empty ***
            dsioFof.Ien = person.Ien;

            // *** Format the name for VistA ***
            dsioFof.Name = string.Format("{0},{1}", person.LastName, person.FirstName);

            // *** Format the DOB for VistA ***
            if (person.DOB.HasValue)
                dsioFof.DOB = person.DOB.Value.ToString(VistaDates.VistADateOnlyFormat);

            // *** Create an address ***
            dsioFof.Address = new DsioAddress();
            dsioFof.Address.StreetLine1 = person.Address.StreetAddress1;
            dsioFof.Address.StreetLine2 = person.Address.StreetAddress2;
            dsioFof.Address.City = person.Address.City;
            dsioFof.Address.State = person.Address.State;
            dsioFof.Address.ZipCode = person.Address.ZipCode;

            // *** Add years of school ***
            dsioFof.YearsSchool = person.YearsSchool.ToString();

            // *** Add phone numbers ***

            if (!string.IsNullOrWhiteSpace(person.HomePhone))
                dsioFof.TelephoneList.Add(new DsioTelephone() { Number = person.HomePhone, Usage = DsioTelephone.HomePhoneUsage });

            if (!string.IsNullOrWhiteSpace(person.WorkPhone))
                dsioFof.TelephoneList.Add(new DsioTelephone() { Number = person.WorkPhone, Usage = DsioTelephone.WorkPhoneUsage });

            if (!string.IsNullOrWhiteSpace(person.MobilePhone))
                dsioFof.TelephoneList.Add(new DsioTelephone() { Number = person.MobilePhone, Usage = DsioTelephone.MobilePhoneUsage });

            return dsioFof;
        }

        public IenResult SavePregnancy(PregnancyDetails pregnancy)
        {
            // *** Saves pregnancy data ***
            IenResult result = new IenResult();

            // *** Create the dsio pregnancy string data ***
            DsioPregnancy dsioPregnancy = CreateDsioPregnancy(pregnancy);

            // *** Create RPC command ***
            DsioSavePregDetailsCommand command = new DsioSavePregDetailsCommand(this.broker);
            // *** Add command arguments ***
            command.AddCommandArguments(dsioPregnancy, false);
            // *** Execute the command ***
            RpcResponse response = command.Execute();
            // *** Add response data to result ***
            result.SetResult(response.Status == RpcResponseStatus.Success, response.InformationalMessage);

            if (result.Success)
            {
                result.Ien = command.Ien;
            }

            return result;
        }

        public IenResult SaveWvrpcorPregnancy(PregnancyDetails pregnancy, string patientDfn, bool pregnancyValue)
        {
            // *** Saves pregnancy data ***
            IenResult wvrpcorResult = new IenResult();

            // *** Create the dsio pregnancy string data ***
            DsioPregnancy dsioPregnancy = CreateDsioPregnancy(pregnancy);

            // *** Create RPC command ***
            WvrpcorSavePregDetailsCommand saveWvrpcorPregDetailsCommand = new WvrpcorSavePregDetailsCommand(this.broker);
            // *** Add command arguments ***
            saveWvrpcorPregDetailsCommand.AddCommandArguments(dsioPregnancy, patientDfn, pregnancyValue);
            // *** Execute the command ***
            RpcResponse wvrpcorResponse = saveWvrpcorPregDetailsCommand.Execute();
            // *** Add response data to result ***
            wvrpcorResult.SetResult(wvrpcorResponse.Status == RpcResponseStatus.Success, wvrpcorResponse.InformationalMessage);

            if (wvrpcorResult.Success)
            {
                wvrpcorResult.Ien = saveWvrpcorPregDetailsCommand.Ien;
            }

            return wvrpcorResult;
        }

        /// <summary>
        /// Retrieves data about the current pregnancy
        /// </summary>
        /// <param name="patientDfn">Patient's unique identifier</param>
        /// <returns></returns>
        public PregnancyResult GetCurrentPregnancy(string patientDfn)
        {
            // *** Returns the current pregnancy information ***

            PregnancyResult result = new PregnancyResult();

            // *** Get all pregnancies ***
            PregnancyListResult listResult = GetPregnancies(patientDfn, "C");

            // *** Add results to return ***
            result.SetResult(listResult.Success, listResult.Message);

            if (result.Success)
            {
                // *** If we have pregnancies, look for a current ***
                if (listResult.Pregnancies != null)
                    if (listResult.Pregnancies.Count > 0)
                        foreach (PregnancyDetails preg in listResult.Pregnancies)
                            if (preg.RecordType == PregnancyRecordType.Current)
                                result.Pregnancy = preg;

                // *** Add result/message if no current ***
                if (result.Pregnancy == null)
                    result.SetResult(true, "No Current Pregnancy Data Found");
            }

            return result;
        }

        /// <summary>
        /// Retrieves data about the current pregnancy
        /// </summary>
        /// <param name="patientDfn">Patient's unique identifier</param>
        /// <returns></returns>
        public PregnancyResult GetCurrentWvrpcorPregnancy(string patientDfn)
        {
            PregnancyResult result = new PregnancyResult();
            PregnancyDetails currentWvrpcorPregnancy = new PregnancyDetails();

            //Find the pregnancy and lactating status in CPRS
            //RPC call in CPRS to get Women's Heath data: WVRPCOR COVER
            WvrpcorGetWomensHealthDataCommand getWvrpcorWomensHealthDataCommand = new WvrpcorGetWomensHealthDataCommand(this.broker);
            var secondArg = "1";
            getWvrpcorWomensHealthDataCommand.AddCommandArguments(patientDfn, secondArg);
            RpcResponse wvrpcorResponse = getWvrpcorWomensHealthDataCommand.Execute();
            result.SetResult(wvrpcorResponse.Status == RpcResponseStatus.Success, wvrpcorResponse.InformationalMessage);

            if (result.Success)
            {
                currentWvrpcorPregnancy.PatientDfn = getWvrpcorWomensHealthDataCommand.PatientDfn;
                currentWvrpcorPregnancy.RecordType = PregnancyRecordType.Current;
                //currentWvrpcorPregnancy.Ien = getWvrpcorWomensHealthDataCommand.PregnancyIen;
                currentWvrpcorPregnancy.PregnantCPRS = getWvrpcorWomensHealthDataCommand.Pregnant;
                currentWvrpcorPregnancy.LactatingCPRS = getWvrpcorWomensHealthDataCommand.Lactating;

                WvrpcorGetPregDetailsCommand getWvrpcorPregDetailsCommand = new WvrpcorGetPregDetailsCommand(this.broker);
                var secondArgument = "0";
                getWvrpcorPregDetailsCommand.AddCommandArguments(getWvrpcorWomensHealthDataCommand.PregnancyData, secondArgument, currentWvrpcorPregnancy.PregnantCPRS);
                RpcResponse wvrpcorPregDetailsResponse = getWvrpcorPregDetailsCommand.Execute();
                result.SetResult(wvrpcorPregDetailsResponse.Status == RpcResponseStatus.Success, wvrpcorPregDetailsResponse.InformationalMessage);

                if (result.Success)
                {
                    currentWvrpcorPregnancy.Created = getWvrpcorPregDetailsCommand.Created;

                    //If the patient is pregnant in CPRS, get the EDD and LMP
                    if (getWvrpcorWomensHealthDataCommand.Pregnant == "Yes")
                    {
                        currentWvrpcorPregnancy.Lmp = getWvrpcorPregDetailsCommand.LMP;
                        currentWvrpcorPregnancy.EDD = VistaDates.FlexParse(getWvrpcorPregDetailsCommand.EDD);
                    }
                }
            }

            result.Pregnancy = currentWvrpcorPregnancy;
            return result;
        }

        public PregnancyResult UpdateCurrentPregnancyLactationWithCPRSData(string dfn, IObservationsRepository observations, BasePatient patient)
        {
            PregnancyResult result = new PregnancyResult();
            PregnancyDetails currentPregnancyDsio;
            PregnancyDetails currentPregnancyWvrpcor;

            //Get Wvrpcor current pregnancy
            PregnancyResult pregResultWvrpcor = this.GetCurrentWvrpcorPregnancy(dfn);
            if (!pregResultWvrpcor.Success)
            {
                pregResultWvrpcor.Message = "Unable to get patient's current CPRS pregnancy: " + pregResultWvrpcor.Message;
            }
            result.SetResult(pregResultWvrpcor.Success, pregResultWvrpcor.Message);

            //If there is error retrieving pregnancy data from CPRS, nothing changes in Maternity Tracker
            //Otherwise, update the pregnancy datat in Maternity Tracker with the data from CPRS
            if (pregResultWvrpcor.Success)
            {
                currentPregnancyWvrpcor = pregResultWvrpcor.Pregnancy;

                //If there is no pregnancy data in CPRS, nothing changes
                if (currentPregnancyWvrpcor != null)
                {
                    result.Pregnancy = currentPregnancyWvrpcor;

                    //----------------------------------------------------------------------------------
                    //Update Lactation data with CPRS data
                    //----------------------------------------------------------------------------------
                    string currentLactationWvrpcor = pregResultWvrpcor.Pregnancy.LactatingCPRS;
                    bool lactating = currentLactationWvrpcor == "Yes" ? true : false;
                    IenResult lactatingResult = observations.AddLactationObservation(dfn, lactating);
                    result.SetResult(lactatingResult.Success, lactatingResult.Message);
                    if (lactatingResult.Success)
                    {
                        patient.Lactating = lactating;
                    }

                    //----------------------------------------------------------------------------------
                    //Update Pregnancy data with CPRS data
                    //----------------------------------------------------------------------------------

                    //Get DSIO current pregnancy
                    PregnancyResult pregResultDsio = this.GetCurrentPregnancy(dfn);
                    if (!pregResultDsio.Success)
                    {
                        pregResultDsio.Message = "Unable to get patient's current DSIO pregnancy: " + pregResultDsio.Message;
                    }
                    result.SetResult(pregResultDsio.Success, pregResultDsio.Message);

                    if (pregResultDsio.Success)
                    {
                        currentPregnancyDsio = pregResultDsio.Pregnancy;
                        if (currentPregnancyDsio != null)
                        {
                            //If the patient is pregnant in CPRS, update the current DSIO pregnancy with the one frm CPRS
                            if (currentPregnancyWvrpcor.PregnantCPRS == "Yes")
                            {
                                DateTime eddDsio = currentPregnancyDsio.EDD;
                                DateTime eddWvrpcor = currentPregnancyWvrpcor.EDD;
                                string lmpDsio = currentPregnancyDsio.Lmp;
                                string lmpWvrpcor = currentPregnancyWvrpcor.Lmp;

                                //If the current pregnancy in the DSIO namespace is different than the one in CPRS,
                                //update it with the pregnancy data from CPRS     
                                if (eddDsio != eddWvrpcor || lmpDsio != lmpWvrpcor)
                                {
                                    //currentPregnancyDsio.Ien = ienWvrpcor;
                                    currentPregnancyDsio.EDD = eddWvrpcor;
                                    currentPregnancyDsio.Lmp = lmpWvrpcor;
                                    currentPregnancyDsio.Created = currentPregnancyWvrpcor.Created;

                                    BrokerOperationResult savePregResult = this.SavePregnancy(currentPregnancyDsio);
                                    if (!savePregResult.Success)
                                    {
                                        savePregResult.Message = "Unable to update patient's current pregnancy with pregnancy data from CPRS: " + savePregResult.Message;
                                    }
                                    result.SetResult(savePregResult.Success, savePregResult.Message);
                                    result.Pregnancy = currentPregnancyDsio;
                                }
                            }
                            //If the patient is not pregnant in CPRS, update the current DSIO pregnancy to past pregnancy
                            else
                            {
                                currentPregnancyDsio.RecordType = PregnancyRecordType.Historical;
                                currentPregnancyDsio.EndDate = currentPregnancyWvrpcor.Created;
                                BrokerOperationResult savePregResult = this.SavePregnancy(currentPregnancyDsio);
                                if (!savePregResult.Success)
                                {
                                    savePregResult.Message = "Unable to update patient's current pregnancy with pregnancy data from CPRS: " + savePregResult.Message;
                                }
                                result.SetResult(savePregResult.Success, savePregResult.Message);
                                result.Pregnancy = currentPregnancyDsio;
                            }
                        }
                        else
                        {
                            if (currentPregnancyWvrpcor.PregnantCPRS == "Yes")
                            {
                                BrokerOperationResult savePregResult = this.SavePregnancy(currentPregnancyWvrpcor);
                                if (!savePregResult.Success)
                                {
                                    savePregResult.Message = "Unable to create patient's new current pregnancy with the pregnancy data from CPRS: " + savePregResult.Message;
                                }
                                else
                                {
                                    savePregResult.Message = "Patient's new current pregnancy was updated with the pregnancy data from CPRS: " + savePregResult.Message;
                                }
                                result.SetResult(savePregResult.Success, savePregResult.Message);
                                result.Pregnancy = currentPregnancyWvrpcor;
                            }
                        }
                    }
                }
            }

            return result;
        }


        public PregnancyResult GetCurrentOrMostRecentPregnancy(string patientDfn)
        {
            // *** Returns the current pregnancy information ***

            PregnancyResult result = new PregnancyResult();

            // *** Get all pregnancies ***
            PregnancyListResult listResult = GetPregnancies(patientDfn, "");

            // *** Add results to return ***
            result.SetResult(listResult.Success, listResult.Message);

            if (result.Success)
            {
                // *** If we have pregnancies, look for a current ***
                if (listResult.Pregnancies != null)
                    if (listResult.Pregnancies.Count > 0)
                    {
                        PregnancyDetails mostRecent = null;
                        foreach (PregnancyDetails preg in listResult.Pregnancies)
                        {
                            if (preg.RecordType == PregnancyRecordType.Current)
                                result.Pregnancy = preg;

                            if (mostRecent == null)
                                mostRecent = preg;
                            else if (mostRecent.EndDate < preg.EndDate)
                                mostRecent = preg;
                        }

                        if (result.Pregnancy == null)
                            if (mostRecent != null)
                                result.Pregnancy = mostRecent;
                    }

                // *** Add result/message if no current ***
                if (result.Pregnancy == null)
                    result.SetResult(true, "No Pregnancy Data Found");
            }

            return result;
        }

        public PregnancyListResult GetPregnancies(string patientDfn, string pregnancyIen)
        {
            PregnancyListResult result = new PregnancyListResult();

            // *** Create the command ***
            DsioGetPregDetailsCommand command = new DsioGetPregDetailsCommand(this.broker);

            // *** Add arguments...gets all ***
            command.AddCommandArguments(patientDfn, pregnancyIen);

            // *** Execute command ***
            RpcResponse response = command.Execute();

            // *** Add response to result ***
            result.SetResult(response.Status == RpcResponseStatus.Success, response.InformationalMessage);

            // *** Check for success ***
            if (result.Success)
            {
                // *** Loop through the list and create strongly typed pregnancy list ***
                if (command.PregnancyList != null)
                    foreach (DsioPregnancy dsioPreg in command.PregnancyList)
                    {
                        if (result.Pregnancies == null)
                            result.Pregnancies = new List<PregnancyDetails>();

                        PregnancyDetails tempPregnancy = CreatePregnancy(dsioPreg);

                        result.Pregnancies.Add(tempPregnancy);
                    }

                // *** If no pregnancies, then nothing found ***
                if (result.Pregnancies == null)
                    result.SetResult(true, "No Pregnancy Data Found");

            }

            return result;
        }

        public PregnancyHistoryResult GetPregnancyHistory(string patientDfn)
        {
            // *** Gets pregnancy history ***

            PregnancyHistoryResult result = new PregnancyHistoryResult();

            // *** Create the command ***
            DsioGetObservationsCommand command = new DsioGetObservationsCommand(this.broker);

            // *** Add command arguments ***
            command.AddCommandArguments(patientDfn, "", "", "", "", "", "", "Pregnancy History", 1, 1000);

            // *** Execute command ***
            RpcResponse response = command.Execute();

            // *** Add results to return ***
            result.Success = response.Status == RpcResponseStatus.Success;
            result.Message = response.InformationalMessage;

            // *** Create pregnancy history ***
            if (result.Success)
            {
                // *** Check that there are observations ***
                if (command.ObservationsList != null)
                    if (command.ObservationsList.Count > 0)
                    {
                        // *** Create a dictionary to hold only most recent ***
                        Dictionary<string, DsioObservation> mostRecentList = new Dictionary<string, DsioObservation>();

                        // *** Loop through the list, if it does not exist add it, or if it is newer, replace ***
                        foreach (DsioObservation dsioObservation in command.ObservationsList)
                            if (!mostRecentList.ContainsKey(dsioObservation.Code.Code))
                                mostRecentList.Add(dsioObservation.Code.Code, dsioObservation);
                            else
                            {
                                // *** Get dates to compare ***
                                DateTime existingDate = VistaDates.ParseDateString(mostRecentList[dsioObservation.Code.Code].EntryDate, VistaDates.VistADateFormatTwo);
                                DateTime newDate = VistaDates.ParseDateString(dsioObservation.EntryDate, VistaDates.VistADateFormatTwo);

                                // *** If newer replace ***
                                if (newDate > existingDate)
                                    mostRecentList[dsioObservation.Code.Code] = dsioObservation;
                            }

                        // *** Loop through most recent and add to pregnancy history ***
                        foreach (DsioObservation dsioObservation in mostRecentList.Values)
                            if (!string.IsNullOrWhiteSpace(dsioObservation.Code.Code))
                            {
                                Observation tempObs = ObservationUtility.GetObservation(dsioObservation);
                                result.PregnancyHistory.Observations[dsioObservation.Code.Code] = tempObs;
                                //result.PregnancyHistory.SetValue(dsioObservation.Code, dsioObservation.Value);
                            }
                    }
            }

            return result;
        }

        public BrokerOperationResult SavePregnancyHistory(string patientDfn, PregnancyHistory pregnancyHistory)
        {
            // *** Save new pregnancy history observations ***

            BrokerOperationResult result = new BrokerOperationResult();

            List<DsioObservation> observationsToSave = GetObservationsToSave(patientDfn, pregnancyHistory);

            // *** If there's something to save ***
            if (observationsToSave.Count > 0)
            {
                // *** Create the command ***
                DsioSaveObservationCommand command = new DsioSaveObservationCommand(this.broker);

                // *** Set some loop values ***
                bool okToContinue = true;
                int i = 0;

                // TODO: Simplify and shorten...

                // *** Loop through the observations ***
                while ((i < observationsToSave.Count) && (okToContinue))
                {
                    // *** Get the current ***
                    DsioObservation observation = observationsToSave[i];

                    // *** Set the patient dfn ***
                    observation.PatientDfn = patientDfn;

                    // *** Set the date/time ***
                    observation.ExamDate = DateTime.Now.ToString(VistaDates.VistADateFormatFour);

                    // *** Add the command arguments ***
                    command.AddCommandArguments(observation);

                    // *** Execute the command ***
                    RpcResponse response = command.Execute();

                    // *** Set the return response ***
                    result.Success = (response.Status == RpcResponseStatus.Success);
                    result.Message = response.InformationalMessage;

                    // *** Continue if successful ***
                    okToContinue = result.Success;

                    // *** Set index to next ***
                    i++;
                }

                if (okToContinue)
                {
                    // *** Save G&P Summary ***
                    DsioObservation observation = new DsioObservation();
                    observation.Code.CodeSystemName = "NONE";
                    observation.Code.Code = "GravidaParaSummary";
                    observation.Category = "Pregnancy History";
                    observation.Code.DisplayName = "Gravida & Para Summary";

                    // *** Set the patient dfn ***
                    observation.PatientDfn = patientDfn;

                    // *** Set the date/time ***
                    observation.ExamDate = DateTime.Now.ToString(VistaDates.VistADateFormatFour);

                    // *** Add the value ***
                    observation.Value = pregnancyHistory.GravidaPara;

                    // *** Add the command arguments ***
                    command.AddCommandArguments(observation);

                    // *** Execute the command ***
                    RpcResponse response = command.Execute();

                    // *** Set the return response ***
                    result.Success = (response.Status == RpcResponseStatus.Success);
                    result.Message = response.InformationalMessage;

                    // *** Continue if successful ***
                    okToContinue = result.Success;

                }
            }
            else
            {
                result.Success = true;
                result.Message = "Nothing to save";
            }

            return result;
        }

        //public PregnancyResult GetMostRecentPregnancy(string patientDfn)
        //{
        //    PregnancyResult result = new PregnancyResult();

        //    PregnancyListResult listResult = GetPregnancies(patientDfn, "");


        //    if (listResult.Success)
        //    {
        //        if (listResult.Pregnancies != null)
        //        {
        //            Pregnancy mostRecent;
        //            foreach (Pregnancy preg in listResult.Pregnancies)
        //            {

        //                if (mostRecent == null)
        //                    mostRecent = preg;
        //                else if (preg.RecordType == PregnancyRecordType.Current)
        //                    mostRecent = preg; 

        //            }
        //        }
        //    }

        //    return result; 
        //}

        private List<DsioObservation> GetObservationsToSave(string patientDfn, PregnancyHistory pregnancyHistory)
        {
            PregnancyHistory origHist = null;

            // *** Get original history ***
            PregnancyHistoryResult histResult = this.GetPregnancyHistory(patientDfn);

            // *** Create a list of items that need to be saved ***
            List<DsioObservation> observationsToSave = new List<DsioObservation>();

            // *** Set original history ***
            if (histResult.Success)
                origHist = histResult.PregnancyHistory;

            // *** Loop through all the observations ***
            foreach (Observation newObservation in pregnancyHistory.Observations.Values)
            {
                //The fields need to be saved even if they have empty values.
                //If the user decides that a previously saved field has erroneous data
                //and the new value is unknown, then this should be reflected as such.
                if (newObservation.Value != null)
                {
                    // *** If we have previous entries ***
                    if (origHist != null)
                    {
                        // *** Compare current with previous and only save if different ***
                        string origVal = origHist.GetValue(newObservation.Code);

                        if (origVal == null)
                            origVal = "";

                        if (origVal != newObservation.Value)
                        {
                            DsioObservation dsioObs = ObservationUtility.GetDsioObservation(newObservation);
                            observationsToSave.Add(dsioObs);
                        }
                    }
                    else
                    {
                        DsioObservation dsioObs = ObservationUtility.GetDsioObservation(newObservation);
                        observationsToSave.Add(dsioObs);
                    }
                }
            }

            return observationsToSave;
        }

        private DsioPregnancy CreateDsioPregnancy(PregnancyDetails pregnancy)
        {
            DsioPregnancy dsioPregnancy = new DsioPregnancy();

            // *** Convert EDD ***
            if (pregnancy.EDD != DateTime.MinValue)
                dsioPregnancy.EDD = pregnancy.EDD.ToString(VistaDates.VistADateOnlyFormat);

            // *** Convert End Date ***
            if (pregnancy.EndDate != DateTime.MinValue)
                dsioPregnancy.EndDate = pregnancy.EndDate.ToString(VistaDates.VistADateOnlyFormat);

            // *** Convert FOF ***
            if (pregnancy.FatherOfFetusIen != null)
                dsioPregnancy.FatherOfFetusIen = pregnancy.FatherOfFetusIen;

            // *** Set Ien ***
            dsioPregnancy.Ien = pregnancy.Ien;

            // *** Set OB ***
            if (pregnancy.ObstetricianIen != null)
                dsioPregnancy.ObstetricianIen = pregnancy.ObstetricianIen;

            // *** Set planned delivery facility ***
            if (pregnancy.PlannedLaborDeliveryFacilityIen != null)
                dsioPregnancy.LDFacilityIen = pregnancy.PlannedLaborDeliveryFacilityIen;

            // *** Set patient dfn ***
            dsioPregnancy.PatientDfn = pregnancy.PatientDfn;

            // *** Set record type ***
            //dsioPregnancy.RecordType = (pregnancy.RecordType == PregnancyRecordType.Current) ? DsioPregnancy.CurrentPregnancyType : DsioPregnancy.HistoricalPregnancyType;
            dsioPregnancy.RecordType = (pregnancy.RecordType == PregnancyRecordType.Current) ? DsioPregnancy.CurrentPregnancyType.Substring(0, 1) : DsioPregnancy.HistoricalPregnancyType.Substring(0, 1);

            // *** Set start date ***
            if (pregnancy.StartDate != DateTime.MinValue)
                dsioPregnancy.StartDate = pregnancy.StartDate.ToString(VistaDates.VistADateOnlyFormat);

            // *** High Risk ***
            dsioPregnancy.HighRisk = (pregnancy.HighRisk) ? "1" : "0";
            dsioPregnancy.HighRiskDetails = pregnancy.HighRiskDetails;

            dsioPregnancy.GestationalAgeAtDelivery = pregnancy.GestationalAgeAtDelivery;
            dsioPregnancy.LengthOfLabor = pregnancy.LengthOfLabor;
            dsioPregnancy.TypeOfDelivery = pregnancy.TypeOfDelivery;
            dsioPregnancy.Anesthesia = pregnancy.Anesthesia;
            dsioPregnancy.PretermDelivery = pregnancy.PretermDelivery;
            dsioPregnancy.Outcome = pregnancy.Outcome;
            dsioPregnancy.Comment = pregnancy.Comment;
            dsioPregnancy.Lmp = pregnancy.Lmp;

            return dsioPregnancy;
        }

        private PregnancyDetails CreatePregnancy(DsioPregnancy dsioPregnancy)
        {
            // *** Creates a strongly typed Pregnancy object ***

            PregnancyDetails returnVal = new PregnancyDetails();

            // *** Parse the end date ***
            returnVal.EndDate = VistaDates.ParseDateString(dsioPregnancy.EndDate, VistaDates.VistADateOnlyFormat);

            // *** Parse the EDD ***
            returnVal.EDD = VistaDates.ParseDateString(dsioPregnancy.EDD, VistaDates.VistADateOnlyFormat);
            //returnVal.EDD = VistaDates.ParseDateString(dsioPregnancy.EDD, VistaDates.VistADateFormatSix);

            // *** Set FOF and IEN ***
            returnVal.FatherOfFetusIen = dsioPregnancy.FatherOfFetusIen;
            if (!string.IsNullOrWhiteSpace(dsioPregnancy.FatherOfFetus))
                returnVal.FatherOfFetus = dsioPregnancy.FatherOfFetus;

            // *** Set pregnancy IEN ***
            returnVal.Ien = dsioPregnancy.Ien;

            // *** Set OB and IEN ***
            returnVal.ObstetricianIen = dsioPregnancy.ObstetricianIen;
            if (!string.IsNullOrWhiteSpace(dsioPregnancy.Obstetrician))
                returnVal.Obstetrician = dsioPregnancy.Obstetrician;

            // *** Set patient DFN ***
            returnVal.PatientDfn = dsioPregnancy.PatientDfn;

            // *** Set L&D and IEN ***
            returnVal.PlannedLaborDeliveryFacilityIen = dsioPregnancy.LDFacilityIen;
            if (!string.IsNullOrWhiteSpace(dsioPregnancy.LDFacility))
                returnVal.PlannedLaborDeliveryFacility = dsioPregnancy.LDFacility;

            // *** Determine record type ***            
            //returnVal.RecordType = (dsioPregnancy.RecordType == DsioPregnancy.CurrentPregnancyType) ? PregnancyRecordType.Current : PregnancyRecordType.Historical;

            if (dsioPregnancy.RecordType == DsioPregnancy.CurrentPregnancyType)
                returnVal.RecordType = PregnancyRecordType.Current;
            else if (dsioPregnancy.RecordType == DsioPregnancy.CurrentPregnancyType.Substring(0, 1))
                returnVal.RecordType = PregnancyRecordType.Current;
            else if (dsioPregnancy.RecordType == DsioPregnancy.HistoricalPregnancyType)
                returnVal.RecordType = PregnancyRecordType.Historical;
            else if (dsioPregnancy.RecordType == DsioPregnancy.HistoricalPregnancyType.Substring(0, 1))
                returnVal.RecordType = PregnancyRecordType.Historical;

            // *** Parse start date ***
            returnVal.StartDate = VistaDates.ParseDateString(dsioPregnancy.StartDate, VistaDates.VistADateOnlyFormat);

            // *** Create babies on pregnancy object ***
            foreach (DsioBaby dsioBaby in dsioPregnancy.Babies)
            {
                int babyNum = -1;
                int.TryParse(dsioBaby.Number, out babyNum);

                Baby baby = new Baby() { Ien = dsioBaby.Ien, BabyNum = babyNum };

                returnVal.Babies.Add(baby);
            }

            // *** High Risk ***
            returnVal.HighRisk = (dsioPregnancy.HighRisk == "1");
            returnVal.HighRiskDetails = dsioPregnancy.HighRiskDetails;

            // *** Created ***
            returnVal.Created = VistaDates.ParseDateString(dsioPregnancy.Created, VistaDates.VistADateFormatFour);

            returnVal.GestationalAgeAtDelivery = dsioPregnancy.GestationalAgeAtDelivery;
            returnVal.LengthOfLabor = dsioPregnancy.LengthOfLabor;
            returnVal.TypeOfDelivery = dsioPregnancy.TypeOfDelivery;
            returnVal.Anesthesia = dsioPregnancy.Anesthesia;
            returnVal.PretermDelivery = dsioPregnancy.PretermDelivery;
            returnVal.Outcome = dsioPregnancy.Outcome;
            returnVal.Comment = dsioPregnancy.Comment;

            return returnVal;
        }

        private Person GetPerson(DsioLinkedPerson dsioPerson)
        {
            // *** Translates a dsio person to a strongly typed Person ***

            Person newPerson = new Person();

            // ** Parse the name ***
            newPerson.LastName = Util.Piece(dsioPerson.Name, ",", 1);
            newPerson.FirstName = Util.Piece(dsioPerson.Name, ",", 2);

            // *** Ien ***
            newPerson.Ien = dsioPerson.Ien;

            // *** Spouse ***
            if (dsioPerson.Ien == "S")
                newPerson.Spouse = true;

            // *** Use standard DOB format ***
            DateTime tempDate = VistaDates.ParseDateString(dsioPerson.DOB, VistaDates.VistADateOnlyFormat);
            if (tempDate != DateTime.MinValue)
                newPerson.DOB = tempDate;

            // *** Years school ***
            int yrs = -1;
            if (int.TryParse(dsioPerson.YearsSchool, out yrs))
                newPerson.YearsSchool = yrs;

            // *** Address ***
            newPerson.Address = new Address();
            newPerson.Address.StreetAddress1 = dsioPerson.Address.StreetLine1;
            newPerson.Address.StreetAddress2 = dsioPerson.Address.StreetLine2;
            newPerson.Address.City = dsioPerson.Address.City;
            newPerson.Address.State = dsioPerson.Address.State;
            newPerson.Address.ZipCode = dsioPerson.Address.ZipCode;

            // *** Loop through telephone numbers and add ***
            foreach (DsioTelephone tel in dsioPerson.TelephoneList)
            {
                switch (tel.Usage)
                {
                    case DsioTelephone.HomePhoneUsage:
                        newPerson.HomePhone = tel.Number;
                        break;
                    case DsioTelephone.WorkPhoneUsage:
                        newPerson.WorkPhone = tel.Number;
                        break;
                    case DsioTelephone.MobilePhoneUsage:
                        newPerson.MobilePhone = tel.Number;
                        break;
                }
            }

            return newPerson;
        }

        public ObservationListResult GetObservations(string patientDfn, string pregnancyIen, string babyIen, string fromDate, string toDate, string category, int page, int itemsPerPage)
        {
            // *** Get a list of observations matching criteria ***

            ObservationListResult result = new ObservationListResult();

            // *** Create command ***
            DsioGetObservationsCommand command = new DsioGetObservationsCommand(this.broker);

            // *** Add command arguments ***
            command.AddCommandArguments(patientDfn, "", pregnancyIen, babyIen, "", fromDate, toDate, category, page, itemsPerPage);

            // *** Execute ***
            RpcResponse response = command.Execute();

            // *** Add response to result ***
            result.Success = response.Status == RpcResponseStatus.Success;
            result.Message = response.InformationalMessage;

            // *** Add observations ***
            if (result.Success)
            {
                result.TotalResults = command.TotalResults;

                if (command.ObservationsList != null)
                    if (command.ObservationsList.Count > 0)
                    {
                        //result.Observations.AddRange(command.ObservationsList);

                        foreach (DsioObservation dsioObs in command.ObservationsList)
                        {
                            Observation obs = ObservationUtility.GetObservation(dsioObs);

                            if (obs != null)
                                result.Observations.Add(obs);
                        }
                    }
            }

            return result;
        }

        public AddBabyResult AddBabyToPregnancy(string patientDfn, string pregnancyIen)
        {
            AddBabyResult returnResult = new AddBabyResult();

            PregnancyListResult pregResult = this.GetPregnancies(patientDfn, pregnancyIen);

            if (!pregResult.Success)
                returnResult.SetResult(pregResult.Success, pregResult.Message);
            else if (pregResult.Pregnancies != null)
                if (pregResult.Pregnancies.Count == 1)
                {
                    PregnancyDetails pregDetail = pregResult.Pregnancies[0];

                    bool okToAdd = true;

                    // *** Do we have a babies object ? ***
                    if (pregDetail.Babies != null)
                        if (pregDetail.Babies.Count >= 9)
                        {
                            returnResult.SetResult(false, "This pregnancy already has 9 babies.  You cannot add more than 9 babies to a pregnancy.");
                            okToAdd = false;
                        }

                    if (okToAdd)
                    {
                        // *** Create the save command ***
                        DsioSavePregDetailsCommand saveCommand = new DsioSavePregDetailsCommand(this.broker);
                        //DsioSavePregDetailsToOtherNamespaceCommand saveCommand = new DsioSavePregDetailsToOtherNamespaceCommand(this.broker);

                        // *** Create the dsio pregnancy ***
                        DsioPregnancy dsioPreg = CreateDsioPregnancy(pregDetail);

                        // *** Add the command arguments, addBaby = true ***
                        saveCommand.AddCommandArguments(dsioPreg, true);

                        // *** Execute the command ***
                        RpcResponse response = saveCommand.Execute();

                        returnResult.SetResult(pregResult.Success, pregResult.Message);

                        // *** Check the status ***
                        if (response.Status == RpcResponseStatus.Success)
                        {
                            //int newBabyNum = -1;
                            //int.TryParse(saveCommand.BabyNumber, out newBabyNum);
                            //pregDetail.Babies.Add(new Baby() { BabyNum = newBabyNum, Ien = saveCommand.BabyIen });
                            returnResult.NewBabyIen = saveCommand.BabyIen;
                            returnResult.NewBabyNumber = saveCommand.BabyNumber;
                        }
                    }
                }

            return returnResult;
        }

        public BrokerOperationResult Delete(string pregIen)
        {
            BrokerOperationResult returnResult = new BrokerOperationResult();

            DsioDeletePregnancyCommand command = new DsioDeletePregnancyCommand(this.broker);

            command.AddCommandArguments(pregIen);

            RpcResponse response = command.Execute();

            if (response.Status == RpcResponseStatus.Success)
                returnResult.Success = true;
            else
                returnResult.Message = response.InformationalMessage;

            return returnResult;
        }


        public PregnancyOutcomeResult GetPregnancyOutcomes(DateTime fromDate, DateTime toDate, int page, int itemsPerPage)
        {
            PregnancyOutcomeResult returnResult = new PregnancyOutcomeResult();

            DsioGetPregHistoryRangeCommand command = new DsioGetPregHistoryRangeCommand(this.broker);

            command.AddCommandArguments(fromDate, toDate, page, itemsPerPage);

            RpcResponse response = command.Execute();

            returnResult.Success = response.Status == RpcResponseStatus.Success;

            if (response.Status != RpcResponseStatus.Success)
                returnResult.Message = response.InformationalMessage;
            else if (command.HistoricalPregnancies != null)
            {
                foreach (var item in command.HistoricalPregnancies)
                {
                    PregnancyOutcome pregOutcome = new PregnancyOutcome();

                    pregOutcome.EndDate = VistaDates.ParseDateString(item.EndDate, VistaDates.VistADateOnlyFormat);

                    PregnancyOutcomeType tempType;

                    if (Enum.TryParse<PregnancyOutcomeType>(item.OutcomeType, out tempType))
                        pregOutcome.OutcomeType = tempType;

                    //switch (item.OutcomeType)
                    //{
                    //    case "U":
                    //        pregOutcome.OutcomeType = PregnancyOutcomeType.Unknown;
                    //        break;
                    //    case "F":
                    //        pregOutcome.OutcomeType = PregnancyOutcomeType.FullTermDelivery;
                    //        break;
                    //    case "P":
                    //        pregOutcome.OutcomeType = PregnancyOutcomeType.PretermDelivery;
                    //        break;
                    //    case "AS":
                    //        pregOutcome.OutcomeType = PregnancyOutcomeType.SpontaneousAbortion;
                    //        break;
                    //    case "S":
                    //        pregOutcome.OutcomeType = PregnancyOutcomeType.StillBirth;
                    //        break;
                    //    case "AI":
                    //        pregOutcome.OutcomeType = PregnancyOutcomeType.PregnancyTermination;
                    //        break;
                    //    case "E":
                    //        pregOutcome.OutcomeType = PregnancyOutcomeType.Ectopic;
                    //        break;
                    //}

                    returnResult.PregnancyOutcomes.Add(pregOutcome);
                }
            }

            return returnResult;
        }
    }
}
