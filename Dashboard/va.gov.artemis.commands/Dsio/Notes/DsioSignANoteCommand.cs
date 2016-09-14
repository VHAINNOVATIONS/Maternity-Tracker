using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Vista.Common;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.Commands.Dsio.Notes
{
    public class DsioSignANoteCommand: DsioCommand
    {
        /// <summary>
        /// Creates the command
        /// </summary>
        /// <param name="newBroker">An object which allows communication with VistA and implements IRpcBroker</param>
        public DsioSignANoteCommand(IRpcBroker newBroker): base(newBroker)
        {

        }

        public void AddCommandArguments(string ien, string sig)
        {
            EncryptedString esig = VistAHash.Encrypt(sig);

            this.CommandArgs = new object[] { ien, esig };

            //this.CommandArgs = new object[] { ien, sig }; 

        }

        public override string RpcName
        {
            get { return "DSIO SIGN A NOTE"; }
        }

        protected override void ProcessResponse()
        {
            //if (string.IsNullOrWhiteSpace(this.Response.Data))
            //{
            //    this.Response.Status = RpcResponseStatus.Fail;
            //    this.Response.InformationalMessage = "No return value";
            //}
            //else
            //{
            //    string piece1 = Util.Piece(this.Response.Lines[0], Caret, 1);
            //    string piece2 = Util.Piece(this.Response.Lines[0], Caret, 2);

            //    switch (piece1)
            //    {
            //        case "89250005":
            //        case "0":
            //            this.Response.Status = RpcResponseStatus.Fail;
            //            this.Response.InformationalMessage = piece2;
            //            break;
            //        default:
            //            this.Response.Status = RpcResponseStatus.Success;
            //            break;
            //    }
            //}

            if (this.ProcessSaveResponse())
            {
                string piece1 = Util.Piece(this.Response.Lines[0], Caret, 1);
                string piece2 = Util.Piece(this.Response.Lines[0], Caret, 2);

                if (piece1 == "89250005")
                {
                    this.Response.Status = RpcResponseStatus.Fail;
                    this.Response.InformationalMessage = piece2;
                }
            }
        }

        // *** Don't log arguments/parameters ***
        protected override bool Sensitive { get { return true; } }
    }
}
