// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Vista.Commands;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.Commands.Dsio.Tracking
{
    public class DsioCreateTrackingLogCommand: DsioCommand 
    {
        /// <summary>
        /// Creates the command
        /// </summary>
        /// <param name="newBroker">An object which allows communication with VistA and implements IRpcBroker</param>
        public DsioCreateTrackingLogCommand(IRpcBroker newBroker): base(newBroker) {}

        public override string RpcName
        {
            get { return "WEBM CREATE TRACKING LOG"; }
        }

        protected override void ProcessResponse()
        {
            if (string.IsNullOrWhiteSpace(this.Response.Data))
            {
                this.Response.Status = RpcResponseStatus.Fail;
                this.Response.InformationalMessage = "No return value";
            }
            else
            {
                string piece1 = Util.Piece(this.Response.Lines[0], Caret, 1);
                string piece2 = Util.Piece(this.Response.Lines[0], Caret, 2);

                switch (piece1)
                {
                    case "1":
                        this.Response.Status = RpcResponseStatus.Success;
                        break;
                    case "-1":
                    default:
                        this.Response.Status = RpcResponseStatus.Fail;
                        this.Response.InformationalMessage = piece2;
                        break;
                }                        
            }

        }

        public void AddCommandArguments(string dfn, string eventType, string reason, string[] comment)
        {
            this.CommandArgs = new object[] {dfn, eventType, reason, comment};

        }
    }
}
