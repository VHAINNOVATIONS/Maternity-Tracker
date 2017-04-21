// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Commands.Dsio.Reminders;

namespace VA.Gov.Artemis.Commands.Tests.Real
{
    [TestClass]
    public class TestDsioReminders: TestCommandsBase
    {
        [TestMethod]
        public void TestGetReminderList()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioGetReminderListCommand command = new DsioGetReminderListCommand(broker);

                //command.AddCommandArguments("715", 1, 10);
                command.AddCommandArguments(TestConfiguration.DefaultPatientDfn, 1, 10);

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status); 
            }
        }
        [TestMethod]
        public void TestGetReminderListNothingFound()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioGetReminderListCommand command = new DsioGetReminderListCommand(broker);

                command.AddCommandArguments("12345", 1, 10);

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);
            }
        }
    }
}
