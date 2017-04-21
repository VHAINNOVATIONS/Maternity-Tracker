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
    public class DsioSelectListCommand: DsioCommand
    {
        /// <summary>
        /// Creates the command
        /// </summary>
        /// <param name="newBroker">An object which allows communication with VistA and implements IRpcBroker</param>
        public DsioSelectListCommand(IRpcBroker newBroker): base(newBroker) {}

        public List<string> SelectList { get; set; }

        public enum SelectListOperation { Get, Add, Delete }

        public override string RpcName
        {
            get { return "DSIO SELECT LIST"; }
        }

        private enum CommandOperation { GetList, AddToList }

        private CommandOperation Operation { get; set; }

        protected override void ProcessResponse()
        {
            // *** Set select list values based on response data ***

            if (string.IsNullOrWhiteSpace(this.Response.Data))
            {
                this.Response.Status = RpcResponseStatus.Fail;
                this.Response.InformationalMessage = "Nothing returned";
            }
            else
            {
                if (this.Operation == CommandOperation.GetList)
                {
                    if (this.SelectList == null)
                        this.SelectList = new List<string>();

                    foreach (string item in this.Response.Lines)
                        this.SelectList.Add(item);

                    this.Response.Status = RpcResponseStatus.Success;
                }
                else if (this.Operation == CommandOperation.AddToList)
                {
                    string piece1 = Util.Piece(this.Response.Lines[0], Caret, 1); 
                    string piece2 = Util.Piece(this.Response.Lines[0], Caret, 2);

                    if (piece1 != "-1")
                        this.Response.Status = RpcResponseStatus.Success; 
                    else 
                    {
                        this.Response.Status = RpcResponseStatus.Fail;
                        this.Response.InformationalMessage = piece2;
                    }
                    
                }
            }
        }

        public void AddCommandArguments(string listIdentifier)
        {
            this.CommandArgs = new object[] { listIdentifier };
            this.Operation = CommandOperation.GetList;
        }

        public void AddCommandArguments(string listIdentifier, string value, SelectListOperation op)
        {
            string opChar = (op == SelectListOperation.Add) ? "A" : "D"; 

            string argString = string.Format("{0}{1}{2}{1}{3}", listIdentifier, Caret, value, opChar);
            this.CommandArgs = new object[] { argString };
            this.Operation = CommandOperation.AddToList;
        }
    }
}
