// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.UI.Data.Models;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using VA.Gov.Artemis.UI.Data.Models.ServerSettings;

namespace VA.Gov.Artemis.UI.Data.Brokers.Common
{
    public static class RpcBrokerUtility
    {
        public const string BrokerKeyName = "BrokerKey";

        public static IRpcBroker GetNewConnectedRpcBroker(ServerConfig serverConfig)
        {
            // *** Creates a new broker, connects and returns it ***

            IRpcBroker returnBroker = null;

            returnBroker = new RpcBroker(serverConfig.ServerName, serverConfig.ListenerPort);

            // *** Connect ***
            if (!returnBroker.Connect())
                returnBroker = null;

            return returnBroker;
        }

        public static bool CloseBroker(IRpcBroker broker)
        {
            // *** Closes a passed-in broker ***

            bool returnVal = false;

            if (broker != null)
            {
                broker.Disconnect();

                if (broker is RpcBroker)
                {
                    RpcBroker rpcBroker = (RpcBroker)broker;
                    rpcBroker.Dispose();
                }
                returnVal = true; 
            }

            return returnVal;
        }
                
    }
}