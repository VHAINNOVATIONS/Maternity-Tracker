// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.Commands.Dsio.Notes
{
    public class DsioDeleteANoteCommand: DsioCommand
    {
        /// <summary>
        /// Creates the command
        /// </summary>
        /// <param name="newBroker">An object which allows communication with VistA and implements IRpcBroker</param>
        public DsioDeleteANoteCommand(IRpcBroker newBroker): base(newBroker)
        {

        }

        public override string RpcName
        {
            get { return "WEBM DELETE A NOTE"; }
        }

        public void AddCommandArguments(string ien, string justification)
        {
            this.CommandArgs = new object[] { ien, justification };
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

                int returnCode = -1;
                if (int.TryParse(piece1, out returnCode))
                    if (returnCode > 0)
                        this.Response.Status = RpcResponseStatus.Success;
                    else
                    {
                        this.Response.Status = RpcResponseStatus.Fail;
                        this.Response.InformationalMessage = piece2;
                    }
                else
                    this.Response.Status = RpcResponseStatus.Fail; 

                //switch (piece1)
                //{
                //    case "-1":
                //        this.Response.Status = RpcResponseStatus.Fail;
                //        this.Response.InformationalMessage = piece2;
                //        break;
                //    default:
                //        this.Response.Status = RpcResponseStatus.Success;
                //        break;
                //}
            }

        }
    }
}
