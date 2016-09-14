using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Collections.Generic;
using VA.Gov.Artemis.Vista.Commands;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Commands.Xus;

namespace VA.Gov.Artemis.Commands.Tests.Real
{
    [TestClass]
    public class TestOrwptCommands: TestCommandsBase
    {
        [TestMethod]
        public void TestListAll()
        {
            Queue<CommandBase> commandQueue = new Queue<CommandBase>();

            //using (RpcBroker broker = this.GetConnectedBroker())
            //{
            //    commandQueue.Enqueue(new XusSignonSetupCommand(broker));

            //    XusAvCodeCommand avCommand = new XusAvCodeCommand(broker, ValidAccessCodes[0], ValidVerifyCodes[0]);

            //    commandQueue.Enqueue(avCommand);

            //    OrwptListAllCommand listCommand = new OrwptListAllCommand(broker);

            //    commandQueue.Enqueue(listCommand);

            //    RpcResponse response = ExecuteCommandQueue(commandQueue);

            //    Assert.IsNotNull(response);
            //    Assert.AreEqual(RpcResponseStatus.Success, response.Status);
            //    Assert.IsNotNull(listCommand.PatientList);
            //    Assert.IsTrue(listCommand.PatientList.Count > 0);                 

            //    broker.Disconnect(); 
            //}

        }

        //[TestMethod]
        //public void TestSelect()
        //{
        //    using (RpcBroker broker = this.GetConnectedBroker())
        //    {
        //        this.SignonToBroker(broker, 0);

        //        OrwptSelectCommand command = new OrwptSelectCommand(broker);

        //        command.AddDfnArgument("358");
        //        //command.AddDfnArgument("90000");

        //        RpcResponse response = command.Execute();

        //        Assert.AreEqual(RpcResponseStatus.Success, response.Status);

        //        broker.Disconnect();
        //    }
        //}
    }
}
