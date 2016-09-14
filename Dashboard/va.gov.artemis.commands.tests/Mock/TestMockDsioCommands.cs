using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.UI.Mock;
using VA.Gov.Artemis.Commands.Dsio;
using VA.Gov.Artemis.Commands.Dsio.Notes;
using VA.Gov.Artemis.Commands.Dsio.PatientSearch;

namespace VA.Gov.Artemis.Commands.tests.Mock
{
    [TestClass]
    public class TestMockDsioCommands
    {
        //[TestMethod]
        //public void TestMockPatientList()
        //{
        //    // TODO: Add more detailed tests...

        //    //IRpcBroker broker MockRpcBrokerFactory.GetSomething...
        //    IRpcBroker broker = new MockRpcBroker();

        //    VfdwvPatientListCommand patListCommand = new VfdwvPatientListCommand(broker, "RoiStaff");

        //    RpcResponse response = patListCommand.Execute();

        //    Assert.IsNotNull(response);

        //    Assert.IsNotNull(patListCommand.ReturnData);
        //}

        //[TestMethod]
        //public void TestMockPatientSearch_ILast4()
        //{
        //    TestMockPatientSearch("C0008");
        //    TestMockPatientSearch("C1719");
        //}

        //[TestMethod]
        //public void TestMockPatientSearch_PartialLast()
        //{
        //    List<DsioSearchPatient> patients = TestMockPatientSearch("CPR");

        //    Assert.IsNotNull(patients);

        //    Assert.IsTrue(patients.Count > 0); 

        //}

        [TestMethod]
        public void TestMockPatientSearch_FullName()
        {
            //TestPatientSearch("CPRSPATIENT,FO");
            TestMockPatientSearch("CPRSPATIENT,TWO F");
            TestMockPatientSearch("CPRSPATIENT,TWO ");
            TestMockPatientSearch("CPRSPATIENT,EIGHT");
            TestMockPatientSearch("CPRSPATIENT,EIGHT ");
            TestMockPatientSearch("CPRSPATIENT,EIGHT F");
            TestMockPatientSearch(" CPRSPATIENT,EIGHT");
        }

        [TestMethod]
        public void TestMockPatientSearch_NoParams()
        {
            TestMockPatientSearch("");
        }

        private List<DsioSearchPatient> TestMockPatientSearch(string searchParam)
        {
            IRpcBroker broker = MockRpcBrokerFactory.GetDsioFemalePatientSearchBroker();

            //DsioPatientSearchCommand patSearchCommand = new DsioPatientSearchCommand(broker);
            //DsioFemalePatientSearchCommand patSearchCommand = new DsioFemalePatientSearchCommand(broker); 
            DsioPatientListCommand patSearchCommand = new DsioPatientListCommand(broker); 

            RpcResponse response = patSearchCommand.Execute();

            Assert.AreEqual(RpcResponseStatus.Success, response.Status);

            return patSearchCommand.MatchingPatients;
        }

        [TestMethod]
        public void TestCreateANote()
        {
            IRpcBroker broker = MockRpcBrokerFactory.GetCreateANoteBroker();

            DsioCreateANoteCommand command = new DsioCreateANoteCommand(broker);

            command.AddCommandArguments("740", "MCC DASHBOARD NOTE", "Note text for Friday", "test subject", new DsioNoteData(), "");

            RpcResponse response = command.Execute();

            Assert.AreEqual(RpcResponseStatus.Success, response.Status);
        }
    }
}
