// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Commands.Dsio.Pregnancy;
using VA.Gov.Artemis.Commands.Dsio.Orders;

namespace VA.Gov.Artemis.Commands.Tests.Real
{
    [TestClass]
    public class TestDsioOrderCommands: TestCommandsBase
    {
        [TestMethod]
        public void TestGetOrderList()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioGetOrderListCommand command = new DsioGetOrderListCommand(broker);

                command.AddCommandArguments(TestConfiguration.PatientWithOrdersDfn, 1, 10);
                //command.AddCommandArguments("715"); 

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);

            }

        }
    }
}
