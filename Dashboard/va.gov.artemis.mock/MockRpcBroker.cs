using System.Collections.Generic;
using VA.Gov.Artemis.Vista.Broker;

namespace VA.Gov.Artemis.UI.Mock
{
    public class MockRpcBroker: IRpcBroker
    {
        public Dictionary<string, RpcResponse> PresetBrokerResponses { get; set; }

        public string PresetContext { get; set; }
        public bool PresetConnected { get; set; }
        public RpcResponse PresetContextResponse { get; set; }
        public string PresetXmlDescription { get; set; }
        public int PresetTimeout { get; set; }

        public MockRpcBroker() 
        {
            this.PresetBrokerResponses = new Dictionary<string, RpcResponse>(); 
        }

        public string CurrentContext
        {
            get { return this.PresetContext; }
        }

        public bool Connect()
        {
            return this.PresetConnected;
        }

        public RpcResponse CallRpc(string context, string rpcName, string rpcVersion, object[] args)
        {
            RpcResponse returnVal = null;

            bool found = this.PresetBrokerResponses.TryGetValue(rpcName, out returnVal);

            if (!found)
                returnVal = new RpcResponse(RpcResponseFailType.Unspecified, "No mocked response found"); 

            return returnVal; 
        }

        public RpcResponse CreateContext(string context)
        {
            return this.PresetContextResponse;
        }

        public string GetXmlDescription(bool partial)
        {
            return this.PresetXmlDescription;
        }

        public int SocketInactivityTimeout
        {
            get { return this.PresetTimeout; }
        }

        public void Disconnect()
        {            
        }
    }

    internal class PresetBrokerData
    {

    }
}
