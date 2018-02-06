// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.Commands.Dsio.Checklist
{
    public class DsioSaveMccChecklistCommand: DsioCommand
    {
        public string Ien { get; set; }

        public DsioSaveMccChecklistCommand(IRpcBroker newBroker): base(newBroker)
        {

        }

        public void AddCommandArguments(DsioChecklistItem item)
        {
            this.CommandArgs = new object[] 
            {
                item.Ien, 
                item.Description, 
                ((int)item.ItemType).ToString(), 
                ((int)item.DueCalculationType).ToString(), 
                item.DueCalculationValue, 
                item.Category, 
                item.Link , 
                item.EducationIen
            };
        }

        public override string RpcName
        {
            get { return "MTD SAVE MCC CHECKLIST"; }
        }

        protected override void ProcessResponse()
        {
            if (this.ProcessSaveResponse())
            {
                this.Ien = Util.Piece(this.Response.Lines[0], Caret, 1); 
                this.Response.Status = RpcResponseStatus.Success;
            }
        }
    }
}
