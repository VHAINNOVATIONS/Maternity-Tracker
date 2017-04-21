// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Vista.Broker;

namespace VA.Gov.Artemis.Commands.Dsio.Patient
{
    public class DsioSetPatientInformationCommand: DsioCommand
    {
        public DsioSetPatientInformationCommand(IRpcBroker newBroker): base(newBroker)
        {

        }

        public void AddCommandArguments(string dfn, string key, string value)
        {
            this.CommandArgs = new object[] { dfn, key, value };
        }

        public override string RpcName
        {
            get { return "DSIO SET PATIENT INFORMATION"; }
        }

        protected override void ProcessResponse()
        {
            this.ProcessSaveResponse(); 
        }
    }
}
