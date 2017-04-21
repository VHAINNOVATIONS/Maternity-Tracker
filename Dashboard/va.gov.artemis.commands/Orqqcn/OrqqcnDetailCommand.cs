// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Commands.Dsio;
using VA.Gov.Artemis.Vista.Broker;

namespace VA.Gov.Artemis.Commands.Orqqcn
{
    public class OrqqcnDetailCommand: DsioCommand
    {
        public string ConsultDetail {get; set; }

        public OrqqcnDetailCommand(IRpcBroker newBroker): base(newBroker)
        {

        }

        public void AddCommandArguments(string ien)
        {
            this.CommandArgs = new object[] { ien };
        }

        public override string RpcName
        {
            get { return "ORQQCN DETAIL"; }
        }

        protected override void ProcessResponse()
        {
            if (this.ProcessQueryResponse())
            {
                this.ConsultDetail = this.Response.Data;

                this.Response.Status = Vista.Broker.RpcResponseStatus.Success;
            }
        }
    }
}
