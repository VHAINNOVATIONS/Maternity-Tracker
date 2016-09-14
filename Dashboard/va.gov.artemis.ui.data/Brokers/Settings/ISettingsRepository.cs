using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.UI.Data.Models;
using VA.Gov.Artemis.UI.Data.Models.ServerSettings;
using VA.Gov.Artemis.UI.Data.Brokers.Common;
using VA.Gov.Artemis.UI.Data.Brokers.Cda; 

namespace VA.Gov.Artemis.UI.Data.Brokers.Settings
{
    public interface ISettingsRepository
    {
        ServerConfigResult GetServerData();

        BrokerOperationResult SetServerData(ServerConfig serverConfig);

        BrokerOperationResult TestServerConnection(string serverName, string serverPort);

        CdaSettingsResult GetCdaSettings();
    }
}
