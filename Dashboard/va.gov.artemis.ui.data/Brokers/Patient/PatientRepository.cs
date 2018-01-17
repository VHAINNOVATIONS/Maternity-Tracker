// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using VA.Gov.Artemis.Vista.Broker;
using System;
using System.Collections.Generic;
using VA.Gov.Artemis.UI.Data.Models;
using VA.Gov.Artemis.Commands.Dsio;
using VA.Gov.Artemis.Vista.Utility;
using System.Text.RegularExpressions;
using VA.Gov.Artemis.Commands.Dsio.Tracking;
using VA.Gov.Artemis.Commands.Dsio.Patient;
using VA.Gov.Artemis.UI.Data.Models.PatientList;
using VA.Gov.Artemis.UI.Data.Models.FlaggedPatients;
using VA.Gov.Artemis.UI.Data.Models.PatientSearch;
using VA.Gov.Artemis.UI.Data.Models.Common;
using VA.Gov.Artemis.UI.Data.Models.Patient;
using VA.Gov.Artemis.UI.Data.Brokers.Common;
using VA.Gov.Artemis.Commands.Dsio.PatientSearch;
using VA.Gov.Artemis.UI.Data.Models.Text4Baby;  

namespace VA.Gov.Artemis.UI.Data.Brokers.Patient
{
    public class PatientRepository: RepositoryBase, IPatientRepository
    {
        public PatientRepository(IRpcBroker newBroker): base(newBroker) {}

        public PatientSearchResult Search(string searchParam, int page, int itemsPerPage)
        {
            // *** Gets female patients matching search criteria ***

            PatientSearchResult result = new PatientSearchResult();

            //DsioFemalePatientSearchCommand patSearchCommand; 

            //if (Regex.IsMatch(searchParam, @"^[a-zA-Z]\d{4}$"))
            //{
            //    // *** Use Find command ***
            //    DsioFemalePatientFindCommand tempCommand = new DsioFemalePatientFindCommand(broker);

            //    tempCommand.AddCommandArguments(searchParam.ToUpper());

            //    patSearchCommand = tempCommand; 
            //}
            //else 
            //{
            //    // *** Use Search command ***
            //    patSearchCommand = new DsioFemalePatientSearchCommand(broker);

            //    // *** Set arguments/parameters ***
            //    if (string.IsNullOrWhiteSpace(searchParam))
            //        patSearchCommand.AddCommandArguments("", page, itemsPerPage);
            //    else
            //        patSearchCommand.AddCommandArguments(searchParam.ToUpper(), page, itemsPerPage);
            //}

            // *** Execute command ***
            //RpcResponse response = patSearchCommand.Execute();

            DsioPatientListCommand patSearchCommand = new DsioPatientListCommand(broker);

            patSearchCommand.AddCommandArguments(searchParam, page, itemsPerPage);

            RpcResponse response = patSearchCommand.Execute(); 

            // *** Set return values ***
            result.Success = (response.Status == RpcResponseStatus.Success);
            result.Message = response.InformationalMessage; 

            // *** If we have patients, then add them to return ***
            if (response.Status == RpcResponseStatus.Success)
            {
                if (patSearchCommand.MatchingPatients != null)
                    if (patSearchCommand.MatchingPatients.Count > 0)
                        foreach (DsioSearchPatient commandPatient in patSearchCommand.MatchingPatients)
                        {
                            SearchPatient uiPatient = GetSearchPatient(commandPatient);

                            if (uiPatient != null)
                                result.Patients.Add(uiPatient);
                        }
                result.TotalResults = patSearchCommand.TotalResults;
            }

            return result; 
        }

        public PatientSearchResult ProgressiveSearch(string lastName, string firstName, int page, int itemsPerPage)
        {
            // *** Tries several searches to get results ***

            // TODO: Add ssn, city, state, zip to search and matching...

            PatientSearchResult result = new PatientSearchResult();

            List<string> searchValueList = new List<string>();

            string[] searchVals = new string[] {
                string.Format("{0},{1}", lastName, firstName),
                string.Format("{0},{1}", lastName, firstName.Substring(0, 1)),
                string.Format("{0}", lastName)
                };

            bool keepLooking = true; 
            int idx = 0;

            while ((keepLooking) && (idx < searchVals.Length))
            {
                result = Search(searchVals[idx], page, itemsPerPage);

                if (result.Success)
                    if (result.Patients != null)
                        if (result.Patients.Count > 0)
                            keepLooking = false;
                
                idx += 1; 
            }
             
            return result; 
        }

        private SearchPatient GetSearchPatient(DsioSearchPatient commandPatient)
        {
            // *** Gets a SearchPatient based on string only commandPatient ***

            // *** Get the tracking status ***
            CurrentTrackingStatus trackStat = GetTrackingStatus(commandPatient.TrackingStatus);
         
            // *** Create the new patient ***
            SearchPatient uiPatient = new SearchPatient()
            {
                Dfn = commandPatient.Dfn,
                LastName = commandPatient.LastName,
                FirstName = commandPatient.FirstName,
                Veteran = commandPatient.Veteran,
                Location = commandPatient.Location,
                RoomBed = commandPatient.RoomBed,
                CurrentlyTracking = trackStat
            };

            uiPatient.Sensitive = (commandPatient.Sensitive == "1") ? true : false; 

            //// *** Determine if sensitive ***
            //if (commandPatient.Last4.Contains("SENSITIVE"))
            //    uiPatient.Sensitive = true; 
            //else 
            if (!uiPatient.Sensitive)
            {
                // *** Prepare SSN ***
                uiPatient.Last4 = commandPatient.Last4;
                uiPatient.FullSSN = string.Format("XXX-XX-{0}", uiPatient.Last4);

                // *** Handle DOB ***
                //DateTime dob = DateTime.MinValue ;
                //if (DateTime.TryParse(commandPatient.DateOfBirth, out dob))
                //    uiPatient.DateOfBirth = dob;
                //else
                //{
                //    uiPatient.DateOfBirth = DateTime.MinValue; 
                //    ErrorLogger.Log(string.Format("PatientRepository.GetSearchPatient: Could not parse date [{0}]", commandPatient.DateOfBirth ));
                //}

                // *** Process/Parse dob ***
                DateTime dob;
                if (DateTime.TryParse(commandPatient.DateOfBirth, out dob))
                    uiPatient.DateOfBirth = dob;
                else
                    uiPatient.DateOfBirthInexact = Util.GetInexactDate(commandPatient.DateOfBirth);

            }

            return uiPatient; 
        }

        private CurrentTrackingStatus GetTrackingStatus(string trackingStatus)
        {
            CurrentTrackingStatus returnVal = CurrentTrackingStatus.No;

            switch (trackingStatus)
            {
                case "1":
                    returnVal = CurrentTrackingStatus.Yes;
                    break;
                case "2":
                    returnVal = CurrentTrackingStatus.Flagged;
                    break;
                case "0":
                default:                
                    returnVal = CurrentTrackingStatus.No;
                    break;
            }

            return returnVal;
        }

        public FlaggedPatientsResult GetFlaggedPatients(int page, int itemsPerPage)
        {
            // *** Gets a list of flagged patients ***

            FlaggedPatientsResult result = new FlaggedPatientsResult(); 

            // *** Create the command ***
            DsioGetTrackingCommand command = new DsioGetTrackingCommand(this.broker);

            // *** Add the parameters ***
            command.AddGetFlaggedPatientsParameters(page, itemsPerPage);

            // *** Execute the command ***
            RpcResponse response = command.Execute();

            result.Success = (response.Status == RpcResponseStatus.Success);
            result.Message = response.InformationalMessage; 

            // *** Check for success and results ***
            if (result.Success)
                if (command.FlaggedPatientResult != null) 
                    if (command.FlaggedPatientResult.FlaggedPatients != null)
                        if (command.FlaggedPatientResult.FlaggedPatients.Count > 0)
                        {
                            result.Patients = ProcessDsioFlaggedPatients(command.FlaggedPatientResult.FlaggedPatients);

                            result.TotalResults = command.TotalResults; 
                        }

            return result; 
        }

        private List<FlaggedPatient> ProcessDsioFlaggedPatients(Dictionary<string, DsioFlaggedPatient> dsioFlaggedPatients)
        {
            // *** Get list of flagged patients from dictionary of dsio flagged patients ***

            List<FlaggedPatient> returnList = new List<FlaggedPatient>();

            // *** Loop ***
            foreach (DsioFlaggedPatient dsioPatient in dsioFlaggedPatients.Values)
            {
                // *** Get tracking history for this patient ***

                DsioGetTrackingCommand command = new DsioGetTrackingCommand(broker);

                command.AddPatientLogsParameter(dsioPatient.Dfn); 

                RpcResponse response = command.Execute();

                if (response.Status == RpcResponseStatus.Success)
                    foreach (DsioTrackingItem item in command.TrackingItems)
                        dsioPatient.TrackingItems.Add(item.Id, item);

                // *** Create new flagged patient and add to list ***
                FlaggedPatient patient = this.GetFlaggedPatient(dsioPatient);

                returnList.Add(patient);
            }
            return returnList; 
        }

        private FlaggedPatient GetFlaggedPatient(DsioFlaggedPatient dsioPatient)
        {
            // *** Create new flagged patient ***

            FlaggedPatient patient = new FlaggedPatient();

            patient.Dfn = dsioPatient.Dfn;
            patient.FirstName = dsioPatient.FirstName;
            patient.LastName = dsioPatient.LastName;

            if (dsioPatient.Last4.Length > 4)
                if (dsioPatient.Last4.ToUpper().Contains("SENSITIVE"))
                {
                    patient.Last4 = "XXXX";
                    patient.FullSSN = dsioPatient.Last4;
                }
                else
                {
                    patient.Last4 = dsioPatient.Last4.Substring(5, 4);
                    patient.FullSSN = string.Format("XXX-XX-{0}", patient.Last4);
                }
            else
            {
                patient.Last4 = dsioPatient.Last4;
                patient.FullSSN = string.Format("XXX-XX-{0}", patient.Last4);
            }

            //patient.FullSSN = string.Format("XXX-XX-{0}", dsioPatient.Last4);
            //patient.Last4 = dsioPatient.Last4;

            // *** Process/Parse dob ***
            DateTime dob;
            if (DateTime.TryParse(dsioPatient.DateOfBirth, out dob))
                patient.DateOfBirth = dob;
            else
                patient.DateOfBirthInexact = Util.GetInexactDate(dsioPatient.DateOfBirth);

            patient.FlagSummary = dsioPatient.FlagSummary;
            patient.FlaggedOn = dsioPatient.FlaggedOn;

            return patient; 
        }

        //public PatientDemographicsResult GetPatientDemographicsX(string dfn)
        //{
        //    // *** NOTE: Uses ORWPT SELECT...

        //    PatientDemographicsResult result = new PatientDemographicsResult();

        //    OrwptSelectCommand command = new OrwptSelectCommand(this.broker);

        //    command.AddDfnArgument(dfn);

        //    RpcResponse response = command.Execute();

        //    result.Success = (response.Status == RpcResponseStatus.Success);
        //    result.Message = response.InformationalMessage; 

        //    if (result.Success)
        //    {
        //        result.Patient = new BasePatient();
        //        result.Patient.Dfn = command.Patient.Dfn;
        //        result.Patient.LastName = Util.Piece(command.Patient.PatientName, ",", 1); 
        //        result.Patient.FirstName = Util.Piece(command.Patient.PatientName, ",",2);

        //        result.Patient.DateOfBirth = Util.GetDateTime(command.Patient.DOB);

        //        if (result.Patient.DateOfBirth == DateTime.MinValue)
        //            result.Patient.DateOfBirthInexact = Util.GetInexactDateFromFM(command.Patient.DOB); 

        //        result.Patient.FullSSN = command.Patient.SSN;

        //        int length = result.Patient.FullSSN.Length;

        //        if (length == 9)
        //            result.Patient.Last4 = result.Patient.FullSSN.Substring(5);
        //        else if (length == 10)
        //            if (result.Patient.FullSSN.EndsWith("P"))
        //                result.Patient.Last4 = result.Patient.FullSSN.Substring(5, 4);
                
        //    }

        //    return result;
        //}

        public PatientDemographicsResult GetPatientDemographics(string dfn)
        {
            PatientDemographicsResult result = new PatientDemographicsResult();

            DsioGetPatientInformationCommand command = new DsioGetPatientInformationCommand(this.broker); 

            command.AddCommandArguments(dfn); 

            RpcResponse response = command.Execute();

            result.Success = (response.Status == RpcResponseStatus.Success);
            result.Message = response.InformationalMessage;

            if (result.Success)
            {
                result.Patient = new BasePatient();

                // *** Dfn ***
                result.Patient.Dfn = command.Patient.Dfn;

                // *** Name ***
                result.Patient.LastName = Util.Piece(command.Patient.PatientName, ",", 1);
                result.Patient.FirstName = Util.Piece(command.Patient.PatientName, ",", 2);
                
                // *** SSN ***
                result.Patient.FullSSN = command.Patient.SSN;

                int length = result.Patient.FullSSN.Length;

                if (length == 9)
                    result.Patient.Last4 = result.Patient.FullSSN.Substring(5);
                else if (length == 10)
                    if (result.Patient.FullSSN.EndsWith("P"))
                        result.Patient.Last4 = result.Patient.FullSSN.Substring(5, 4);

                // *** DOB ***
                result.Patient.DateOfBirth = VistaDates.ParseDateString(command.Patient.DOB, VistaDates.VistADateOnlyFormat); 

                // *** Gravida Para ***
                if (string.IsNullOrWhiteSpace(command.Patient.GravidaPara))
                    result.Patient.GravidaPara = "G? P?-?-?-?";
                else
                    result.Patient.GravidaPara = command.Patient.GravidaPara;

                result.Patient.Pregnant = (command.Patient.Pregnant == "YES") ? true : false; 

                // *** Last Live Birth ***
                if (!string.IsNullOrWhiteSpace(command.Patient.LastLiveBirth))
                    result.Patient.LastLiveBirth = VistaDates.ParseDateString(command.Patient.LastLiveBirth, VistaDates.VistADateOnlyFormat); 

                // *** Lactating ***
                result.Patient.Lactating = (command.Patient.Lactating == "YES") ? true : false;

                // *** Add phone numbers ***
                result.Patient.HomePhone = command.Patient.HomePhone;
                result.Patient.WorkPhone = command.Patient.WorkPhone;
                result.Patient.MobilePhone = command.Patient.MobilePhone; 

                // *** Contact dates ***
                // TODO: Should last contact have time?
                result.Patient.LastContactDate = VistaDates.ParseDateString(command.Patient.LastContactDate, VistaDates.VistADateOnlyFormat);
                result.Patient.NextContactDue = VistaDates.ParseDateString(command.Patient.NextContactDue, VistaDates.VistADateOnlyFormat); 

                // *** Checklist Date ***
                result.Patient.NextChecklistDue = VistaDates.ParseDateString(command.Patient.NextChecklistDue, VistaDates.VistADateOnlyFormat); 

                // *** LMP ***
                result.Patient.Lmp = VistaDates.ParseDateString(command.Patient.Lmp, VistaDates.VistADateOnlyFormat); 

                // *** Current Pregnancy High Risk ***
                result.Patient.CurrentPregnancyHighRisk = (command.Patient.CurrentPregnancyHighRisk == "TRUE");
                result.Patient.HighRiskDetails = command.Patient.HighRiskDetails;

                // *** Zip, Email ***
                result.Patient.ZipCode = command.Patient.ZipCode;
                result.Patient.Email = command.Patient.Email; 

                // *** Text4Baby ***
                if (command.Patient.Text4BabyStatus.Equals("enrolled", StringComparison.CurrentCultureIgnoreCase)) 
                    result.Patient.Text4BabyStatus = Text4BabyStatus.Enrolled; 
                else if (command.Patient.Text4BabyStatus.Equals("not interested", StringComparison.CurrentCultureIgnoreCase)) 
                    result.Patient.Text4BabyStatus = Text4BabyStatus.NotInterested; 
                                
                result.Patient.Text4BabyStatusUpdatedOn = VistaDates.FlexParse(command.Patient.Text4BabyDate); 
            }

            return result;
        }

        public TrackedPatientsResult GetTrackedPatients(int page, int itemsPerPage)
        {
            // *** Gets a tracked patients result from the broker ***

            TrackedPatientsResult result = new TrackedPatientsResult();

            // *** Create the command needed to get tracked patients ***
            DsioGetTrackingCommand command = new DsioGetTrackingCommand(this.broker);

            // *** Add appropriate parameters ***
            command.AddGetTrackedPatientsParameters(page, itemsPerPage);

            // *** Execute command and get response ***
            RpcResponse response = command.Execute();

            // *** Add response to return result ***
            result.Success = (response.Status == RpcResponseStatus.Success); 

            // *** Check for success ***
            if (result.Success)
            {
                result.Patients = new List<TrackedPatient>();

                // *** Check if we have result ***
                if (command.TrackedPatients != null)
                {
                    // *** Loop through resulting patients ***
                    foreach (DsioTrackedPatient dsioPatient in command.TrackedPatients)
                    {
                        // *** Get strongly typed patient from dsio Patient ***
                        TrackedPatient trackedPatient = GetTrackedPatient(dsioPatient);

                        // *** Add patient to list ***
                        result.Patients.Add(trackedPatient);
                    }
                }

                result.TotalResults = command.TotalResults;
            }
            else
                result.Message = response.InformationalMessage; 

            return result; 
        }

        public TrackedPatient GetTrackedPatient(DsioTrackedPatient dsioPatient)
        {
            // *** Converts dsio patient to strongly typed patient ***

            TrackedPatient returnPatient = new TrackedPatient();

            // *** Add values ***
            returnPatient.Dfn = dsioPatient.Dfn;
            returnPatient.LastName = dsioPatient.LastName;
            returnPatient.FirstName = dsioPatient.FirstName;

            if (dsioPatient.Last4.Length > 4)
                if (dsioPatient.Last4.ToUpper().Contains("SENSITIVE"))
                    returnPatient.Last4 = "XXXX";
                else 
                    returnPatient.Last4 = dsioPatient.Last4.Substring(5, 4);
            else  
                returnPatient.Last4 = dsioPatient.Last4; 

            // *** Process/Parse dob ***
            DateTime dob;
            if (DateTime.TryParse(dsioPatient.DateOfBirth, out dob))
                returnPatient.DateOfBirth = dob;
            else
                returnPatient.DateOfBirthInexact = Util.GetInexactDate(dsioPatient.DateOfBirth);

            returnPatient.HomePhone = dsioPatient.HomePhone;

            returnPatient.NonVaObstetrician = dsioPatient.Obstetrician;
            returnPatient.PlannedDeliveryFacility = dsioPatient.LDFacility; 

            // *** Process/Parse EDD ***
            returnPatient.EDD = VistaDates.ParseDateString(dsioPatient.EDD, VistaDates.VistADateOnlyFormat);

            returnPatient.Pregnant = (dsioPatient.Pregnant == "YES") ? true : false;

            returnPatient.Lactating = (dsioPatient.Lactating == "YES") ? true : false; 

            // *** Add dates ***
            //returnPatient.NextChecklistDue = VistaDates.ParseDateString(dsioPatient.NextChecklistDue, VistaDates.VistADateFormatSix);
            //returnPatient.LastContactDate = VistaDates.ParseDateString(dsioPatient.LastContactDate, VistaDates.VistADateFormatSix);
            //returnPatient.NextContactDue = VistaDates.ParseDateString(dsioPatient.NextContactDue, VistaDates.VistADateFormatSix); 
            returnPatient.NextChecklistDue = VistaDates.ParseDateString(dsioPatient.NextChecklistDue, VistaDates.VistADateOnlyFormat);
            returnPatient.LastContactDate = VistaDates.ParseDateString(dsioPatient.LastContactDate, VistaDates.VistADateOnlyFormat);
            returnPatient.NextContactDue = VistaDates.ParseDateString(dsioPatient.NextContactDue, VistaDates.VistADateOnlyFormat);

            // *** Current Pregnancy High Risk ***
            returnPatient.CurrentPregnancyHighRisk = (dsioPatient.CurrentPregnancyHighRisk == "TRUE");
            returnPatient.HighRiskDetails = dsioPatient.HighRiskDetails;

            // *** Text4Baby ***
            if (dsioPatient.Text4BabyStatus.Equals("enrolled", StringComparison.CurrentCultureIgnoreCase))
                returnPatient.Text4BabyStatus = Text4BabyStatus.Enrolled;
            else if (dsioPatient.Text4BabyStatus.Equals("not interested", StringComparison.CurrentCultureIgnoreCase))
                returnPatient.Text4BabyStatus = Text4BabyStatus.NotInterested; 

            return returnPatient;
        }

        public BrokerOperationResult SaveText4BabyInfo(string dfn, Text4BabyStatus t4bStat, string participantId)
        {
            BrokerOperationResult returnResult = new BrokerOperationResult();

            Dictionary<string, string> newValues = new Dictionary<string,string>(); 
            
            newValues[DsioPatientInformationFields.T4BStatusKey] = ((int)t4bStat).ToString();
            newValues[DsioPatientInformationFields.T4BDateKey] = DateTime.Now.ToString(VistaDates.VistADateFormatFour);
            newValues[DsioPatientInformationFields.T4BIdKey] = participantId;

            returnResult = CallSaveRpc(dfn, newValues); 

            return returnResult; 
        }

        public BrokerOperationResult SaveText4BabyInfo(string dfn, Text4BabyStatus t4bStat)
        {
            BrokerOperationResult returnResult = new BrokerOperationResult();

            Dictionary<string, string> newValues = new Dictionary<string, string>();

            newValues[DsioPatientInformationFields.T4BStatusKey] = ((int)t4bStat).ToString();
            newValues[DsioPatientInformationFields.T4BDateKey] = DateTime.Now.ToString(VistaDates.VistADateFormatFour);

            returnResult = CallSaveRpc(dfn, newValues);

            return returnResult;             
        }

        public BrokerOperationResult SaveNextChecklistDue(string dfn, DateTime nextChecklistDue)
        {
            BrokerOperationResult returnResult = new BrokerOperationResult();

            Dictionary<string, string> newValues = new Dictionary<string, string>();

            string val = (nextChecklistDue == DateTime.MinValue) ? "" : nextChecklistDue.ToString(VistaDates.VistADateFormatFour);

            newValues[DsioPatientInformationFields.NextChecklistDueKey] = val;
 
            returnResult = CallSaveRpc(dfn, newValues);

            return returnResult;
        }

        private BrokerOperationResult CallSaveRpc(string dfn, Dictionary<string, string> newValues)
        {
            BrokerOperationResult returnResult = new BrokerOperationResult();

            DsioSetPatientInformationCommand command = new DsioSetPatientInformationCommand(this.broker);

            foreach (string key in newValues.Keys)
            {
                command.AddCommandArguments(dfn, key, newValues[key]);

                RpcResponse response = command.Execute();

                returnResult.SetResult(response.Status == RpcResponseStatus.Success, response.InformationalMessage);

                if (!returnResult.Success)
                    break;
            }

            return returnResult; 
        }
    }
}