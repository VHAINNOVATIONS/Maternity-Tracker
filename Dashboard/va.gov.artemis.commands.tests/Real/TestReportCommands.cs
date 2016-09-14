using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Commands.Orwrp;
using VA.Gov.Artemis.Vista.Broker;

namespace VA.Gov.Artemis.Commands.Tests.Real
{
    [TestClass]
    public class TestReportCommands: TestCommandsBase
    {
        [TestMethod]
        public void TestGetImagingReports()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                OrwrpReportTextCommand command = new OrwrpReportTextCommand(broker);

                command.AddCommandArguments("711");

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status); 

                broker.Disconnect(); 
            }
        }
    }
}
