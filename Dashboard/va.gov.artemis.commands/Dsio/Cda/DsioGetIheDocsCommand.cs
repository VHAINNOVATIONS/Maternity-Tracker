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
    public class DsioGetIheDocsCommand: DsioPagableCommand
    {
        // *** Object gets populated by command result ***
        public List<DsioCdaDocument> DocumentList { get; set; }

        public DsioGetIheDocsCommand(IRpcBroker newBroker): base(newBroker)
        {

        }

        public void AddCommandArguments(string patientDfn, string id, int page, int itemsPerPage)
        {
            this.CommandArgs = new object[] { 
                id, 
                patientDfn, 
                string.Format("{0},{1}", page, itemsPerPage)
            };
        }

        public override string RpcName
        {
            get { return "DSIO GET IHE DOCS"; }
        }

        protected override void ProcessLine(string line)
        {
            if (this.DocumentList == null)
                this.DocumentList = new List<DsioCdaDocument>();

            DsioCdaDocument tempDoc = new DsioCdaDocument();

            //IEN^DATE OF ENTRY^PATIENT^DATE OF CREATION^DATE OF IMPORT/EXPORT^DIRECTION^GUID/ID^DOCUMENT TITLE^SENDING FACILITY/PROVIDER^INTENDED RECIPIENT

            tempDoc.Ien = Util.Piece(line, Caret, 1);
            tempDoc.PatientDfn = Util.Piece(line, Caret, 3); 
            tempDoc.CreatedOn = Util.Piece(line, Caret, 4);
            tempDoc.ImportExportDate = Util.Piece(line, Caret, 5);
            tempDoc.DocumentType = Util.Piece(line, Caret, 6);
            tempDoc.Direction = Util.Piece(line, Caret, 7);
            tempDoc.Id = Util.Piece(line, Caret, 8);
            tempDoc.Title = Util.Piece(line, Caret, 9);
            tempDoc.Sender = Util.Piece(line, Caret, 10);
            tempDoc.IntendedRecipient = Util.Piece(line, Caret, 11);

            this.DocumentList.Add(tempDoc);
        }
    }
}
