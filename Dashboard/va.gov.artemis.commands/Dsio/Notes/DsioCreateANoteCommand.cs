using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Core;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.Commands.Dsio.Notes
{
    public class DsioCreateANoteCommand: DsioCommand
    {
        /// <summary>
        /// Creates the command
        /// </summary>
        /// <param name="newBroker">An object which allows communication with VistA and implements IRpcBroker</param>
        public DsioCreateANoteCommand(IRpcBroker newBroker): base(newBroker)
        {

        }

        public override string RpcName
        {
            get { return "DSIO CREATE A NOTE"; }
        }

        public string Ien { get; set; }

        public void AddCommandArguments(string dfn, string noteTitle, string noteText, string subject, Dictionary<string, string> noteData, string pregIen)
        {
            string[] noteArray = (string.IsNullOrWhiteSpace(noteText)) ? null : Util.Split(noteText);

            DsioNoteData dsioData = DsioNoteData.FromDictionary(noteData);
            
            this.CommandArgs = new object[] { dfn, noteTitle, noteArray, dsioData.ToParameter(), subject, pregIen };
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

            //    char[] chars = piece1.ToCharArray();

            //    if ((int)chars[0] == 24)
            //    {
            //        this.Response.Status = RpcResponseStatus.Fail;
            //        this.Response.InformationalMessage = "An internal error has occurred";
            //        ErrorLogger.Log(string.Format("M Error Calling RPC '{0}': {1}", this.RpcName, this.Response.Data)); 
            //    }
            //    else if (chars[0].ToString() == "0") 
            //    {
            //        this.Response.Status = RpcResponseStatus.Fail;
            //        this.Response.InformationalMessage = piece2;
            //    }
            //    else 
            //    {
            //        switch (piece1)
            //        {
            //            case "-1":
            //            case "0":
            //                this.Response.Status = RpcResponseStatus.Fail;
            //                this.Response.InformationalMessage = piece2;
            //                break;
            //            default:
            //                this.Ien = piece1;
            //                this.Response.Status = RpcResponseStatus.Success;
            //                break;
            //        }
            //    }
            //}

            if (this.ProcessSaveResponse())
            {
                this.Ien = Util.Piece(this.Response.Lines[0], Caret, 1);
                this.Response.Status = RpcResponseStatus.Success;
            }
        }

    }
}
