using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.UI.Data.Brokers.Radiology
{
    public interface IRadiologyRepository
    {
        RadiologyReportsResult GetReports(string dfn); 
    }
}
