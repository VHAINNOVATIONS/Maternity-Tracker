using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Commands.Dsio;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Vista.Commands;

namespace VA.Gov.Artemis.Commands.Xwb
{
    public class XwbImHereCommand: CommandBase
    {
        public XwbImHereCommand(IRpcBroker newBroker) : base(newBroker)
        {
            this.Context = "";
        }
        public override string RpcName
        {
            get { return "XWB IM HERE"; }
        }

        public override string Version
        {
            get { return "0"; }
        }

        protected override void ProcessResponse()
        {
            if (this.Response.Data == "1")
                this.Response.Status = Vista.Broker.RpcResponseStatus.Success; 
        }
    }
}
