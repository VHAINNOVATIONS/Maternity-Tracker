using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Vista.Commands;

namespace VA.Gov.Artemis.Commands.Orwu
{
    public class OrwuHasKeyCommand : CommandBase
    {
        /// <summary>
        /// Creates the command
        /// </summary>
        /// <param name="newBroker">An object which allows communication with VistA</param>
        /// <param name="securityKey"></param>
        public OrwuHasKeyCommand(IRpcBroker newBroker)
            : base(newBroker)
        {
            this.Context = "DSIO GUI CONTEXT";
        }

        public void AddCommandArguments(string securityKey)
        {
            this.CommandArgs = new object[] { securityKey };
        }

        public override string RpcName { get { { return "ORWU HASKEY"; } } }

        public override string Version { get { return "0"; } }

        public bool HasKeyResult { get; set; }

        protected override void ProcessResponse()
        {
            // *** Result will be "1" for true and "0" for false ***

            switch (this.Response.Data)
            {
                case "0":
                case "1":
                    this.Response.Status = RpcResponseStatus.Success;
                    break;
                default:
                    this.Response.Status = RpcResponseStatus.Fail;
                    break;
            }

            this.HasKeyResult = (this.Response.Data == "1");
               
        }
    }
}
