// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.Commands.Dsio.Education
{
    public class DsioDeleteEducationItemCommand: DsioCommand
    {
        public DsioDeleteEducationItemCommand(IRpcBroker newBroker) : base(newBroker)
        {

        }
        public override string RpcName
        {
            get { return "DSIO SAVE EDUCATION ITEM"; }
        }

        public void AddCommandArguments(string ien)
        {
            this.CommandArgs = new object[]
            {
                ien, "", "", "", "", "", "", "1"
            };
        }

        protected override void ProcessResponse()
        {
            if (this.ProcessSaveResponse())
                this.Response.Status = RpcResponseStatus.Success;
            else
            {
                string piece1 = Util.Piece(this.Response.Data, Caret, 1);
                string piece2 = Util.Piece(this.Response.Data, Caret, 2);

                if (piece1 == "-1")
                    switch (piece2)
                    {
                        case "CANNOT DELETE THIS ITEM SINCE IT IS LINKED TO THE DSIO MCC PATIENT CHECKLIST":
                        case "CANNOT DELETE THIS ITEM SINCE IT IS LINKED TO THE DSIO MCC CHECKLIST":
                            this.Response.InformationalMessage = "This item cannot be deleted because it is in use";
                            break;
                    }
            }
        }
    }
}
