using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Vista.Common;
using VA.Gov.Artemis.Vista.Utility;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Vista.Commands;

namespace VA.Gov.Artemis.Commands.Xus
{
    public class XusAvCodeCommand : CommandBase
    {
        public XusAvCodeResult SignonResults { get; set; }

        /// <summary>
        /// Creates the command
        /// </summary>
        /// <param name="newBroker">An object which allows communication with VistA and implements IRpcBroker</param>
        public XusAvCodeCommand(IRpcBroker newBroker) : base(newBroker) 
        { 
        }

        public void AddCommandArguments(string accessCode, string verifyCode)
        {
            EncryptedString avParameter = GetAVParameter(accessCode, verifyCode);

            this.CommandArgs = new object[] { avParameter };        
        }

        public override string RpcName { get { return "XUS AV CODE"; } }

        public override string Version { get { return "0"; } }

        protected override void ProcessResponse()
        {
            this.SignonResults = new XusAvCodeResult();

            if (string.IsNullOrEmpty(this.Response.Data))
            {
                //this.SignonResults.BrokerSuccess = false; 
                //this.SignonResults.BrokerMessage = "RPC Returned Empty Results";
                this.Response.Status = RpcResponseStatus.Fail;
                this.Response.FailType = RpcResponseFailType.UnexpectedResultEmpty;
            }
            else
            {

//R(0)=DUZ if sign-on was OK, zero if not OK.
//R(1)=(0=OK, 1,2...=Can't sign-on for some reason).
//R(2)=verify needs changing.
//R(3)=Message.
//R(4)=0
//R(5)=count of the number of lines of text, zero if none.
//R(5+n)=message text.

                string[] lines = Util.Split(this.Response.Data);

                if (lines.Length > 0)
                    if (lines[0].Contains("ERROR")) 
                        this.SignonResults.Success = false; 
                    else 
                        if (lines[0] != "0")
                        {
                            this.SignonResults.Success = true;
                            this.SignonResults.Duz = lines[0];
                        }

                if (lines.Length > 1)
                {
                    this.SignonResults.FailReasonCode = lines[1];
                    if (lines[1] == "1")
                        this.SignonResults.AcccountIsLocked = true; 
                }

                if (lines.Length > 2)
                    if (lines[2] == "1")
                        this.SignonResults.MustChangeVerifyCode = true;

                if (lines.Length > 3)
                    this.SignonResults.RpcMessage = lines[3];

                if (lines.Length > 5)
                    if (lines[5] != "0")
                    {
                        List<string> msg = new List<string>();
                        for (int i = 6; i < lines.Length; i++)
                        {
                            msg.Add(lines[i]);
                        }
                        this.SignonResults.RpcAdditionalMessage = String.Join("\r\n", msg.ToArray());
                    }

                if (this.SignonResults.AcccountIsLocked)
                {
                    this.Response.Status = RpcResponseStatus.Fail;
                    this.Response.FailType = RpcResponseFailType.InvalidMessage;
                    this.Response.InformationalMessage = "Account Locked";
                }
                else if (this.SignonResults.MustChangeVerifyCode)
                {
                    this.Response.Status = RpcResponseStatus.Fail;
                    this.Response.FailType = RpcResponseFailType.InvalidMessage;
                    this.Response.InformationalMessage = this.SignonResults.RpcMessage;
                }
                else if (this.SignonResults.Success == false)
                {
                    this.Response.Status = RpcResponseStatus.Fail;
                    this.Response.FailType = RpcResponseFailType.Unspecified;
                    this.Response.InformationalMessage = this.SignonResults.RpcMessage;
                }
                else
                {
                    this.Response.Status = RpcResponseStatus.Success;
                    this.Response.InformationalMessage = "Logon Successful";
                }                
                                
            }
        }

        private EncryptedString GetAVParameter(string accessCode, string verifyCode)
        {
            EncryptedString returnVal;

            EncryptedString firstPass = VistAHash.Encrypt(accessCode + ";" + verifyCode); 
 
            returnVal = new EncryptedString(firstPass);

            return returnVal; 
        }

        // *** Don't log arguments/parameters ***
        protected override bool Sensitive { get { return true; } }
    }
}
