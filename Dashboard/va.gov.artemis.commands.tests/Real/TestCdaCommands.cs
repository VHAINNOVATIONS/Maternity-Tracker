using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Commands.Dsio.Cda;
using VA.Gov.Artemis.Vista.Broker;

namespace VA.Gov.Artemis.Commands.Tests.Real
{
    [TestClass]
    public class TestCdaCommands: TestCommandsBase
    {
        [TestMethod]
        public void TestGetProviders()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioGetProviderCommand command = new DsioGetProviderCommand(broker);

                string[] provIds = new string[] { "10958","10000000244" };

                command.AddCommandArguments(provIds);

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);

            }

        }

    }
}
