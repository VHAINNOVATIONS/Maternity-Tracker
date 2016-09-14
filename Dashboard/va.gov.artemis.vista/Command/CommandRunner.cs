using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Vista.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.Vista.Commands
{
    // TODO: Use this?

    public class CommandRunner
    {
        private List<CommandBase> executedCommands { get; set; }

        public CommandRunner()
        {
            this.executedCommands = new List<CommandBase>();
        }

        public RpcResponse ExecuteNow(CommandBase command)
        {
            RpcResponse returnVal = null;

            returnVal = command.Execute();

            this.executedCommands.Add(command);

            return returnVal;
        }
    }
}
