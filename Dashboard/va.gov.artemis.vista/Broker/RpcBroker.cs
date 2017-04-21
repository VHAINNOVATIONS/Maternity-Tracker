// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using VA.Gov.Artemis.Vista.Utility;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Threading.Tasks;
using System.Xml;
using VA.Gov.Artemis.Core;

namespace VA.Gov.Artemis.Vista.Broker
{
    public class RpcBroker : IDisposable, IRpcBroker
    {
        private bool disposed = false; 

        private RpcSocket vistaSocket { get; set; }

        public string CurrentContext { get; private set; }

        // *** Initialized means the initialization message was sent and ***
        // *** the proper response was received ***

        private bool initialized { get; set; }

        public RpcBroker(string tempServerName, int tempServerPort)
        {
            this.vistaSocket = new RpcSocket(tempServerName, tempServerPort);
            this.vistaSocket.InactivityTimeout = 3600000; 
        }

        public bool Connect()
        {
            bool returnVal = false;

            DateTime start = DateTime.Now; 

            if (this.vistaSocket != null)
            {
                bool ok = this.vistaSocket.Connected();

                // *** Make the connection ***
                if (!ok)
                {
                    ok = this.vistaSocket.Connect();

                    // *** Log successful connection ***
                    DateTime end = DateTime.Now;
                    string elapsed = (end - start).TotalSeconds.ToString("######0.###");
                    string resultMsg = (ok) ? "Success" : "Fail"; 
                    VistaLogger.Log("Connect", elapsed, -1, null, resultMsg);
                }

                if (ok)
                {
                    ok = this.initialized;

                    // *** Send the connection initialization ***
                    if (!ok)
                    {
                        this.initialized = SendConnectionInitialization();
                        ok = this.initialized;

                        // *** Set the timeout ***
                        this.SetSocketTimeout();
                    }

                    if (ok)
                        returnVal = true;
                }
            }

            return returnVal;
        }

        //public Response CallRPCInContext(string context, string api, object[] args)
        //{
        //    if (socket == null) throw new RPCException("Connection broken.");

        //    lock (socket)
        //    {
        //        if (context != current_context)
        //        {
        //            if (!ChangeContext(context))
        //            {
        //                throw new Exception("Unable to change context.");
        //            }
        //        }
        //        return CallRPC(api, args);
        //    }
        //}

        //public bool ChangeContext(string context)
        //{
        //    try
        //    {
        //        string res = CallRPC("XWB CREATE CONTEXT", new string[] { VistAHash.Encrypt(context) });
        //        if (res == "1")
        //        {
        //            current_context = context;
        //            return true;
        //        }
        //    }
        //    catch
        //    {
        //    }
        //    current_context = String.Empty;
        //    return false;
        //}

        public RpcResponse CallRpc(string context, string rpcName, string rpcVersion, object[] args)
        {
            RpcResponse returnVal = null;

            // *** Check the context ***
            bool contextValid = false; 

            if (context == this.CurrentContext)
                contextValid = true; 
            else 
            {
                RpcResponse changeContextResponse = this.CreateContext(context); 

                if (changeContextResponse.Status == RpcResponseStatus.Success) 
                    contextValid = true; 
                else                
                    returnVal = changeContextResponse; 
            }

            if (contextValid) 
                returnVal = CallRpcInCurrentContext(rpcName, rpcVersion, args);

            return returnVal; 
        }
                                
        //public Response ChangeContext(string context, string rpcName, string rpcVersion, object[] args)
        public RpcResponse CreateContext(string context)
        {
            RpcResponse returnVal = null;

            returnVal = this.CallRpcInCurrentContext ("XWB CREATE CONTEXT", "0", new string [] {VistAHash.Encrypt(context)});

            object[] args = new object[] { string.Format("(hashed){0}", context) }; 

            VistaLogger.Log("XWB CREATE CONTEXT", returnVal.ExecutionTime, returnVal.Data.Length, args, returnVal.Status.ToString()); 

            // *** Check returnVal status first ***
            if (returnVal.Status == RpcResponseStatus.Success)
            {
                if (returnVal.Data == "1")
                {
                    returnVal.Status = RpcResponseStatus.Success;
                    this.CurrentContext = context;
                }
                else
                {
                    returnVal.Status = RpcResponseStatus.Fail;
                    returnVal.FailType = RpcResponseFailType.InvalidContext;
                    returnVal.InformationalMessage = "Could not change context";
                    this.CurrentContext = "";
                }
            }

            return returnVal; 
        }

        public string GetXmlDescription(bool partial)
        {
            StringBuilder sb = new StringBuilder();
            using (XmlWriter writer = XmlTextWriter.Create(sb))
            {
                if (!partial)
                    writer.WriteStartDocument();

                writer.WriteStartElement("RpcBroker");

                writer.WriteElementString("CurrentContext", this.CurrentContext);
                writer.WriteElementString("Initialized", this.initialized.ToString());

                if (this.vistaSocket != null)
                    writer.WriteRaw(this.vistaSocket.GetXmlDescription(true));

                writer.WriteEndElement();

                if (!partial)
                    writer.WriteEndDocument();
            }
            return sb.ToString();
        }

        // *** Gets inactivity timeout from socket (milliseconds) ***
        public int SocketInactivityTimeout
        {
            get
            {
                int returnVal = 0;
                if (this.vistaSocket != null)
                    returnVal = this.vistaSocket.InactivityTimeout;

                return returnVal;
            }
        }

        public void Disconnect()
        {
            DateTime start = DateTime.Now; 

            if (this.vistaSocket != null)
            {
                // *** Send the connection disconnect message ***
                if (this.SendConnectionDisconnect())
                    this.initialized = false;

                // *** Disconnect ***
                this.vistaSocket.Disconnect();

                DateTime end = DateTime.Now;

                string elapsed = (end - start).TotalSeconds.ToString("######0.###");

                VistaLogger.Log("Disconnect", elapsed, -1, null, "Success"); 
            }
        }

        private RpcResponse CallRpcInCurrentContext(string rpcName, string rpcVersion, object[] args)
        {
            RpcResponse returnVal = null;

            // *** First check the connection ***
            if (this.Connect())
            {
                // *** First compile the parameter list ***
                List<RpcParameter> parms = GetParameterList(args);

                // *** Then get a message object ***
                RpcMessage message = RpcMessage.CreateRpcMessage(rpcName, rpcVersion, parms);

                // *** Check if message is ready ***
                if (message.Status == RpcMessageStatus.Ready)
                {
                    DateTime start = DateTime.Now;

                    returnVal = this.vistaSocket.SendMessage(message.Data);

                    if (returnVal != null)
                    {
                        returnVal.StartTime = start;
                        returnVal.EndTime = DateTime.Now;

                        // *** If nothing in return, indicate failure ***
                        if (string.IsNullOrWhiteSpace(returnVal.Data))
                        {
                            returnVal.Status = RpcResponseStatus.Unknown;
                            returnVal.InformationalMessage = "Nothing returned";
                        }
                    }
                    else
                    {
                        returnVal = new RpcResponse(RpcResponseFailType.Unspecified, "SendMessage did not return anything");
                        returnVal.StartTime = start;
                        returnVal.EndTime = DateTime.Now;
                    }
                }
                else
                    returnVal = new RpcResponse(RpcResponseFailType.InvalidMessage, message.InformationalMessage);
            }
            else
                returnVal = new RpcResponse(RpcResponseFailType.NotConnected, "Could not connect to Vista");

            return returnVal;
        }

        private List<RpcParameter> GetParameterList(object[] args)
        {
            // *** Gets a list of parameters from an array of objects ***
            List<RpcParameter> parameterList = new List<RpcParameter>();

            if (args != null)
            {
                for (int i = 0; i < args.Length; i++)
                {
                    RpcParameter newParameter = new RpcParameter(args[i]);
                    parameterList.Add(newParameter);
                }
            }

            return parameterList;
        }

        private bool SendConnectionInitialization()
        {
            // *** Connect using the socket and return if successful ***

            bool returnVal = false;

            // *** Get the client host name ***
            string localhost = Dns.GetHostName();

            // *** Get the client IPv4 Address ***
            IPAddress localIPv4Address = GetIPv4Address(localhost);

            // *** Get string version of local IPv4 address ***
            string localAddress = localIPv4Address.ToString();

            // *** Create an initialize message ***
            RpcMessage rpcMessage = RpcMessage.CreateInitializeMessage(localAddress, localhost);

            if (rpcMessage.Status == RpcMessageStatus.Ready)
            {
                // *** If message successfully created ***

                // *** Make the call using message data ***
                RpcResponse response = this.vistaSocket.SendMessage(rpcMessage.Data);

                // *** Check for expected result ***
                if (response.Data == "accept")
                    returnVal = true;
            }

            return returnVal;
        }

        private IPAddress GetIPv4Address(string strHostName)
        {
            IPHostEntry ipEntry = Dns.GetHostEntry(strHostName);
            IPAddress[] addr = ipEntry.AddressList;

            for (int i = 0; i < addr.Length; i++)
            {
                if ((addr[i].AddressFamily != AddressFamily.InterNetworkV6) &&
                     (!IPAddress.IsLoopback(addr[i])))
                    return addr[i];
            }

            return null;
        }

        private bool SendConnectionDisconnect()
        {
            // *** Send the disconnect message ***

            bool returnVal = false;

            if (this.vistaSocket != null)
                if (this.vistaSocket.Connected())
                {
                    // *** Create a BYE message ***
                    RpcMessage rpcMessage = RpcMessage.CreateCloseMessage();

                    // *** Check if message was successful, and send ***
                    if (rpcMessage.Status == RpcMessageStatus.Ready)
                    {
                        RpcResponse response = this.vistaSocket.SendMessage(rpcMessage.Data);

                        if (response.Data == "#BYE#")
                            returnVal = true;

                        VistaLogger.Log("Disconnect", "", -1, null, "");
                    }
                }

            return returnVal;
        }
                
        private void SetSocketTimeout()
        {
            RpcResponse response = this.CallRpcInCurrentContext("XWB GET BROKER INFO", "0", null);

            VistaLogger.Log("XWB GET BROKER INFO", response.ExecutionTime, response.Data.Length, new object[] { "" }, response.Status.ToString()); 

            int timeout; 
            if (int.TryParse(response.Data, out timeout) )
            {
                // *** Value is in seconds, convert to milliseconds ***
                this.vistaSocket.InactivityTimeout = timeout * 1000;
            } 
        }
        
        public void Dispose()
        {
            this.Dispose(true);
            GC.SuppressFinalize(this);

        }

        protected virtual void Dispose(bool disposing)
        {
            if (disposed)
                return;

            if (disposing)
            {
                Debug.WriteLine("RpcBroker.Dispose: Disposing...");

                if (this.vistaSocket != null)
                    this.vistaSocket.Dispose();
            }

            disposed = true; 
        }
    }

}
