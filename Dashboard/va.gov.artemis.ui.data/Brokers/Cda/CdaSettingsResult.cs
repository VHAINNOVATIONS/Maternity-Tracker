using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.CDA;
using VA.Gov.Artemis.UI.Data.Brokers.Common; 

namespace VA.Gov.Artemis.UI.Data.Brokers.Cda
{
    public class CdaSettingsResult: BrokerOperationResult
    {
        public string ManufacturerModelName { get; set; }
        public string SoftwareName { get; set; }
        public string ProviderOrganizationPhone { get; set; }

        public string CdaExportFolder { get; set; }
    }
}
