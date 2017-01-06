using VA.Gov.Artemis.Vista.Broker;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Vista.Commands;

namespace VA.Gov.Artemis.Commands.Xus
{
    public class XusDivisionSetCommand: CommandBase
    {
        public override string RpcName{get { return "XUS DIVISION SET"; }}

        public override string Version {get { return "0"; }}

        /// <summary>
        /// Creates the command
        /// </summary>
        /// <param name="newBroker">An object which allows communication with VistA and implements IRpcBroker</param>
        public XusDivisionSetCommand(IRpcBroker newBroker, string stationNumber): base(newBroker)
        {
            this.CommandArgs = new object[] { stationNumber };
        }

        protected override void ProcessResponse()
        {
            if (this.Response.Data == "1")
                this.Response.Status = RpcResponseStatus.Success; 
            else
            {
                this.Response.Status = RpcResponseStatus.Fail;
                this.Response.InformationalMessage = "Could not set the division"; 
            }
        }
    }
}
