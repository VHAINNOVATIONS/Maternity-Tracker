// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.UI.Data.Brokers.Reminders
{
    public interface IRemindersRepository
    {
        ReminderListResult GetList(string patientDfn, int page, int itemsPerPage);

        ReminderDetailResult GetDetail(string patientDfn, string reminderIen);
    }    
}
