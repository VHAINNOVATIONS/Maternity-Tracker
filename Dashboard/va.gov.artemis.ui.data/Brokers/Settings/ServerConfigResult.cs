using VA.Gov.Artemis.UI.Data.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using VA.Gov.Artemis.UI.Data.Models.ServerSettings;
using VA.Gov.Artemis.UI.Data.Brokers.Common; 

namespace VA.Gov.Artemis.UI.Data.Brokers.Settings
{
    public class ServerConfigResult: BrokerOperationResult
    {
        public ServerConfig ServerConfig { get; set; }

        public ServerConfigResult()
        {
            this.ServerConfig = new ServerConfig(); 
        }
    }
}