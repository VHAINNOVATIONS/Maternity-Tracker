// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Collections.Generic;
using VA.Gov.Artemis.Vista.Commands;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Commands.Xus;
using VA.Gov.Artemis.Vista.Commands.Orwu;
using VA.Gov.Artemis.UI.Mock;
using VA.Gov.Artemis.Commands.Orwu;

namespace VA.Gov.Artemis.Commands.tests.mock
{
    [TestClass]
    public class TestMockOrwuCommands
    {
        [TestMethod]
        public void TestMockUserInfoCommand_GoodData()
        {
            RpcResponse response = TestMockUserInfoCommand(true);

            Assert.AreEqual(RpcResponseStatus.Success, response.Status);
        }

        [TestMethod]
        public void TestMockUserInfoCommand_BadData()
        {
            RpcResponse response = TestMockUserInfoCommand(false);

            Assert.AreEqual(RpcResponseStatus.Fail, response.Status);
        }

        private RpcResponse TestMockUserInfoCommand(bool goodData) 
        {
            IRpcBroker broker = MockRpcBrokerFactory.GetOrwuUserInfoBroker(goodData); 

            OrwuUserInfoCommand testCommand = new OrwuUserInfoCommand(broker); 

            RpcResponse response = testCommand.Execute();

            // *** Check results ***
            Assert.IsNotNull(response);

            return response; 
        }

        [TestMethod]
        public void TestMockHasKeyCommand_True()
        {
            IRpcBroker broker = MockRpcBrokerFactory.GetOrwuHasKeyBroker(true);

            bool result = TestHasSecurityKeyCommand(broker, "MTD ADMIN");

            Assert.IsTrue(result);
        }

        [TestMethod]
        public void TestMockHasKeyCommand_False()
        {
            IRpcBroker broker = MockRpcBrokerFactory.GetOrwuHasKeyBroker(false);

            bool result = TestHasSecurityKeyCommand(broker, "MTD ADMIN");

            Assert.IsFalse(result);
        }

        private bool TestHasSecurityKeyCommand(IRpcBroker broker, string key)
        {
            Assert.IsNotNull(broker);

            OrwuHasKeyCommand command = new OrwuHasKeyCommand(broker);

            command.AddCommandArguments("MTD ADMIN"); 

            RpcResponse response = command.Execute();

            Assert.AreEqual(RpcResponseStatus.Success, response.Status);

            return command.HasKeyResult; 
        }  
    }
}
