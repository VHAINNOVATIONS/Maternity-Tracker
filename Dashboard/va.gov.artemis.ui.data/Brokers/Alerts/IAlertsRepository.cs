using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.UI.Data.Brokers.Alerts
{
    public interface IAlertsRepository
    {
        AlertListResult GetAlerts(int page, int itemsPerPage);

        AlertResult GetAlertDetail(string ien); 
    }
}
