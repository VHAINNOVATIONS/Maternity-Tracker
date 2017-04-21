// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Vista.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Vista.Commands;

namespace VA.Gov.Artemis.Commands.Xus
{
    public class XusIntroMsgCommand: CommandBase 
    {
        /// <summary>
        /// Creates the command
        /// </summary>
        /// <param name="newBroker">An object which allows communication with VistA and implements IRpcBroker</param>
        public XusIntroMsgCommand(IRpcBroker newBroker):
            base(newBroker) {}

        public override string RpcName {get {return "XUS INTRO MSG"; }}

        public override string Version {get {return "0";}}

        protected override void ProcessResponse()
        {
            if (string.IsNullOrWhiteSpace(this.Response.Data))
                this.Response.Status = RpcResponseStatus.Fail; 
            else
                this.Response.Status = RpcResponseStatus.Success; 
        }
    }
}
