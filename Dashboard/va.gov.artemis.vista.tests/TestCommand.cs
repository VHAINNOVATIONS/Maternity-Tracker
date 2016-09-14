using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using VA.Gov.Artemis.Vista.Broker;

namespace VA.Gov.Artemis.Vista.Tests
{
    [TestClass]
    public class TestCommand
    {
        [TestMethod]
        public void TestExecute()
        {
            using (RpcBroker broker = new RpcBroker("", 9000))
            {
                if (broker.Connect())
                {
                    MockCommand cmd = new MockCommand(broker);

                    RpcResponse response = cmd.Execute();

                    Assert.AreEqual("", response.Data);
                    Assert.AreNotEqual("", response.InformationalMessage);
                    Assert.AreEqual(RpcResponseFailType.None, response.FailType);
                    Assert.AreEqual(RpcResponseStatus.Unknown, response.Status);

                    CollectionAssert.AreEqual(new string[0], response.Lines); 

                    broker.Disconnect(); 
                }

            }
        }

        [TestMethod]
        public void TestExecuteNotConnected()
        {
            using (RpcBroker broker = new RpcBroker("sdfsdf", 0))
            {
                MockCommand cmd = new MockCommand(broker);
                
                RpcResponse response = cmd.Execute();

                Assert.AreEqual("", response.Data);
                Assert.AreNotEqual("", response.InformationalMessage);
                Assert.AreEqual(RpcResponseFailType.NotConnected, response.FailType);
                Assert.AreEqual(RpcResponseStatus.Fail, response.Status);

                CollectionAssert.AreEqual(new string[0], response.Lines);

            }
        }

        [TestMethod]
        public void TestGetXml()
        {
            using (RpcBroker broker = new RpcBroker("sdfsdf", 0))
            {
                MockCommand cmd = new MockCommand(broker);

                string xml = cmd.GetXmlDescription();

                Assert.IsTrue((!string.IsNullOrWhiteSpace(xml)), "Xml is Null or Whitespace"); 
            }

        }
    }
}
