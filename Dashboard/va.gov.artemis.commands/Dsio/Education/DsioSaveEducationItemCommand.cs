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
    public class DsioSaveEducationItemCommand: DsioCommand
    {
        public string Ien { get; set; }

        public DsioSaveEducationItemCommand(IRpcBroker newBroker) : base(newBroker)
        {

        }

        public void AddCommandArguments(DsioEducationItem item)
        {
            this.CommandArgs = new object[]
            {
                item.Ien, item.Description , item.Category, item.ItemType, item.Url, item.Code, item.CodeSystem 
            };
        }

        public override string RpcName
        {
            get { return "DSIO SAVE EDUCATION ITEM"; }
        }

        protected override void ProcessResponse()
        {
            if (this.ProcessSaveResponse())
            {
                string[] lines = this.Response.Lines;

                this.Ien = Util.Piece(lines[0], Caret, 1);

                this.Response.Status = RpcResponseStatus.Success; 
            }
        }
    }
}
