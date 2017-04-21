// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Vista.Broker;

namespace VA.Gov.Artemis.Commands.Dsio.Pregnancy
{
    public class DsioDeletePregnancyCommand: DsioCommand
    {
        public DsioDeletePregnancyCommand(IRpcBroker newBroker): base(newBroker)
        {

        }

        public void AddCommandArguments(string pregIen)
        {
            this.CommandArgs = new object[] { string.Format("{0}@", pregIen) };
        }

        public override string RpcName { get { return "DSIO SAVE PREG DETAILS"; } }

        protected override void ProcessResponse()
        {
            this.ProcessSaveResponse(); 
        }
    }
}
