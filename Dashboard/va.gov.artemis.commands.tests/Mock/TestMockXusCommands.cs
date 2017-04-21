// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using VA.Gov.Artemis.Vista.Commands.Orwu;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Commands.Xus;
using VA.Gov.Artemis.Vista.Commands;
using System.Collections.Generic;
using System.Configuration;
using VA.Gov.Artemis.UI.Mock;

namespace VA.Gov.Artemis.Commands.tests.mock
{
    [TestClass]
    public class TestMockXusCommands
    {
        [TestMethod]
        public void TestMockSignonSetup_GoodData()
        {
            IRpcBroker broker = MockRpcBrokerFactory.GetXusSignonSetupBroker(true);

            XusSignonSetupCommand testCommand = new XusSignonSetupCommand(broker);

            RpcResponse response = testCommand.Execute();

            // *** Check results ***
            Assert.IsNotNull(response);
            Assert.AreEqual(RpcResponseStatus.Success, response.Status);
            Assert.IsFalse(string.IsNullOrWhiteSpace(testCommand.SignonSetup.DomainName));
            Assert.IsFalse(string.IsNullOrWhiteSpace(testCommand.SignonSetup.Port));
            Assert.IsFalse(string.IsNullOrWhiteSpace(testCommand.SignonSetup.ServerName));
            Assert.IsFalse(string.IsNullOrWhiteSpace(testCommand.SignonSetup.UCI));
            Assert.IsFalse(string.IsNullOrWhiteSpace(testCommand.SignonSetup.Volume));

        }

        [TestMethod]
        public void TestMockSignonSetup_BadData()
        {
            IRpcBroker broker = MockRpcBrokerFactory.GetXusSignonSetupBroker(false);

            XusSignonSetupCommand testCommand = new XusSignonSetupCommand(broker);

            RpcResponse response = testCommand.Execute();

            // *** Check results ***
            Assert.IsNotNull(response);
            Assert.AreEqual(RpcResponseStatus.Fail, response.Status);

        }

        [TestMethod]
        public void TestMockIntroMsg_GoodData()
        {
            IRpcBroker broker = MockRpcBrokerFactory.GetXusIntroMsgBroker(true);

            XusIntroMsgCommand testCommand = new XusIntroMsgCommand(broker);

            RpcResponse response = testCommand.Execute();

            // *** Check results ***
            Assert.IsNotNull(response);
            Assert.AreEqual(RpcResponseStatus.Success, response.Status);
            Assert.IsFalse(string.IsNullOrWhiteSpace(response.Data));
        }

        [TestMethod]
        public void TestMockIntroMsg_BadData()
        {
            IRpcBroker broker = MockRpcBrokerFactory.GetXusIntroMsgBroker(false);

            XusIntroMsgCommand testCommand = new XusIntroMsgCommand(broker);

            RpcResponse response = testCommand.Execute();

            // *** Check results ***
            Assert.IsNotNull(response);
            Assert.AreEqual(RpcResponseStatus.Fail, response.Status);
        }

        [TestMethod]
        public void TestMockAVCode_GoodData()
        {
            TestAvCode(true, RpcResponseStatus.Success);
        }

        [TestMethod]
        public void TestMockAVCode_BadData()
        {
            TestAvCode(false, RpcResponseStatus.Fail);
        }

        private void TestAvCode(bool goodData, RpcResponseStatus expectedStatus)
        {
            IRpcBroker broker = MockRpcBrokerFactory.GetXusAvCodeBroker(goodData);

            XusAvCodeCommand testCommand = new XusAvCodeCommand(broker);

            testCommand.AddCommandArguments("", "");

            RpcResponse response = testCommand.Execute();

            // *** Check results ***
            Assert.IsNotNull(response);
            Assert.AreEqual(expectedStatus, response.Status, response.InformationalMessage);

        }

        [TestMethod]
        public void TestMockChangeVerifyCode_GoodData()
        {
            IRpcBroker broker = MockRpcBrokerFactory.GetXusChangeVerifyCodeBroker(true);

            XusCvcCommand cvcCommand = new XusCvcCommand(broker);

            RpcResponse response = cvcCommand.Execute();

            Assert.IsNotNull(response);
            Assert.AreEqual(RpcResponseStatus.Success, response.Status, response.InformationalMessage);

        }

        [TestMethod]
        public void TestMockChangeVerifyCode_BadData()
        {
            IRpcBroker broker = MockRpcBrokerFactory.GetXusChangeVerifyCodeBroker(false);

            XusCvcCommand cvcCommand = new XusCvcCommand(broker);

            RpcResponse response = cvcCommand.Execute();

            Assert.IsNotNull(response);
            Assert.AreEqual(RpcResponseStatus.Fail, response.Status, response.InformationalMessage);

        }

        [TestMethod]
        public void TestMockDivisionGet_GoodData()
        {
            IRpcBroker mockBroker = MockRpcBrokerFactory.GetXusDivisionGetBroker(true);

            XusDivisionGetCommand divCommand = new XusDivisionGetCommand(mockBroker);

            RpcResponse response = divCommand.Execute();

            Assert.IsNotNull(response);
            Assert.AreEqual(RpcResponseStatus.Success, response.Status);
            Assert.IsNotNull(divCommand.Divisions, "No divisions found");

        }

        [TestMethod]
        public void TestMockDivisionGet_BadData()
        {
            IRpcBroker mockBroker = MockRpcBrokerFactory.GetXusDivisionGetBroker(false);

            XusDivisionGetCommand divCommand = new XusDivisionGetCommand(mockBroker);

            RpcResponse response = divCommand.Execute();

            Assert.IsNotNull(response);
            Assert.AreEqual(RpcResponseStatus.Fail, response.Status);

        }

        [TestMethod]
        public void TestMockDivisionSet_GoodData()
        {
            TestDivisionSet(true, RpcResponseStatus.Success);
        }

        [TestMethod]
        public void TestMockDivisionSet_BadData()
        {
            TestDivisionSet(false, RpcResponseStatus.Fail);
        }

        private void TestDivisionSet(bool goodData, RpcResponseStatus expectedResponse)
        {
            IRpcBroker broker = MockRpcBrokerFactory.GetXusDivisionSetBroker(goodData);

            XusDivisionSetCommand divCommand = new XusDivisionSetCommand(broker, "");

            RpcResponse response = divCommand.Execute();

            // *** Check results ***
            Assert.IsNotNull(response);
            Assert.AreEqual(expectedResponse, response.Status);
        }

        [TestMethod]
        public void TestMockSuccessfulGetUserInfo_GoodData()
        {
            IRpcBroker broker = MockRpcBrokerFactory.GetXusGetUserInfoBroker(true);

            XusGetUserInfoCommand userInfoCommand = new XusGetUserInfoCommand(broker);

            RpcResponse response = userInfoCommand.Execute();

            // *** Check results ***
            Assert.IsNotNull(response);
            Assert.AreEqual(RpcResponseStatus.Success, response.Status);

            Assert.IsFalse(string.IsNullOrWhiteSpace(userInfoCommand.UserInfo.DUZ), "DUZ is empty");
            Assert.IsFalse(string.IsNullOrWhiteSpace(userInfoCommand.UserInfo.Division.Name), "Division is empty");
            Assert.IsFalse(string.IsNullOrWhiteSpace(userInfoCommand.UserInfo.DTime), "DTime is empty");
            Assert.IsFalse(string.IsNullOrWhiteSpace(userInfoCommand.UserInfo.Name), "Name is empty");
            Assert.IsFalse(string.IsNullOrWhiteSpace(userInfoCommand.UserInfo.ServiceSection), "ServiceSection is empty");
            Assert.IsFalse(string.IsNullOrWhiteSpace(userInfoCommand.UserInfo.StandardName), "StandardName is empty");
            Assert.IsFalse(string.IsNullOrWhiteSpace(userInfoCommand.UserInfo.Title), "Title is empty");

            // TODO: Do we care about this?
            //Assert.IsFalse(string.IsNullOrWhiteSpace(userInfoCommand.UserInfo.Language), "Language is empty");
            //Assert.IsFalse(string.IsNullOrWhiteSpace(userInfoCommand.UserInfo.UserClass), "UserClass is empty");
            //Assert.IsFalse(string.IsNullOrWhiteSpace(userInfoCommand.UserInfo.Vpid), "Vpid is empty");
            //Assert.IsFalse(string.IsNullOrWhiteSpace(userInfoCommand.UserInfo.DefaultLocation), "DefaultLocation is empty");
        }


        [TestMethod]
        public void TestMockSuccessfulGetUserInfo_BadData()
        {
            IRpcBroker broker = MockRpcBrokerFactory.GetXusGetUserInfoBroker(false);

            XusGetUserInfoCommand userInfoCommand = new XusGetUserInfoCommand(broker);

            RpcResponse response = userInfoCommand.Execute();

            // *** Check results ***
            Assert.IsNotNull(response);
            Assert.AreEqual(RpcResponseStatus.Fail, response.Status);

        }

    }
}