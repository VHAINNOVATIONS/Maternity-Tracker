// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Vista.Commands;

// TODO: Rename project, remove vista folder...

namespace VA.Gov.Artemis.Vista.Tests
{
    class MockCommand: CommandBase
    {
        public MockCommand (IRpcBroker newBroker): base(newBroker) {}

        public override string RpcName
        {
            get { return "Random RPC Name"; }
        }

        public override string Version
        {
            get { return "abcde"; }
        }

        protected override void ProcessResponse()
        {
            // Don't do anythning...?
        }
    }
}
