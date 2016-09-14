using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.Commands.Dsio.Notes
{
    public class DsioMakeAddendumCommand: DsioCommand
    {
        /// <summary>
        /// Creates the command
        /// </summary>
        /// <param name="newBroker">An object which allows communication with VistA and implements IRpcBroker</param>
        public DsioMakeAddendumCommand(IRpcBroker broker): base(broker)
        {

        }

        public override string RpcName
        {
            get { return "DSIO MAKE ADDENDUM"; }
        }

        public void AddCommandArguments(string ien, string noteText, string subject, Dictionary<string, string> noteData)
        {
            string[] noteArray = (string.IsNullOrWhiteSpace(noteText)) ? null : Util.Split(noteText);

            DsioNoteData dsioData = DsioNoteData.FromDictionary(noteData); 

            this.CommandArgs = new object[] { ien, noteArray, dsioData.ToParameter(), subject };
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
                    case "0":
                        this.Response.Status = RpcResponseStatus.Fail;
                        this.Response.InformationalMessage = piece2;
                        break;
                    default:
                        this.Response.Status = RpcResponseStatus.Success;
                        break;
                }
            }

        }

    }
}
