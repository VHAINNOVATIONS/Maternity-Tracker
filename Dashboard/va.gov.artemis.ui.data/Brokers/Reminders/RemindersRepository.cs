// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Commands.Dsio.Reminders;
using VA.Gov.Artemis.UI.Data.Brokers.Common;
using VA.Gov.Artemis.UI.Data.Models;
using VA.Gov.Artemis.UI.Data.Models.Reminders;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.UI.Data.Brokers.Reminders
{
    public class RemindersRepository: RepositoryBase, IRemindersRepository
    {
        public RemindersRepository(IRpcBroker newBroker) :
            base(newBroker)
        {

        }

        /// <summary>
        /// Gets a list of reminders for a patient
        /// </summary>
        /// <param name="patientDfn">Unique identifier for a patient</param>
        /// <param name="page">Which page to retrieve for paged results</param>
        /// <param name="itemsPerPage">The number of items per page for paged results</param>
        /// <returns></returns>
        public ReminderListResult GetList(string patientDfn, int page, int itemsPerPage)
        {
            // *** Return ***
            ReminderListResult result = new ReminderListResult();

            // *** Create the command ***
            DsioGetReminderListCommand command = new DsioGetReminderListCommand(this.broker);

            // *** Add the arguments ***
            command.AddCommandArguments(patientDfn, page, itemsPerPage);

            // *** Execute ***
            RpcResponse response = command.Execute();

            // *** Add response to result ***
            result.Success = response.Status == RpcResponseStatus.Success;
            result.Message = response.InformationalMessage;

            // *** Check for success ***
            if (result.Success)
            {
                // *** Set the total result ***
                result.TotalResults = command.TotalResults;

                // *** If we have something to work with ***
                if (result.TotalResults > 0)
                {
                    if (command.Reminders != null) 
                        if (command.Reminders.Count > 0)
                            foreach (DsioReminder dsioReminder in command.Reminders)
                            {
                                // *** Create the reminder ***
                                Reminder tempReminder = new Reminder()
                                {
                                    Ien = dsioReminder.Ien,
                                    ReminderText = dsioReminder.Text
                                };

                                // *** Set the date ***
                                if (dsioReminder.ReminderDate == "DUE NOW")
                                    tempReminder.ReminderDate = "Due Now";
                                else
                                {
                                    DateTime tempDate = Util.GetDateTime(dsioReminder.ReminderDate);
                                    tempReminder.ReminderDate = tempDate.ToString(VistaDates.UserDateFormat); 
                                }

                                // *** Add to result ***
                                result.Reminders.Add(tempReminder); 
                            }
                }
            }
            return result; 
        }

        public ReminderDetailResult GetDetail(string patientDfn, string reminderIen)
        {
            // *** Get Reminder detail from VistA ***

            ReminderDetailResult result = new ReminderDetailResult();

            // *** Create the command ***
            DsioGetReminderDetailCommand command = new DsioGetReminderDetailCommand(this.broker);

            // *** Add command arguments ***
            command.AddCommandArguments(patientDfn, reminderIen);

            // *** Execute the command ***
            RpcResponse response = command.Execute();

            // *** Add result to return ***
            result.SetResult(response.Status == RpcResponseStatus.Success, response.InformationalMessage);

            // *** Add Reminder detail ***
            if (result.Success)
                result.ReminderDetail = command.ReminderDetail;

            return result; 

        }
    }
}
