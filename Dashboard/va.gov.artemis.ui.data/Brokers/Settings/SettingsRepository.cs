using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.UI.Data.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using VA.Gov.Artemis.UI.Data.Models.ServerSettings;
using VA.Gov.Artemis.UI.Data.Brokers.Common;
using VA.Gov.Artemis.UI.Data.Brokers.Cda;

namespace VA.Gov.Artemis.UI.Data.Brokers.Settings
{
    public class SettingsRepository: ISettingsRepository
    {
        public ServerConfigResult GetServerData()
        {
            ServerConfigResult returnResult = new ServerConfigResult(); 

            int listenerPort;

            returnResult.ServerConfig.ServerName = ConfigurationManager.AppSettings["vistaServer"];
            string listenerPortRaw = ConfigurationManager.AppSettings["vistaListenerPort"];

            if (int.TryParse(listenerPortRaw, out listenerPort))
            {
                returnResult.ServerConfig.ListenerPort = listenerPort;
                returnResult.SetResult(true, ""); 
            }
            else
                returnResult.SetResult(false, string.Format("Invalid Listener Port: [{0}]", listenerPortRaw));

            return returnResult;
        }

        public BrokerOperationResult SetServerData(ServerConfig serverConfig)
        {
            BrokerOperationResult returnResult = new BrokerOperationResult();

            ConfigurationManager.AppSettings["vistaServer"] = serverConfig.ServerName;
            ConfigurationManager.AppSettings["vistaListenerPort"] = serverConfig.ListenerPort.ToString();
          
            returnResult.SetResult(true, ""); 

            return returnResult;
        }

        public BrokerOperationResult TestServerConnection(string serverName, string serverPort)
        {
            BrokerOperationResult returnResult = new BrokerOperationResult();

            int port = 0;

            if (int.TryParse(serverPort, out port))
            {
                //using (RpcBroker broker = new RpcBroker(serverName, port))
                ServerConfig config = new ServerConfig() { ServerName = serverName, ListenerPort = port };

                IRpcBroker broker = RpcBrokerUtility.GetNewConnectedRpcBroker(config);

                if (broker != null)
                {
                    returnResult.SetResult(true, "");
                    broker.Disconnect();
                }
            }

            return returnResult;
        }

        public CdaSettingsResult GetCdaSettings()
        {
            CdaSettingsResult result = new CdaSettingsResult(); 

            result.ManufacturerModelName = ConfigurationManager.AppSettings["cdaManufacturerModelName"];
            result.SoftwareName = ConfigurationManager.AppSettings["cdaSoftwareName"];
            result.ProviderOrganizationPhone = ConfigurationManager.AppSettings["cdaProviderOrganizationPhone"];
            result.CdaExportFolder = ConfigurationManager.AppSettings["cdaExportFolder"];

            result.Success = true;

            return result; 
        }

    }

}