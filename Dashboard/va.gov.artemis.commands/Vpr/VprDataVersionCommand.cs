// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

//using VA.Gov.Artemis.Vista.Broker;
//using VA.Gov.Artemis.Vista.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Vista.Commands;

namespace VA.Gov.Artemis.Commands.Vpr
{
    public class VprDataVersionCommand: CommandBase 
    {
        public VprDataVersionCommand(IRpcBroker newBroker):
            base(newBroker){}

        public override string RpcName {get { return "VPR DATA VERSION"; }}

        public override string Version {get { return "0"; } }

        protected override void ProcessResponse()
        {
            // *** No Processing ***
        }
    }
}
