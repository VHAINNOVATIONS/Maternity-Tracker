// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using VA.Gov.Artemis.Vista.Broker;
//using VA.Gov.Artemis.UI.Data.Log;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Net.Sockets;
using System.Web;
using VA.Gov.Artemis.Core;

namespace VA.Gov.Artemis.UI.Data.Brokers.Common
{
    public static class BrokerStore
    {
        private static readonly Dictionary<string, IRpcBroker> brokerStore = new Dictionary<string, IRpcBroker>();

        public static string Add(IRpcBroker rpcBroker)
        {
            string returnVal = ""; 

            if (rpcBroker != null)
            {
                returnVal = Guid.NewGuid().ToString();

                lock (brokerStore)
                    brokerStore.Add(returnVal, rpcBroker);

                TraceLogger.Log(string.Format("BrokerStore.Add - Broker added to broker store [Count: {0}]", BrokerStore.brokerStore.Count)); 

            }

            return returnVal; 
        }

        public static IRpcBroker Get(string key)
        {
            IRpcBroker returnVal = null; 

            if (!string.IsNullOrWhiteSpace(key))
                lock (brokerStore)
                    brokerStore.TryGetValue(key, out returnVal);

            TraceLogger.Log(string.Format("BrokerStore.Get - Broker retrieved from broker store [Count: {0}]", BrokerStore.brokerStore.Count)); 

            return returnVal; 
        }

        public static bool Delete(string key)
        {
            bool returnVal = true;

            if (!string.IsNullOrWhiteSpace(key))
                lock (brokerStore)
                    if (brokerStore.ContainsKey(key))
                        brokerStore.Remove(key);

            TraceLogger.Log(string.Format("BrokerStore.Delete - Broker deleted from broker store [Count: {0}]", BrokerStore.brokerStore.Count)); 

            return returnVal; 
        }

        public static void Cleanup()
        {
            if (BrokerStore.brokerStore != null)
                lock (brokerStore)
                {
                    foreach (RpcBroker broker in BrokerStore.brokerStore.Values)
                    {
                        broker.Disconnect();
                        broker.Dispose();
                    }

                    brokerStore.Clear();
                }

            Debug.WriteLine(string.Format(" == Brokers cleaned up [Count: {0}] == ", BrokerStore.brokerStore.Count));
        }

        public static int Count
        {
            get
            {
                int returnVal = 0;

                if (brokerStore != null)
                    lock (brokerStore)
                        returnVal = brokerStore.Count; 

                return returnVal;
            }
        }

    }
}