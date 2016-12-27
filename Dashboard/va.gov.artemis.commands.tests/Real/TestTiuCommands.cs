using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Commands.Tiu;

namespace VA.Gov.Artemis.Commands.Tests.Real
{
    [TestClass]
    public class TestTiuCommands: TestCommandsBase
    {
        [TestMethod]
        public void TestGetProgNotes()
        {
            using (RpcBroker broker = GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                TiuDocumentsByContextCommand command = new TiuDocumentsByContextCommand(broker);

                command.AddCommandArgument(TestConfiguration.DefaultPatientDfn);

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status); 

                broker.Disconnect();
            }
        }

        //[TestMethod]
        //public void TestGetProgNote()
        //{
        //    using (RpcBroker broker = GetConnectedBroker())
        //    {
        //        this.SignonToBroker(broker, 2);

        //        TiuGetRecordTextCommand command = new TiuGetRecordTextCommand(broker);

        //        //command.AddParameter("461");
        //        command.AddCommandArgument("4848");

        //        RpcResponse response = command.Execute();

        //        Assert.AreEqual(RpcResponseStatus.Success, response.Status);

        //        broker.Disconnect();
        //    }
        //}
    }
}
