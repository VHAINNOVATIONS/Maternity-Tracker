using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Commands.Dsio.Checklist;
using VA.Gov.Artemis.Commands.Dsio.Pregnancy;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.Commands.Tests.Real
{
    [TestClass]
    public class TestChecklistCommands: TestCommandsBase
    {
        [TestMethod]
        public void TestGetChecklistItems()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioGetMccChecklistCommand command = new DsioGetMccChecklistCommand(broker);

                command.AddCommandArguments("", 1, 100);

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status); 

                broker.Disconnect(); 
            }
        }

        [TestMethod]
        public void TestSaveChecklistItem()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioSaveMccChecklistCommand command = new DsioSaveMccChecklistCommand(broker);

                DsioChecklistItem item = new DsioChecklistItem()
                {
                    Ien = "",
                    Description = "Send Link to Pregnancy Video",
                    ItemType = DsioChecklistItemType.EducationItem,
                    DueCalculationType = DsioChecklistCalculationType.WeeksGa, 
                    DueCalculationValue = "12",
                    Category = "Some New Category",
                    EducationIen = TestConfiguration.ValidEducationIen
                };

                //6:Send Link to Pregnancy Video^2:Education Item^2:WEEKS GA^12^0:0^3456

                command.AddCommandArguments(item);

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);

                broker.Disconnect();
            }
        }

        [TestMethod]
        public void TestSaveNewPatientChecklistItem()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioPregnancy preg = this.GetOrCreatePregnancy(broker, TestConfiguration.DefaultPatientDfn);

                Assert.IsNotNull(preg);

                DsioSaveMccPatChecklistCommand command = new DsioSaveMccPatChecklistCommand(broker);

                DsioPatientChecklistItem item = new DsioPatientChecklistItem()
                {
                    PatientDfn = TestConfiguration.DefaultPatientDfn,
                    PregnancyIen = preg.Ien,
                    Category = "First Trimester Requirements",
                    Description = "Friday Tests",
                    ItemType = DsioChecklistItemType.Lab,
                    DueCalculationType = DsioChecklistCalculationType.None,
                    DueCalculationValue = "0",
                    CompletionStatus = DsioChecklistCompletionStatus.Complete,
                    Link = "12345", 
                    SpecificDueDate = Util.GetFileManDate(new DateTime(2014, 9, 1)), 
                    CompletionLink = "54321", 
                    Note = "Checklist Item Note Text", 
                    InProgress="1", 
                    EducationIen = TestConfiguration.ValidEducationIen
                };

                command.AddCommandArguments(item); 

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);

                broker.Disconnect();
            }
            
        }



        [TestMethod]
        public void TestGetPatientChecklistItem()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioGetMccPatientChecklistCommand command = new DsioGetMccPatientChecklistCommand(broker);

                DsioPregnancy preg = this.GetOrCreatePregnancy(broker, TestConfiguration.DefaultPatientDfn);

                Assert.IsNotNull(preg);

                command.AddCommandArguments(TestConfiguration.DefaultPatientDfn ,"", preg.Ien, DsioChecklistCompletionStatus.Unknown);

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);

                broker.Disconnect();
            }
        }

        [TestMethod]
        public void TestGetPatientChecklistItems()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioGetMccPatientChecklistCommand command = new DsioGetMccPatientChecklistCommand(broker);

                command.AddCommandArguments(TestConfiguration.DefaultPatientDfn, "", "", DsioChecklistCompletionStatus.Complete);

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);

                broker.Disconnect();
            }
        }

        [TestMethod]
        public void TestDeleteChecklistItem()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioSaveMccChecklistCommand saveCommand = new DsioSaveMccChecklistCommand(broker);

                DsioChecklistItem item = new DsioChecklistItem()
                {
                    Ien = "",
                    Description = "Send Link to Pregnancy Video",
                    ItemType = DsioChecklistItemType.EducationItem,
                    DueCalculationType = DsioChecklistCalculationType.WeeksGa,
                    DueCalculationValue = "12",
                    Category = "Some New Category",
                    Link = "3456"
                };

                saveCommand.AddCommandArguments(item);

                RpcResponse response = saveCommand.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);

                Assert.IsFalse(string.IsNullOrWhiteSpace(saveCommand.Ien)); 

                DsioDeleteMccChecklistCommand delCommand = new DsioDeleteMccChecklistCommand(broker);

                delCommand.AddCommandArguments(saveCommand.Ien);

                response = delCommand.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status); 
            }
        }

        [TestMethod]
        public void TestDeletePatientChecklistItem()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioPregnancy preg = this.GetOrCreatePregnancy(broker, TestConfiguration.DefaultPatientDfn);

                Assert.IsNotNull(preg);

                DsioSaveMccPatChecklistCommand saveCommand = new DsioSaveMccPatChecklistCommand(broker);

                DsioPatientChecklistItem item = new DsioPatientChecklistItem()
                {
                    PatientDfn = TestConfiguration.DefaultPatientDfn,
                    PregnancyIen = preg.Ien,
                    Category = "First Trimester Requirements",
                    Description = "Friday Tests",
                    ItemType = DsioChecklistItemType.Lab,
                    DueCalculationType = DsioChecklistCalculationType.None,
                    DueCalculationValue = "0",
                    CompletionStatus = DsioChecklistCompletionStatus.Complete,
                    Link = "12345",
                    SpecificDueDate = Util.GetFileManDate(new DateTime(2014, 9, 1)),
                    CompletionLink = "54321",
                    Note = "Checklist Item Note Text",
                    InProgress = "1"
                };

                saveCommand.AddCommandArguments(item);

                RpcResponse response = saveCommand.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);

                Assert.IsFalse(string.IsNullOrWhiteSpace(saveCommand.Ien));

                DsioDeleteMccPatChklstCommand delCommand = new DsioDeleteMccPatChklstCommand(broker);

                delCommand.AddCommandArguments(TestConfiguration.DefaultPatientDfn, saveCommand.Ien);

                response = delCommand.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);
            }
        }
    }
}
