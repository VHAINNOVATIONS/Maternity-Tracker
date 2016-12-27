using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Collections.Generic;
using VA.Gov.Artemis.Vista.Commands;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Commands.Xus;
using VA.Gov.Artemis.Vista.Commands.Orwu;
using VA.Gov.Artemis.Commands.Orwu;
using System.Diagnostics;

namespace VA.Gov.Artemis.Commands.Tests.Real
{
    [TestClass]
    public class TestOrwuCommands: TestCommandsBase
    {
        [TestMethod]
        public void TestUserInfoCommand()
        {
            Queue<CommandBase> commandQueue = new Queue<CommandBase>();

            using (RpcBroker broker = GetConnectedBroker())
            {
                commandQueue.Enqueue(new XusSignonSetupCommand(broker));

                XusAvCodeCommand avCommand = new XusAvCodeCommand(broker);

                avCommand.AddCommandArguments(TestConfiguration.ValidAccessCodes[2], TestConfiguration.ValidVerifyCodes[2]);

                commandQueue.Enqueue(avCommand);

                OrwuUserInfoCommand testCommand = new OrwuUserInfoCommand(broker); 

                commandQueue.Enqueue(testCommand);

                RpcResponse response = ExecuteCommandQueue(commandQueue);

                // *** Check results ***
                Assert.AreEqual(RpcResponseStatus.Success, response.Status);

                Assert.IsTrue((testCommand.UserInfo.Timeout > 0)); 

                broker.Disconnect();
            }
        }

        [TestMethod]
        public void TestHasKeyCommand()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                TestHasSecurityKeyCommand(broker, "DSIO ADMIN");

                broker.Disconnect();
            }
        }

        private void TestHasSecurityKeyCommand(IRpcBroker broker, string key)
        {
            Assert.IsNotNull(broker);

            this.SignonToBroker(broker, 2);

            OrwuHasKeyCommand command = new OrwuHasKeyCommand(broker);

            command.AddCommandArguments("DSIO ADMIN"); 

            RpcResponse response = command.Execute();

            Assert.AreEqual(RpcResponseStatus.Success, response.Status);
        }        
    }
}
