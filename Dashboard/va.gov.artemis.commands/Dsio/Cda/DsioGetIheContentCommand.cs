// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Vista.Broker;

namespace VA.Gov.Artemis.Commands.Dsio.Cda
{
    public class DsioGetIheContentCommand: DsioCommand 
    {
        // *** Object gets populated by command result ***
        public DsioCdaDocument Document { get; set; }

        public override string RpcName
        {
            get { return "WEBM GET IHE CONTENT"; }
        }

        public DsioGetIheContentCommand(IRpcBroker newBroker): base(newBroker)
        {
            
        }

        public void AddCommandArguments(string ien)
        {
            this.CommandArgs = new object[] { ien };
        }

        protected override void ProcessResponse()
        {
            if (this.ProcessQueryResponse())
            {
                // *** Create new document ***
                this.Document = new DsioCdaDocument();

                // *** Populate content ***
                this.Document.Content = this.Response.Data;

                // *** Indicate success ***
                this.Response.Status = RpcResponseStatus.Success;
            }
        }
    }
}
