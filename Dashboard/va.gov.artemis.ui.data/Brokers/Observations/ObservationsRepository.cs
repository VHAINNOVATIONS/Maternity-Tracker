// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using VA.Gov.Artemis.Commands.Dsio.Observation;
using VA.Gov.Artemis.UI.Data.Brokers.Common;
using VA.Gov.Artemis.UI.Data.Models.Observations;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.UI.Data.Brokers.Observations
{
    public class ObservationsRepository : RepositoryBase, IObservationsRepository
    {
        public ObservationsRepository(IRpcBroker newBroker)
            : base(newBroker)
        {

        }

        public ObservationListResult GetObservations(string patientDfn, string pregnancyIen, string babyIen, string tiuIen, string fromDate, string toDate, string category, int page, int itemsPerPage)
        {
            // *** Get a list of observations matching criteria ***

            ObservationListResult result = new ObservationListResult();

            // *** Create command ***
            DsioGetObservationsCommand command = new DsioGetObservationsCommand(this.broker);

            // *** Add command arguments ***
            command.AddCommandArguments(patientDfn, "", pregnancyIen, babyIen, tiuIen, fromDate, toDate, category, page, itemsPerPage);

            // *** Execute ***
            RpcResponse response = command.Execute();

            // *** Add response to result ***
            result.Success = response.Status == RpcResponseStatus.Success;
            result.Message = response.InformationalMessage;

            // *** Add observations ***
            if (result.Success)
            {
                result.TotalResults = command.TotalResults;

                if (result.TotalResults > 0)
                {
                    //result.Observations.AddRange(command.ObservationsList);
                    foreach (DsioObservation dsioObs in command.ObservationsList)
                    {
                        Observation obs = ObservationUtility.GetObservation(dsioObs);

                        if (obs != null)
                            result.Observations.Add(obs);
                    }

                    // *** Default sort oldest to newest ***
                    //result.Observations.Sort(delegate(DsioObservation o, DsioObservation p)
                    //{
                    //    DateTime oDate = VistaDates.ParseDateString(o.Date, VistaDates.VistADateFormatFour);
                    //    DateTime pDate = VistaDates.ParseDateString(p.Date, VistaDates.VistADateFormatFour);

                    //    return oDate.CompareTo(pDate);
                    //});

                    result.Observations.Sort((x, y) => DateTime.Compare(x.EntryDate, y.EntryDate));
                }
            }

            return result;
        }

        public IenResult SaveObservation(Observation observation)
        {
            DsioObservation dsioObs = ObservationUtility.GetDsioObservation(observation);

            return SaveDsioObservation(dsioObs);
        }

        private IenResult SaveDsioObservation(DsioObservation observation)
        {
            IenResult result = new IenResult();

            DsioSaveObservationCommand command = new DsioSaveObservationCommand(this.broker);

            // *** Add entry date if new ***
            if (string.IsNullOrWhiteSpace(observation.Ien))
                observation.ExamDate = DateTime.Now.ToString(VistaDates.VistADateFormatFour);

            command.AddCommandArguments(observation);

            RpcResponse response = command.Execute();

            result.Success = response.Status == RpcResponseStatus.Success;
            result.Message = response.InformationalMessage;

            if (result.Success)
                result.Ien = command.Ien;

            return result;
        }

        public IenResult AddWvrpcorLactationObservation(string patientDfn, bool currentlyLactating)
        {
            IenResult result = new IenResult();

            // *** Create RPC command ***
            WvrpcorSaveObservationCommand saveWvrpcorObservationCommand = new WvrpcorSaveObservationCommand(this.broker);
            // *** Add command arguments ***
            saveWvrpcorObservationCommand.AddCommandArguments(patientDfn, currentlyLactating);
            // *** Execute the command ***
            RpcResponse response = saveWvrpcorObservationCommand.Execute();

            result.Success = response.Status == RpcResponseStatus.Success;
            result.Message = response.InformationalMessage;

            if (result.Success)
            {
                result.Ien = saveWvrpcorObservationCommand.Ien;
            }

            return result;
        }

        public BrokerOperationResult SaveObservations(List<Observation> observationList)
        {
            BrokerOperationResult result = new BrokerOperationResult();

            // *** Create the command ***
            DsioSaveObservationCommand command = new DsioSaveObservationCommand(this.broker);

            // *** Set some loop values ***
            bool okToContinue = true;
            int i = 0;

            // *** Loop through the observations ***
            while ((i < observationList.Count) && (okToContinue))
            {
                // *** Get the current ***
                DsioObservation observation = ObservationUtility.GetDsioObservation(observationList[i]);

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

            return result;
        }

        public IenResult AddLactationObservation(string patientDfn, bool currentlyLactating)
        {
            // *** Add a lactation observation to the patient ***

            IenResult result;

            // *** Create the observation ***
            DsioObservation obs = new DsioObservation();
            obs.PatientDfn = patientDfn;
            obs.Ien = "";
            obs.ExamDate = DateTime.Now.ToString(VistaDates.VistADateFormatFour);
            obs.PregnancyIen = "";
            obs.BabyIen = "";
            obs.Category = "Postpartum";
            obs.Code.CodeSystem = DsioObservation.OtherCodeSystem;
            obs.Code.Code = "Lactating";
            obs.Code.DisplayName = "The patient is currently lactating";
            obs.Value = currentlyLactating.ToString();

            // *** Save it ***
            result = this.SaveDsioObservation(obs);

            return result;
        }

        public BrokerOperationResult UpdateNextContactDue(string patientDfn, DateTime nextContactDue)
        {
            // *** Add a next contact date observation to the patient ***

            BrokerOperationResult result;

            Observation obs = ObservationsFactory.CreateNextContactObservation(patientDfn, nextContactDue);

            // *** Save it ***
            result = this.SaveObservation(obs);

            return result;
        }

        public BrokerOperationResult UpdateLastContactDate(string patientDfn, DateTime lastContactDate)
        {
            // *** Add a last contact date observation to the patient ***

            BrokerOperationResult result;

            // *** Create the observation ***

            Observation obs = ObservationsFactory.CreateLastContactObservation(patientDfn, lastContactDate);

            // *** Save it ***
            result = this.SaveObservation(obs);

            return result;
        }

        public BrokerOperationResult UpdateNextChecklistDue(string patientDfn, DateTime nextChecklistDue)
        {
            // *** Add a next checklist date observation to the patient ***

            IenResult result;

            // *** Create the observation ***

            Observation obs = ObservationsFactory.CreateNextChecklistObservation(patientDfn, nextChecklistDue);

            // *** Save it ***
            result = this.SaveObservation(obs);

            return result;
        }

        public IenResult SaveSingletonObservation(Observation observation)
        {
            // *** Singleton observation: only one should exist, retrieve it and update if it does ***

            IenResult returnResult = new IenResult();

            // *** If we already have an ien, use it ***
            if (!string.IsNullOrWhiteSpace(observation.Ien))
                returnResult = this.SaveObservation(observation);
            else
            {
                ObservationListResult listResult = this.GetObservations(observation.PatientDfn, observation.PregnancyIen, observation.BabyIen, "", "", "", observation.Category, 0, 0);

                if (listResult.Success)
                    if (listResult.Observations != null)
                        foreach (Observation tempObs in listResult.Observations)
                            if (tempObs.Code == observation.Code)
                            {
                                observation.Ien = tempObs.Ien;
                                break;
                            }

                returnResult = this.SaveObservation(observation);
            }

            return returnResult;
        }

        public BrokerOperationResult SaveSingletonObservations(List<Observation> observationList)
        {
            // *** Saves a list of singleton observations and halts if an error is encountered ***

            BrokerOperationResult returnResult = new BrokerOperationResult();

            int i = 0;
            bool okToContinue = true;

            // *** Loop through the observations ***
            while ((i < observationList.Count) && (okToContinue))
            {
                // *** Get the current ***
                Observation observation = observationList[i];

                returnResult = this.SaveSingletonObservation(observation);

                // *** Continue if successful ***
                okToContinue = returnResult.Success;

                // *** Set index to next ***
                i++;
            }

            return returnResult;
        }

        public ObservationListResult GetObservationListByCategory(string patientDfn, string pregIen, string category)
        {
            // *** Get all existing that match ***
            return this.GetObservations(
                patientDfn,
                pregIen,
                "",
                "",
                "",
                "",
                category,
                0,
                0);
        }

        public BrokerOperationResult SaveSingletonObservationsByCategory(List<Observation> observationList)
        {
            // *** This method makes the following assumptions:                                   ***
            // ***         All the observations share the same, patient, category, and pregnancy  ***
            // ***         These are singleton observations, only one should exist at any time    ***

            BrokerOperationResult returnResult = new BrokerOperationResult();

            // *** Get all observations for this category ****

            if (observationList != null)
                if (observationList.Count > 0)
                {
                    // *** Use first item to find all that match ***
                    ObservationListResult listResult = GetObservationListByCategory(observationList[0].PatientDfn, observationList[0].PregnancyIen, observationList[0].Category);

                    // *** Get the list or empty ***
                    List<Observation> existingList = (listResult.Success) ? listResult.Observations : new List<Observation>();

                    // *** For all new obs ***
                    foreach (Observation newObs in observationList)
                    {
                        // *** Look for existing match, set ien if found ***
                        foreach (Observation exObs in existingList)
                            if ((newObs.Code.Equals(exObs.Code ?? "", StringComparison.CurrentCultureIgnoreCase)) && (newObs.BabyIen.Equals(exObs.BabyIen ?? "", StringComparison.CurrentCultureIgnoreCase)))
                                newObs.Ien = exObs.Ien;

                        // *** Save it ***
                        returnResult = this.SaveObservation(newObs);

                        // *** Abort if problem ***
                        if (!returnResult.Success)
                            break;
                    }
                }

            return returnResult;
        }



    }
}
