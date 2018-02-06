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
    public class DsioSavePatientEducationCommand: DsioCommand
    {
        public string Ien {get; set; }

        public DsioSavePatientEducationCommand(IRpcBroker newBroker) : base(newBroker)
        {

        }

        public override string RpcName
        {
            get { return "MTD SAVE PATIENT EDUCATION"; }
        }

        public void AddCommandArguments(DsioPatientEducationItem item)
        {
            this.CommandArgs = new object[] 
            { 
                item.PatientDfn, 
                item.Ien, 
                item.CompletedOn, 
                item.EducationItemIen, 
                item.Category, 
                item.Description, 
                item.ItemType, 
                item.Url, 
                item.Code, 
                item.CodeSystem 
            };
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
