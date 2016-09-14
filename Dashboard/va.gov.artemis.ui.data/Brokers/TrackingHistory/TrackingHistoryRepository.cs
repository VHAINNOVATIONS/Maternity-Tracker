using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Commands.Dsio;
using VA.Gov.Artemis.Commands.Dsio.Tracking;
using VA.Gov.Artemis.UI.Data.Brokers.Common;
using VA.Gov.Artemis.UI.Data.Models.Track;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.UI.Data.Brokers.TrackingHistory
{
    public class TrackingHistoryRepository: RepositoryBase, ITrackingHistoryRepository 
    {
        public TrackingHistoryRepository(IRpcBroker newBroker): base(newBroker) {}

        public BrokerOperationResult Add(string dfn, TrackingEntryType eventType, string reason, string comment)
        {
            BrokerOperationResult result = new BrokerOperationResult();

            if (this.broker != null)
            {
                DsioCreateTrackingLogCommand command = new DsioCreateTrackingLogCommand(this.broker);
                string eventTypeString = ((int)eventType).ToString();

                string[] commentArray = (string.IsNullOrWhiteSpace(comment)) ? null : Util.Split(comment);
                command.AddCommandArguments(dfn, eventTypeString, reason, commentArray);

                RpcResponse response = command.Execute();

                result.Success = (response.Status == RpcResponseStatus.Success);
                result.Message = response.InformationalMessage;

            }
            else
                result.Message = "No broker"; 

            return result; 
        }

        public TrackingHistoryResult GetHistoryEntries(int page, int itemsPerPage)
        {
            TrackingHistoryResult returnResult = new TrackingHistoryResult();

            if (this.broker == null)
                returnResult.Message = "No broker";
            else
            {
                DsioGetTrackingCommand command = new DsioGetTrackingCommand(this.broker);

                //command.AddGetAllParameters();
                command.AddGetAllParameters(page, itemsPerPage);

                RpcResponse response = command.Execute();

                returnResult.Success = (response.Status == RpcResponseStatus.Success);
                returnResult.Message = response.InformationalMessage;

                if (returnResult.Success)
                {
                    returnResult.TrackingEntries = GetTrackingEntries(command.TrackingItems);
                    returnResult.TotalEntries = command.TotalResults; 
                }

            }

            return returnResult; 
        }

        public TrackingHistoryResult GetPatientEntries(string dfn)
        {
            // *** Gets all tracking history entries for a patient ***

            return GetPatientEntries(dfn, -1, -1);
        }

        public TrackingHistoryResult GetPatientEntries(string dfn,int page, int itemsPerPage)
        {
            // *** Gets one page of tracking history entries for a patient ***

            TrackingHistoryResult result = new TrackingHistoryResult();

            DsioGetTrackingCommand command = new DsioGetTrackingCommand(this.broker);

            // *** If we don't have a valid page, get all ***
            if (page > 0)
                command.AddPatientLogsParameter(dfn, page, itemsPerPage);
            else
                command.AddPatientLogsParameter(dfn); 

            // *** Execute the command ***
            RpcResponse response = command.Execute();

            // *** Store success and message ***
            result.Success = (response.Status == RpcResponseStatus.Success);
            result.Message = response.InformationalMessage;

            if (result.Success)
            {
                // *** Add results to return value ***
                result.TrackingEntries = GetTrackingEntries(command.TrackingItems);
                result.TotalEntries = command.TotalResults; 
            }
            return result; 
        }

        private TrackingEntryType GetEntryType(string value)
        {
            TrackingEntryType returnVal;

            int valueId = int.Parse(value);
            returnVal = (TrackingEntryType)valueId;

            return returnVal;
        }

        private bool IsValidEntryType(string value)
        {
            bool returnVal = false;

            int valInt;

            if (int.TryParse(value, out valInt))
                if (valInt <= (int)TrackingEntryType.Accept)
                    if (valInt >= 0)
                        returnVal = true;

            return returnVal;
        }

        private List<TrackingEntry> GetTrackingEntries(List<DsioTrackingItem> commandEntries)
        {
            // *** Gets a list of tracking entries from dsio tracking items ***

            List<TrackingEntry> returnEntries = new List<TrackingEntry>(); 

            // *** Check that we have something to work with ***
            if (commandEntries != null)
                if (commandEntries.Count > 0)
                {
                    // *** Go through each ***
                    foreach (DsioTrackingItem dsioItem in commandEntries)
                    {
                        // *** Create the entry ***
                        TrackingEntry newEntry = new TrackingEntry()
                        {
                            PatientDfn = dsioItem.Dfn,
                            Comment = dsioItem.Comment,
                            EntryId = dsioItem.Id,
                            Reason = dsioItem.Reason, 
                            PatientName = dsioItem.PatientName, 
                            Source = dsioItem.Source, 
                            UserName = dsioItem.User
                        };

                        // *** Convert from fileman date time ***
                        //newEntry.EntryDateTime = Util.GetDateTime(dsioItem.TrackingItemDateTime);
                        //CultureInfo enUS = new CultureInfo("en-US");
                        //DateTime tempDateTime;
                        //if (DateTime.TryParseExact(dsioItem.TrackingItemDateTime,VistaDates.VistADateFormatTwo, enUS,DateTimeStyles.None, out tempDateTime))
                        //    newEntry.EntryDateTime = tempDateTime; 

                        // *** Use VistaDates parser ***
                        // *** Try with seconds and then without ***
                        DateTime tempDateTime = VistaDates.ParseDateString(dsioItem.TrackingItemDateTime, VistaDates.VistADateFormatFour); 
                        if (tempDateTime == DateTime.MinValue)
                            tempDateTime = VistaDates.ParseDateString(dsioItem.TrackingItemDateTime, VistaDates.VistADateFormatEight);

                        if (tempDateTime != DateTime.MinValue)
                            newEntry.EntryDateTime = tempDateTime; 

                        // *** Add entry type ***
                        if (IsValidEntryType(dsioItem.TrackingType))
                            newEntry.EntryType = GetEntryType(dsioItem.TrackingType);

                        // *** Add to list ***
                        returnEntries.Add(newEntry);
                    }
                }

            return returnEntries;
        }
    }
}
