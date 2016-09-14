using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using VA.Gov.Artemis.Vista.Broker;

namespace VA.Gov.Artemis.Vista.Tests
{
    [TestClass]
    public class TestRpcResponse
    {
        [TestMethod]
        public void TestDefaultConstructor()
        {
            RpcResponse response = new RpcResponse();

            Assert.AreEqual("", response.Data);
            Assert.AreEqual("", response.InformationalMessage);
            Assert.AreEqual(RpcResponseStatus.Unknown, response.Status);
            Assert.AreEqual(RpcResponseFailType.None, response.FailType); 
        }

        [TestMethod]
        public void TestConstructor()
        {
            RpcResponseFailType failType = RpcResponseFailType.SocketError;
            string failMessage = "this doesn't matter"; 

            RpcResponse response = new RpcResponse(failType, failMessage);

            Assert.AreEqual("", response.Data);
            Assert.AreEqual(failMessage, response.InformationalMessage);
            Assert.AreEqual(RpcResponseStatus.Fail, response.Status);
            Assert.AreEqual(failType, response.FailType); 

        }
    }
}
