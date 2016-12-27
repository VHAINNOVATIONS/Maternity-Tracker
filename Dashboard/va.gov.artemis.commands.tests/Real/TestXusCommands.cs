using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using VA.Gov.Artemis.Vista.Commands.Orwu;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Commands.Xus;
using VA.Gov.Artemis.Vista.Commands;
using System.Collections.Generic;
using System.Configuration;
using VA.Gov.Artemis.UI.Mock;

namespace VA.Gov.Artemis.Commands.Tests.Real
{
    [TestClass]
    public class TestXusCommands: TestCommandsBase
    {
        [TestMethod]
        public void TestSignonSetup()
        {
            Queue<CommandBase> commandQueue = new Queue<CommandBase>();

            using (RpcBroker broker = GetConnectedBroker())
            {
                XusSignonSetupCommand testCommand = new XusSignonSetupCommand(broker);

                commandQueue.Enqueue(testCommand);

                RpcResponse response = ExecuteCommandQueue(commandQueue);

                // *** Check results ***
                Assert.AreEqual(RpcResponseStatus.Success, response.Status);
                Assert.IsFalse(string.IsNullOrWhiteSpace(testCommand.SignonSetup.DomainName));
                Assert.IsFalse(string.IsNullOrWhiteSpace(testCommand.SignonSetup.Port));
                Assert.IsFalse(string.IsNullOrWhiteSpace(testCommand.SignonSetup.ServerName));
                Assert.IsFalse(string.IsNullOrWhiteSpace(testCommand.SignonSetup.UCI));
                Assert.IsFalse(string.IsNullOrWhiteSpace(testCommand.SignonSetup.Volume)); 

                broker.Disconnect(); 
            }
        }

        [TestMethod]
        public void TestIntroMsg()
        {
            Queue<CommandBase> commandQueue = new Queue<CommandBase>();

            using (RpcBroker broker = GetConnectedBroker())
            {
                XusIntroMsgCommand testCommand = new XusIntroMsgCommand(broker);

                commandQueue.Enqueue(testCommand);

                RpcResponse response = ExecuteCommandQueue(commandQueue);

                // *** Check results ***
                Assert.AreEqual(RpcResponseStatus.Success, response.Status);
                Assert.IsFalse(string.IsNullOrWhiteSpace(response.Data));

                broker.Disconnect();
            }
        }

        [TestMethod]
        public void TestValidAVCode()
        {
            TestAvCode(TestConfiguration.ValidAccessCodes[2], TestConfiguration.ValidVerifyCodes[2], RpcResponseStatus.Success);
        }

        [TestMethod]
        public void TestInvalidAVCode()
        {
            TestAvCode("sldkfjsdlkfjsd", "sldkfjsdl", RpcResponseStatus.Fail);
        }

        private void TestAvCode(string accessCode, string verifyCode, RpcResponseStatus expectedStatus)
        {
            Queue<CommandBase> commandQueue = new Queue<CommandBase>();

            using (RpcBroker broker = GetConnectedBroker())
            {
                commandQueue.Enqueue(new XusSignonSetupCommand(broker));

                XusAvCodeCommand testCommand = new XusAvCodeCommand(broker);
                testCommand.AddCommandArguments(accessCode, verifyCode); 

                commandQueue.Enqueue(testCommand);

                RpcResponse response = ExecuteCommandQueue(commandQueue);

                // *** Check results ***
                Assert.AreEqual(expectedStatus, response.Status, response.InformationalMessage);
                
                broker.Disconnect();
            }
        }

        // TODO:...
        //[TestMethod]
        public void TestChangeVerifyCode()
        {
            string accessCode;
            string verifyCode;
            const int userIndex = 1; 

            using (RpcBroker broker = GetConnectedBroker())
            {
                XusSignonSetupCommand setupCommand = new XusSignonSetupCommand(broker);

                RpcResponse response = setupCommand.Execute();

                if (response.Status == RpcResponseStatus.Success)
                {
                    accessCode = TestConfiguration.ValidAccessCodes[userIndex];
                    verifyCode = TestConfiguration.ValidVerifyCodes[userIndex];

                    XusAvCodeCommand avCommand = new XusAvCodeCommand(broker);
                    
                    avCommand.AddCommandArguments(accessCode, verifyCode);

                    response = avCommand.Execute();

                    if ((response.Status == RpcResponseStatus.Success) || (avCommand.SignonResults.MustChangeVerifyCode))
                    {
                        // *** Automatically generated verify codes are in format "dss%####" ***
                        int numericPart;
                        if (int.TryParse(verifyCode.Substring(4), out numericPart))
                        {
                            numericPart += 1;

                            string newVCode = numericPart.ToString("DSS\\%000000000");

                            XusCvcCommand cvcCommand = new XusCvcCommand(broker);
                            
                            cvcCommand.AddCommandArguments(verifyCode, newVCode, newVCode);

                            response = cvcCommand.Execute();

                            if (response.Status == RpcResponseStatus.Success)
                            {
                                string[] verifyCodes = (string[])TestConfiguration.ValidVerifyCodes.Clone();

                                verifyCodes[userIndex] = newVCode;
                                TestConfiguration.ValidVerifyCodes = verifyCodes; 
                            }                            // *** Check results ***
                            Assert.AreEqual(RpcResponseStatus.Success, response.Status);
                        }
                    }
                    else
                        Assert.Fail("XusAvCodeCommand failed");
                }
                else
                    Assert.Fail("XusSignonSetupCommand failed");

                broker.Disconnect();
            }
        }

        [TestMethod]
        public void TestDivisionGet()
        {
            using (RpcBroker broker = GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                XusDivisionGetCommand command = new XusDivisionGetCommand(broker);

                RpcResponse response = command.Execute();

                Assert.IsNotNull(response);
                Assert.AreEqual(RpcResponseStatus.Success, response.Status);
                Assert.IsNotNull(command.Divisions, "No divisions found");  
            }
        }

        [TestMethod]
        public void TestDivisionSetValid()
        {
            TestDivisionSet(2, TestConfiguration.ValidDivision, RpcResponseStatus.Success); 
        }

        [TestMethod]
        public void TestDivisionSetInvalid()
        {
            TestDivisionSet(2, "", RpcResponseStatus.Fail);
        }

        private void TestDivisionSet(int userIndex, string divId, RpcResponseStatus expectedResponse) 
        {
            Queue<CommandBase> commandQueue = new Queue<CommandBase>();

            using (RpcBroker broker = GetConnectedBroker())
            {
                commandQueue.Enqueue(new XusSignonSetupCommand(broker));

                XusAvCodeCommand avCommand = new XusAvCodeCommand(broker);
                avCommand.AddCommandArguments(TestConfiguration.ValidAccessCodes[userIndex], TestConfiguration.ValidVerifyCodes[userIndex]);

                commandQueue.Enqueue(avCommand);

                XusDivisionSetCommand divCommand = new XusDivisionSetCommand(broker, divId);

                commandQueue.Enqueue(divCommand);

                RpcResponse response = ExecuteCommandQueue(commandQueue);

                // *** Check results ***
                Assert.AreEqual(expectedResponse, response.Status);

                broker.Disconnect();
            }
        }

        [TestMethod]
        public void TestSuccessfulGetUserInfo()
        {
            Queue<CommandBase> commandQueue = new Queue<CommandBase>();

            using (RpcBroker broker = GetConnectedBroker())
            {
                commandQueue.Enqueue(new XusSignonSetupCommand(broker));

                XusAvCodeCommand avCommand = new XusAvCodeCommand(broker);
                    
                avCommand.AddCommandArguments(TestConfiguration.ValidAccessCodes[2], TestConfiguration.ValidVerifyCodes[2]);

                commandQueue.Enqueue(avCommand);

                XusGetUserInfoCommand userInfoCommand = new XusGetUserInfoCommand(broker);

                commandQueue.Enqueue(userInfoCommand);

                RpcResponse response = ExecuteCommandQueue(commandQueue);

                // *** Check results ***
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

                broker.Disconnect();
            }
        }

        [TestMethod]
        public void TestFailedGetUserInfo()
        {
            Queue<CommandBase> commandQueue = new Queue<CommandBase>();

            using (RpcBroker broker = GetConnectedBroker())
            {
                commandQueue.Enqueue(new XusSignonSetupCommand(broker));

                XusAvCodeCommand avCommand = new XusAvCodeCommand(broker);
                
                avCommand.AddCommandArguments(TestConfiguration.ValidAccessCodes[0], TestConfiguration.ValidVerifyCodes[0]);

                XusGetUserInfoCommand userInfoCommand = new XusGetUserInfoCommand(broker);

                commandQueue.Enqueue(userInfoCommand);

                RpcResponse response = ExecuteCommandQueue(commandQueue);

                // *** Check results ***
                Assert.AreEqual(RpcResponseStatus.Fail, response.Status);

                broker.Disconnect();
            }
        }
    }
}
