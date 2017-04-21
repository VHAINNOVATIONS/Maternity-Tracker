// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.Commands.Dsio.Cda
{
    public class DsioSaveIheDocCommand: DsioCommand
    {
        /// <summary>
        /// Creates the command
        /// </summary>
        /// <param name="newBroker">An object which allows communication with VistA and implements IRpcBroker</param>
        public DsioSaveIheDocCommand(IRpcBroker newBroker): base(newBroker)
        {

        }

        public string Ien { get; set; }

        public override string RpcName
        {
            get { return "DSIO SAVE IHE DOC"; }
        }


        public void AddCommandArguments(string ien, string id, string dfn, string direction, 
            string createDateTime, string importExportDateTime, 
            string docType, string docTitle, string sendingEntity, 
            string intendedRecipient, string content )
        {
            string[] contentArray = (string.IsNullOrWhiteSpace(content)) ? null : Util.Split(content);

            //IEN, DFN, GUID, Direction, DT of creation, DT of Import/Export, Document Type, Document Title, Sending Facility/Provider, Intended Recipient, Document

            string dates = string.Format("{0}^{1}", createDateTime, importExportDateTime); 

            this.CommandArgs = new object[] { ien, dfn, dates, docType, direction, id, docTitle, sendingEntity, intendedRecipient, contentArray };
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

                int.TryParse(piece1, out returnCode);

                if (returnCode < 1)
                {
                    this.Response.Status = RpcResponseStatus.Fail;
                    this.Response.InformationalMessage = piece2;
                }
                else
                {
                    this.Ien = piece1; 
                    this.Response.Status = RpcResponseStatus.Success;
                }
    
            }
        }

    }
}
