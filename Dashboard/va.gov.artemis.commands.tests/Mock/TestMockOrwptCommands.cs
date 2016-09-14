using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Collections.Generic;
using VA.Gov.Artemis.Vista.Commands;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Commands.Xus;
using VA.Gov.Artemis.UI.Mock;

namespace VA.Gov.Artemis.Commands.tests.mock
{
    [TestClass]
    public class TestOrwptCommands
    {
        //[TestMethod]
        //public void TestListAll()
        //{
        //    MockRpcBroker broker = MockRpcBrokerFactory.GetOrwptListAll();

        //    OrwptListAllCommand listCommand = new OrwptListAllCommand(broker);

        //    RpcResponse response = listCommand.Execute(); 

        //    Assert.IsNotNull(response);
        //    Assert.AreEqual(RpcResponseStatus.Success, response.Status);
        //    Assert.IsNotNull(listCommand.PatientList);
        //    Assert.IsTrue(listCommand.PatientList.Count > 0);                 

        //}
    }
}
