// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

// *** Basic representation of a message to be send through the socket ***

using VA.Gov.Artemis.Vista.Utility;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.Vista.Broker
{
    internal class RpcMessage
    {
        // *** Currently the only prefix in use ***
        private const string xwbPrefix = "[XWB]";

        // *** The current status of the message ***
        public RpcMessageStatus Status { get; set; }

        // *** The content of the message ***
        public string Data { get; set; }

        // *** Other information ***
        public string InformationalMessage { get; set; }

        // *** Private constructor so Create* is used ***
        private RpcMessage()
        {
        }

        public static RpcMessage CreateRpcMessage(string api, string rpcver, List<RpcParameter> parameterList)
        {
            // *** Creates an RPC Message object ***

            RpcMessage returnMessage = new RpcMessage(); 

            // *** Attampt to construct an rpc message string from parameters ***

            StringBuilder messageBuilder = new StringBuilder();
            StringBuilder parametersBuilder = new StringBuilder(); 

            messageBuilder.Append(xwbPrefix);
            messageBuilder.Append("11302");

            string temp = returnMessage.SPack(rpcver);
            messageBuilder.Append(temp);

            temp = returnMessage.SPack(api);
            messageBuilder.Append(temp);

            parametersBuilder.Append("5");

            if (parameterList != null)
                foreach (RpcParameter param in parameterList)
                {
                    switch (param.ParameterType)
                    {
                        case RpcParameterType.Literal:
                            parametersBuilder.Append("0" + returnMessage.LPack3(param.Value) + "f");
                            break;
                        case RpcParameterType.Reference:
                            parametersBuilder.Append("1" + returnMessage.LPack3(param.Value) + "f");
                            break;
                        case RpcParameterType.Empty:
                            parametersBuilder.Append("4f");
                            break;
                        case RpcParameterType.List:
                            parametersBuilder.Append("2" + returnMessage.AddMults(param.Mult));
                            break;
                        case RpcParameterType.Global:
                            parametersBuilder.Append("3" + returnMessage.AddMults(param.Mult));
                            break;
                        case RpcParameterType.Stream:
                            parametersBuilder.Append("5" + returnMessage.LPack3(param.Value) + 'f');
                            break;
                    }
                }
            
            if (parametersBuilder.ToString() == "5")
                parametersBuilder.Append("4f");
            
            messageBuilder.Append(parametersBuilder.ToString()); 

            messageBuilder.Append("\x4"); 

            if (returnMessage.Status == RpcMessageStatus.Uknown)
            {
                returnMessage.Data = messageBuilder.ToString();
                returnMessage.Status = RpcMessageStatus.Ready;
                returnMessage.InformationalMessage = "Message built successfully"; 
            }

            return returnMessage; 
        }

        public static RpcMessage CreateInitializeMessage(string localAddress, string localHost)
        {
            // *** Create initialize message from passed in parameters ***

            RpcMessage returnMessage = new RpcMessage(); 

            //string msg = "[XWB]10304" + '\n' + "TCPConnect50" + LPack3(localAddress) + "f0" + LPack3("0") + "f0" + LPack3(localHost) + "f" + (char)4;
            string msgFormat = "[XWB]10304\nTCPConnect50{0}f0{1}f0{2}f" + (char)4;

            // *** Pack parameters ***
            string arg0 = returnMessage.LPack3(localAddress);
            string arg1 = returnMessage.LPack3("0");
            string arg2 = returnMessage.LPack3(localHost); 
                        
            // *** If status not error, then still good ***
            if (returnMessage.Status == RpcMessageStatus.Uknown)
            {
                returnMessage.Data = string.Format(msgFormat, arg0, arg1, arg2); 
                returnMessage.Status = RpcMessageStatus.Ready;
                returnMessage.InformationalMessage = "Message built successfully"; 
            }

            return returnMessage; 
        }

        public static RpcMessage CreateCloseMessage()
        {
            // *** Create standard close message ***

            RpcMessage returnMessage = new RpcMessage(); 

            returnMessage.Data = "[XWB]10304" + (char)5 + "#BYE#" + (char)4;
            returnMessage.Status = RpcMessageStatus.Ready; 

            return returnMessage; 
        }

        private string AddMults(Mult mult)
        {
            string res = String.Empty;
            bool is_seen = false;
            string key = mult.First;
            while (key != String.Empty)
            {
                if (is_seen) res += "t";
                string val = mult.Value(key);
                if (val == String.Empty)
                {
                    val = "\x1";
                }
                res += LPack3(key) + LPack3(val);
                is_seen = true;
                key = mult.Order(key, 1);
            }
            if (!is_seen)
            {
                res += LPack3(String.Empty);
            }
            res += "f";

            // *** Check current status ***
            if (this.Status == RpcMessageStatus.Error)
                res = ""; 

            return res;
        }

        private string StrPack(string s, int l)
        {
            return s.Length.ToString(new String('0', l)) + s;
        }

        private string VarPack(string s)
        {
            if (s == String.Empty) s = "0";
            return "|" + (char)s.Length + s;
        }

        private string LPack3(string s)
        {
            string returnVal = "";

            if (s.Length > 999)
            {
                //if (BrokerError != null) BrokerError(this, "RPC Broker Error: Attempting to L-Pack a string longer than 999 characters.", null);
                //throw new Exception("Unable to assemble XWB broker message");
                this.Status = RpcMessageStatus.Error;
                this.InformationalMessage = "Unable to assemble XWB broker message: Attempted to L-Pack a string longer than 999 characters.";
            }
            else
            {
                returnVal = String.Format("{0:d3}{1}", s.Length, s);
            }

            return returnVal; 
        }

        private string SPack(string s)
        {
            string returnVal = "";

            if (s.Length > 255)
            {
                //if (BrokerError != null) BrokerError(this, "RPC Broker Error: Attempting to S-Pack a string longer than 255 characters.", null);
                //throw new Exception("Unable to assemble XWB broker message");
                this.Status = RpcMessageStatus.Error;
                this.InformationalMessage = "Unable to assemble XWB broker message: Attempted to S-Pack a string longer than 255 characters.";
            }
            else
            {
                char c = (char)s.Length;
                returnVal = c + s;
            }

            return returnVal;
        }

    }
}
