using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Vista.Commands;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.Commands.Tiu
{
    public class TiuDocumentsByContextCommand: CommandBase 
    {
        /// <summary>
        /// Creates the command
        /// </summary>
        /// <param name="newBroker">An object which allows communication with VistA and implements IRpcBroker</param>
        public TiuDocumentsByContextCommand(IRpcBroker newBroker): base(newBroker)
        {
            this.Context = "DSIO GUI CONTEXT";
        }
        public override string RpcName
        {
            get { return "TIU DOCUMENTS BY CONTEXT"; }
        }

        public override string Version
        {
            get { return "0"; }
        }

        public List<TiuDocument> Documents { get; set; }

        public void AddCommandArgument(string dfn)
        {
            // Parameter meanings...
            // "3" = Progress Notes
            // "1" = All Signed
            // dfn
            // "-1" = From Date
            // "-1" = To Date 
            // "0" = By Author
            // "122" = Max docs to return
            // "D" = Descending date order 
            // "1" = Show addenda

            this.CommandArgs = new object[] { "3", "1", dfn,"-1", "-1", "0", "122", "D", "1"};
        }

        protected override void ProcessResponse()
        {
            this.Documents = new List<TiuDocument>(); 

            // *** Make sure we have something to work with ***
            if (string.IsNullOrWhiteSpace(this.Response.Data))
            {
                // *** Set response info ***
                this.Response.Status = RpcResponseStatus.Fail;
                this.Response.InformationalMessage = "No data returned";
            }
            else
            {
                // *** Check first piece for success/failure ***
                string first = Util.Piece(this.Response.Lines[0], Caret, 1);

                if (first == "-1")
                {
                    // *** -1 is fail ***
                    this.Response.Status = RpcResponseStatus.Fail;
                    this.Response.InformationalMessage = Util.Piece(this.Response.Lines[0], Caret, 2);
                }
                else
                {
                    string[] lines = this.Response.Lines;

                    foreach (string line in lines)
                    {
                        TiuDocument doc = new TiuDocument();
                        doc.Ien = Util.Piece(line, Caret, 1);
                        doc.Title = Util.Piece(line, Caret, 2);
                        doc.DocumentDateTime = Util.Piece(line, Caret, 3);
                        doc.DisplayName = Util.Piece(line, Caret, 4);
                        doc.Author = Util.Piece(line, Caret, 5);
                        doc.Location = Util.Piece(line, Caret, 6);
                        doc.SignatureStatus = Util.Piece(line, Caret, 7);
                        doc.VisitDateTime = Util.Piece(line, Caret, 8);
                        doc.DischargeDateTime = Util.Piece(line, Caret, 9);
                        doc.RequestPointer = Util.Piece(line, Caret, 10);
                        doc.AssociatedImages = Util.Piece(line, Caret, 11);
                        doc.Subject = Util.Piece(line, Caret, 12);
                        doc.HasChildren = Util.Piece(line, Caret, 13);
                        doc.ParentIen = Util.Piece(line, Caret, 14);

                        this.Documents.Add(doc); 
                    }
                }

                this.Response.Status = RpcResponseStatus.Success;
            }
        }
    }
}
