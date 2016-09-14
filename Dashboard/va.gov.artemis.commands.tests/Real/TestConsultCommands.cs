using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Commands.Orqqcn;
using VA.Gov.Artemis.Vista.Broker;

namespace VA.Gov.Artemis.Commands.Tests.Real
{
    [TestClass]
    public class TestConsultCommands: TestCommandsBase
    {
        [TestMethod]
        public void TestConsultList()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                // TODO: Get working with non-programmer
                this.SignonToBroker(broker, 2);

                OrqqcnListCommand command = new OrqqcnListCommand(broker);

                command.AddCommandArguments("715");

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status); 

                broker.Disconnect(); 
            }
        }

        [TestMethod]
        public void TestConsultDetail()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                // TODO: Get working with non-programmer
                this.SignonToBroker(broker, 2);

                OrqqcnDetailCommand command = new OrqqcnDetailCommand(broker);

                command.AddCommandArguments("554");

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);

                broker.Disconnect();
            }
        }
    }
}
