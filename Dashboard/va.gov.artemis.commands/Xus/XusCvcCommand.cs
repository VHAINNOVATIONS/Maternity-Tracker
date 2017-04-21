// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

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
    public class XusCvcCommand: CommandBase 
    {
        //public XusCvcCommand(IRpcBroker newBroker, string origVerifyCode, string newVerifyCode, string confirmNewVerifyCode) :
        //    base(newBroker) 
        //{
        //    AddCommandArguments(origVerifyCode, newVerifyCode, confirmNewVerifyCode); 
        //}

        /// <summary>
        /// Creates the command
        /// </summary>
        /// <param name="newBroker">An object which allows communication with VistA and implements IRpcBroker</param>
        public XusCvcCommand(IRpcBroker newBroker) : base(newBroker)
        {
            this.Context = "DSIO GUI CONTEXT";
        }

        public override string RpcName { get { return "XUS CVC";}}

        public override string Version {get { return "0";}}
        
        public void AddCommandArguments(string origVerifyCode, string newVerifyCode, string confirmNewVerifyCode)
        {
            EncryptedString es1 = VistAHash.Encrypt(origVerifyCode);
            EncryptedString es2 = VistAHash.Encrypt(newVerifyCode);
            EncryptedString es3 = VistAHash.Encrypt(confirmNewVerifyCode);

            string argsFormat = "{0}^{1}^{2}";

            this.CommandArgs = new object[] { string.Format(argsFormat, es1, es2, es3) };
        }

        protected override void ProcessResponse()
        {
            if (this.Response.Lines.Length > 0)
            {
                if (this.Response.Lines[0] == "0")
                    this.Response.Status = RpcResponseStatus.Success;
                else
                {
                    this.Response.Status = RpcResponseStatus.Fail;
                    this.Response.FailType = RpcResponseFailType.Unspecified;
                    if (this.Response.Lines.Length > 1)
                        this.Response.InformationalMessage = this.Response.Lines[1];
                }
            }            
        }

        // *** Don't log arguments/parameters ***
        protected override bool Sensitive { get { return true; } }

    }
}
