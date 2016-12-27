using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Commands.Dsio.Patient;
using VA.Gov.Artemis.Commands.Dsio.Pregnancy;
using VA.Gov.Artemis.Vista.Broker;

namespace VA.Gov.Artemis.Commands.Tests.Real
{
    [TestClass]
    public class TestPatientCommands: TestCommandsBase
    {
        [TestMethod]
        public void TestGetPatient()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioGetPatientInformationCommand command = new DsioGetPatientInformationCommand(broker);

                command.AddCommandArguments(TestConfiguration.DefaultPatientDfn); 

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);
            }
        }

        [TestMethod]
        public void TestGetPatientNotFound()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioGetPatientInformationCommand command = new DsioGetPatientInformationCommand(broker);

                command.AddCommandArguments("-999");

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);
                Assert.IsNull(command.Patient);

            }

        }

        [TestMethod]
        public void TestSetPatientInformation()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioSetPatientInformationCommand command = new DsioSetPatientInformationCommand(broker);

                command.AddCommandArguments(TestConfiguration.DefaultPatientDfn, DsioPatientInformationFields.LmpKey, "06/06/2014");

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Fail, response.Status);

            }
        }

    }
}
