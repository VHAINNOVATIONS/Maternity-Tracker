using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.UI.Data.Models.Labs;

namespace VA.Gov.Artemis.UI.Data.Brokers.Labs
{
    public interface ILabsRepository
    {
        LabItemsResult GetList(string dfn, LabResultType labType, bool filterByDate, DateTime fromDate, DateTime toDate, int page, int itemsPerPage); 
    }
}
