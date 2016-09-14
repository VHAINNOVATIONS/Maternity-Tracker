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
