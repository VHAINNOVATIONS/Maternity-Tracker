// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

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