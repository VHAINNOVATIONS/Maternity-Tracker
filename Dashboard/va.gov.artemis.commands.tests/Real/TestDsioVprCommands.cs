// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Commands.Dsio.Vpr;
using VA.Gov.Artemis.Vista.Broker;

namespace VA.Gov.Artemis.Commands.Tests.Real
{
    [TestClass]
    public class TestDsioVprCommands: TestCommandsBase 
    {
        [TestMethod]
        public void TestGetPatientData()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioVprGetPatientDataCommand command = new DsioVprGetPatientDataCommand(broker);

                command.AddCommandArguments(TestConfiguration.DefaultPatientDfn);

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status); 

            }
        }

        [TestMethod]
        public void TestGetPatientDataBadPatient()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioVprGetPatientDataCommand command = new DsioVprGetPatientDataCommand(broker);

                command.AddCommandArguments("999");

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Fail, response.Status);

            }
        }

        [TestMethod]
        public void TestGetFamilyData()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioVprGetPatientDataCommand command = new DsioVprGetPatientDataCommand(broker);

                command.AddCommandArguments(TestConfiguration.DefaultPatientDfn, Vpr.VprDataType.Family);

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);

            }
        }

        [TestMethod]
        public void TestGetLabData()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioVprGetPatientDataCommand command = new DsioVprGetPatientDataCommand(broker);

                command.AddCommandArguments(TestConfiguration.DefaultPatientDfn, Vpr.VprDataType.Labs);

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);

            }
        }
    }
}
