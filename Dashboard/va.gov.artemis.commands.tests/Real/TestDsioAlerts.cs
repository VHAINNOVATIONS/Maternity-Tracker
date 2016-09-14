using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Commands.Dsio.Alerts;

namespace VA.Gov.Artemis.Commands.Tests.Real
{
    [TestClass]
    public class TestDsioAlerts: TestCommandsBase
    {
        [TestMethod]
        public void TestGetPagedAlerts()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioGetAlertsCommand command = new DsioGetAlertsCommand(broker);

                command.AddCommandArguments( 11, 10);

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);
            }
        }
    
        [TestMethod]
        public void TestGetAllAlerts()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioGetAlertsCommand command = new DsioGetAlertsCommand(broker);

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);
            }
        }
    }
}
