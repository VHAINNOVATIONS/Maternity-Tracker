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
    public class XusSignonSetupCommand : CommandBase
    {
        public XusSignonSetup SignonSetup { get; set; }

        /// <summary>
        /// Creates the command
        /// </summary>
        /// <param name="newBroker">An object which allows communication with VistA and implements IRpcBroker</param>
        public XusSignonSetupCommand(IRpcBroker newBroker) :
            base(newBroker) { }

        public override string RpcName
        {
            get { return "XUS SIGNON SETUP"; }
        }

        public override string Version
        {
            get { return "0"; }
        }

        public void AddCommandArguments()
        {
            // TODO: Add any parameters as needed before calling execute...
            //this.CommandArgs = new object[] { "", "", "" }; 
        }

        protected override void ProcessResponse()
        {
            this.SignonSetup = new XusSignonSetup();

            string[] lines = Util.Split(this.Response.Data);

            if (lines.Length < 4)
            {
                this.Response.Status = RpcResponseStatus.Fail;
                this.Response.FailType = RpcResponseFailType.UnexpectedResultFormat;
                this.Response.InformationalMessage = "Unexpected Response: Less than 4 lines";
            }
            else
            {
                this.SignonSetup = GetSignonSetupFromLines(lines);

                this.Response.Status = RpcResponseStatus.Success;
            }

        }

        private XusSignonSetup GetSignonSetupFromLines(string[] lines)
        {
            XusSignonSetup returnVal = new XusSignonSetup()
            {
                ServerName = lines[0],
                Volume = lines[1],
                UCI = lines[2],
                Port = lines[3],
                IsSignonRequired = true,
                IsProductionAccount = false,
                DomainName = String.Empty,
                IntroMessage = String.Empty
            };

            if (lines.Length > 5)
            {
                returnVal.IsSignonRequired = (lines[5] == "1");

                if (lines.Length > 7)
                {
                    returnVal.DomainName = lines[6];
                    returnVal.IsProductionAccount = (lines[7] == "1");
                }
            }

            return returnVal;
        }

    }
}
