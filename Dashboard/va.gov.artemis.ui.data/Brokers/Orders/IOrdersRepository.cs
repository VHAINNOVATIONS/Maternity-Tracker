using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.UI.Data.Brokers.Orders
{
    public interface IOrdersRepository
    {
        OrderListResult GetList(string patientDfn, int page, int itemsPerPage);

        OrderDetailResult GetDetail(string patientDfn, string orderIfn);
    }
}
