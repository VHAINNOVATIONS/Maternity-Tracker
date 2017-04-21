// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

//using VA.Gov.Artemis.Vista.Common;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Xml;
using VA.Gov.Artemis.Core;

namespace VA.Gov.Artemis.Vista.Broker
{
    internal class RpcSocket : IDisposable
    {
        public string ServerName { get; private set; }
        public int ServerPort { get; private set; }

        private Socket currentSocket { get; set; }

        private DateTime lastOperation { get; set; }

        public RpcSocket(string tempServerName, int tempServerPort)
        {
            this.ServerName = tempServerName;
            this.ServerPort = tempServerPort;
        }

        public bool Connect()
        {
            // *** Connects the socket and returns true if successful ***

            bool returnVal = false;

            // Get host related information.
            try
            {
                // *** Check the port ***
                if ((this.ServerPort >= IPEndPoint.MinPort) && (this.ServerPort <= IPEndPoint.MaxPort))
                {
                    IPHostEntry hostEntry = Dns.GetHostEntry(this.ServerName);

                    // Loop through the AddressList to obtain the supported AddressFamily. This is to avoid
                    // an exception that occurs when the host IP Address is not compatible with the address family
                    // (typical in the IPv6 case).
                    foreach (IPAddress address in hostEntry.AddressList)
                    {
                        // *** Create an endpoint ***
                        IPEndPoint ipe = new IPEndPoint(address, this.ServerPort);

                        // TODO: Support IPv6

                        // *** Check address family ***
                        if (ipe.AddressFamily == AddressFamily.InterNetwork)
                        {
                            // *** Create the socket ***
                            Socket tempSocket = new Socket(ipe.AddressFamily, SocketType.Stream, ProtocolType.Tcp);

                            // *** Connect the socket ***
                            try
                            {
                                tempSocket.Connect(ipe);
                            }
                            catch (SocketException ex)
                            {
                                ErrorLogger.Log(ex, string.Format("Could not connect to the socket: {0}", ipe.ToString()));
                            }

                            try
                            {
                                // *** Check if connected ***
                                if (tempSocket.Connected)
                                {
                                    // *** Use as our current socket ***
                                    this.currentSocket = tempSocket;

                                    // *** Set the timeout to a very long value ***
                                    //this.currentSocket.ReceiveTimeout = 180000;
                                    this.currentSocket.ReceiveTimeout = 3600000;

                                    // *** Indicate success ***
                                    returnVal = true;

                                    // *** Set last operation ***
                                    this.lastOperation = DateTime.Now; 

                                    // *** Finished ***
                                    break;
                                }
                                else
                                {
                                    // *** Try next address ***
                                    continue;
                                }
                            }
                            catch { }
                        }
                    }
                }
            }
            catch (SocketException ex)
            {
                ErrorLogger.Log(ex, "Error in RpcSocket.Connect");
            }

            return returnVal;
        }

        public void Disconnect()
        {
            // *** Corollary to NetworkConnect ***
            // *** Disconnects the socket ***

            if (this.currentSocket != null)
                if (this.currentSocket.Connected)
                {
                    //// *** Create a BYE message ***
                    //RpcMessage rpcMessage = RpcMessage.CreateCloseMessage();

                    //// *** Check if message was successful, and send ***
                    //if (rpcMessage.Status == RpcMessageStatus.Ready)
                    //{
                    //    RpcResult result = NetCall(rpcMessage.Data);
                    //}

                    this.currentSocket.Shutdown(SocketShutdown.Both); 

                    // *** Close the socket ***
                    this.currentSocket.Close();
                }
        }

        public bool Connected()
        {
            bool returnVal = false;

            if (this.currentSocket != null)
                if (this.currentSocket.Connected)
                    returnVal = true;

            return returnVal;
        }

        public RpcResponse SendMessage(string msg)
        {
            // *** Send RPC as bytes on socket and receive bytes back ***

            RpcResponseBuilder returnBuilder = new RpcResponseBuilder();

            //TraceLogger.Log(string.Format("RpcSocket.SendMessage - TimedOut={0}", this.TimedOut)); 

            lock (this.currentSocket)
            {
                // *** Convert to bytes ***
                byte[] bytes = Encoding.ASCII.GetBytes(msg);

                try
                {
                    // *** Send bytes to socket ***
                    this.currentSocket.Send(bytes);

                    // *** Set last operation ***
                    this.lastOperation = DateTime.Now;

                    // *** Get server packet bytes ***
                    byte[] packetBytes = GetServerPacket();

                    // *** Add to result ***
                    returnBuilder.SetSecuritySegment(packetBytes);

                    // *** Get application packet bytes ***
                    packetBytes = GetServerPacket();

                    // *** Add to result ***
                    returnBuilder.SetApplicationSegment(packetBytes);

                    byte[] socketBuffer = new byte[1024];
                    int retries = 0;
                    bool keepGoing = true;

                    // *** Receive bytes from socket in a loop ***
                    while (keepGoing)
                    {
                        // *** Receive bytes ***
                        int bytesRead = this.currentSocket.Receive(socketBuffer);

                        // *** Check number of bytes read ***
                        if (bytesRead > 0)
                        {
                            byte[] actualBytes = new byte[bytesRead];

                            Array.Copy(socketBuffer, actualBytes, bytesRead);

                            // *** Append bytes to the result ***
                            bool reachedEnd = returnBuilder.AppendData(actualBytes);

                            // *** Check if end reached ***
                            if (reachedEnd)
                                keepGoing = false; // *** Done ***
                        }
                        else
                        {
                            // *** No bytes read, retry ***
                            if (retries < 3)
                            {
                                // *** Ok to retry, sleep 1/2 sec ***
                                retries++;
                                Thread.Sleep(500);
                            }
                            else
                            {
                                // *** Too many retries ***
                                returnBuilder.SetInformationalMessage("Data could not be received from socket");
                                returnBuilder.SetFailType(RpcResponseFailType.Retries);

                                // *** Stop looping ***
                                keepGoing = false;
                            }
                        }
                    }
                }
                catch (SocketException sockEx)
                {
                    string timeoutMsg = string.Format("(TimedOut={0})", this.TimedOut);
                    VistaLogger.Log(timeoutMsg, "", -1, null, ""); 
                    ErrorLogger.Log(sockEx, "A problem occurred communicating with the socket. " + timeoutMsg);
                    returnBuilder.SetInformationalMessage("A problem occurred communicating with the socket.");
                    returnBuilder.SetFailType(RpcResponseFailType.SocketError);
                }
            }

            return returnBuilder.ToResponse();
        }

        //public int ReceiveTimeout
        //{
        //    get
        //    {
        //        int returnVal = -1;

        //        if (this.currentSocket != null)
        //            returnVal = this.currentSocket.ReceiveTimeout;

        //        return returnVal;
        //    }
        //    set
        //    {
        //        int newVal = (value > 14000) ? value : 14000;
        //        this.currentSocket.ReceiveTimeout = newVal; 
        //        VistaLogger.Log(string.Format("(Info) ReceiveTimeout set to {0}", newVal), "", -1, null, "");
        //    }
        //}

        private byte[] GetServerPacket()
        {
            // *** Gets bytes from the current socket ***

            byte[] bytes = new byte[1];

            if (this.currentSocket != null)
            {
                this.currentSocket.Receive(bytes);

                int buflen = bytes[0];

                bytes = new byte[buflen];

                this.currentSocket.Receive(bytes);
            }

            return bytes;
        }

        public void Dispose()
        {
            if (this.currentSocket != null)
                this.currentSocket.Dispose();
        }

        public string GetXmlDescription(bool partial)
        {
            StringBuilder sb = new StringBuilder();
            using (XmlWriter writer = XmlTextWriter.Create(sb))
            {
                if (!partial) 
                    writer.WriteStartDocument();

                writer.WriteStartElement("RpcSocket");

                writer.WriteElementString("ServerName", this.ServerName);
                writer.WriteElementString("ServerPort", this.ServerPort.ToString()); 

                writer.WriteEndElement();

                if (!partial) 
                    writer.WriteEndDocument(); 
            }
            return sb.ToString();            
        }

        public bool TimedOut
        {
            get
            {
                bool returnVal = false;

                if (this.currentSocket != null) 
                    if (this.lastOperation.AddMilliseconds(this.InactivityTimeout) < DateTime.Now)
                        returnVal = true; 

                return returnVal;
            }
        }

        // *** After this amount of time (in milliseconds), the connection to VistA will be unresponsive ***
        public int InactivityTimeout { get; set; }
    }
}
