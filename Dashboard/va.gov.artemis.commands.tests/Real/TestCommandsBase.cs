using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Configuration;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Vista.Commands;
using System.Collections.Generic;
using VA.Gov.Artemis.Commands.Xus;

namespace VA.Gov.Artemis.Commands.Tests.Real
{
    [TestClass]
    public abstract class TestCommandsBase
    {
        protected RpcBroker GetConnectedBroker()
        {
            RpcBroker returnVal = new RpcBroker(ValidServerName, ValidPort);

            if (!returnVal.Connect())
                Assert.Fail("Could not connect broker");

            return returnVal;
        }

        // *** Executes a queue of commands and returns last response ***
        protected RpcResponse ExecuteCommandQueue(Queue<CommandBase> commands)
        {
            RpcResponse returnVal = null;

            bool ok = true;
            CommandBase command = null;

            while ((commands.Count > 0) && ok)
            {
                command = commands.Dequeue();

                returnVal = command.Execute();

                ok = returnVal.Status == RpcResponseStatus.Success;
            }

            if (commands.Count > 0)
                Assert.Fail(string.Format("Did not complete command queue: Command {0} failed", command.GetType().ToString()));

            return returnVal;
        }

        protected string ValidServerName
        {
            get
            {
                return ConfigurationManager.AppSettings["validServer"];
            }
        }

        protected int ValidPort
        {
            get
            {
                int returnVal = 0;

                int.TryParse(ConfigurationManager.AppSettings["validListenerPort"], out returnVal);

                return returnVal;
            }
        }

        protected string[] ValidAccessCodes
        {
            get
            {
                string concatenated = ConfigurationManager.AppSettings["validAccessCodes"];

                return concatenated.Split(',');
            }
        }

        protected string[] ValidVerifyCodes
        {
            get
            {
                string concatenated = ConfigurationManager.AppSettings["validVerifyCodes"];

                return concatenated.Split(',');
            }
            set
            {
                string concatenated = string.Join(",", value);

                Configuration config = ConfigurationManager.OpenExeConfiguration(ConfigurationUserLevel.None);

                config.AppSettings.Settings["validVerifyCodes"].Value = concatenated;

                config.Save();

                //ConfigurationManager.AppSettings["validVerifyCodes"] = concatenated; 

            }
        }

        protected void SignonToBroker(IRpcBroker broker, int avCodeIndex)
        {
            XusSignonSetupCommand signonSetupCommand = new XusSignonSetupCommand(broker);

            RpcResponse response = signonSetupCommand.Execute();

            Assert.AreEqual(RpcResponseStatus.Success, response.Status);

            XusAvCodeCommand avCodeCommand = new XusAvCodeCommand(broker);
            
            avCodeCommand.AddCommandArguments(ValidAccessCodes[avCodeIndex], ValidVerifyCodes[avCodeIndex]);

            response = avCodeCommand.Execute();

            Assert.AreEqual(RpcResponseStatus.Success, response.Status);

        }

    }
}
