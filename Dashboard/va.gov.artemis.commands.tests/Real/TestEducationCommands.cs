using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Commands.Dsio.Education;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.Commands.Tests.Real
{
    [TestClass]
    public class TestEducationCommands: TestCommandsBase
    {
        [TestMethod]
        public void TestSaveEducationItem()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2); 

                DsioSaveEducationItemCommand command = new DsioSaveEducationItemCommand(broker);

                DsioEducationItem edItem = new DsioEducationItem()
                {
                    Description = "-----Purple Book",
                    Category = "Other",
                    ItemType = "L",
                    Url = "http://www.medlineplus.com", 
                    CodeSystem = "L",
                    Code = "11779-6"
                };

                //DsioEducationItem edItem = new DsioEducationItem()
                //{
                //    Description = "Link to smoking in pregnancy video",
                //    Category = "Smoking",
                //    ItemType = "L",
                //    CodeSystem = "None", 
                //    Url = "http://www.va.gov/vdl"
                //};

                //DsioEducationItem edItem = new DsioEducationItem()
                //{
                //    Description = "D234567891123456789212345678931234567894123456789512345678961234567897123456789812345678991234567890",
                //    Category = "C234567891123456789212345678931234567894123456789512345678961234567897123456789812345678991234567890",
                //    ItemType = "L",
                //    CodeSystem = "None",
                //    Url = "U234567891123456789212345678931234567894123456789512345678961234567897123456789812345678991234567890"
                //};
                command.AddCommandArguments(edItem);

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);
                Assert.IsNotNull(command.Ien); 

                broker.Disconnect();
            }
        }

        [TestMethod]
        public void TestSaveExistingItem()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioSaveEducationItemCommand command = new DsioSaveEducationItemCommand(broker);

                DsioEducationItem edItem = new DsioEducationItem()
                {
                    Description = "Purple Book" + DateTime.Now.ToString("yyMMdd"), 
                    Category = "Initial Materials",
                    ItemType = "P",
                    CodeSystem = "NONE"
                };
                
                command.AddCommandArguments(edItem);

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);
                Assert.IsNotNull(command.Ien);

                edItem.Ien = command.Ien; 
                edItem.Category = "Third Test";

                command.AddCommandArguments(edItem);

                response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);
                Assert.IsNotNull(command.Ien);

                broker.Disconnect();
            }
        }

        [TestMethod]
        public void TestUpdateExistingEducationItem()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioGetEducationItemsCommand getCommand = new DsioGetEducationItemsCommand(broker);

                getCommand.AddCommandArguments("", "", "", 0, 0, 0);

                RpcResponse response = getCommand.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);
                Assert.IsNotNull(getCommand.EducationItems);

                if (getCommand.EducationItems.Count > 0)
                {
                    DsioEducationItem item = getCommand.EducationItems[getCommand.EducationItems.Count - 1];

                    string newDescription = "Edited Description " + DateTime.Now.ToString("yyMMdd");
                    item.Description = newDescription;
                    item.CodeSystem = "N";

                    DsioSaveEducationItemCommand saveCommand = new DsioSaveEducationItemCommand(broker);

                    saveCommand.AddCommandArguments(item);

                    response = saveCommand.Execute();

                    Assert.AreEqual(RpcResponseStatus.Success, response.Status);

                    getCommand.AddCommandArguments(item.Ien, "", "", 0, 0, 0);

                    response = getCommand.Execute();

                    // NOTE: This is failing because total results are missing from command response...waiting for fix...

                    Assert.AreEqual(RpcResponseStatus.Success, response.Status);
                    Assert.IsNotNull(getCommand.EducationItems);

                    DsioEducationItem editedItem = getCommand.EducationItems[0];

                    Assert.AreEqual(item.Description, editedItem.Description);
                }

                broker.Disconnect();
            }
        }

        [TestMethod]
        public void TestGetEducationItems()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioGetEducationItemsCommand command = new DsioGetEducationItemsCommand(broker);

                //command.AddCommandArguments("", "", "", 1, 10, 0);
                //command.AddCommandArguments("", "", "", 0,0);
                //command.AddCommandArguments("145", "", "", -1, -1, 0); 
                command.AddCommandArguments("", "", "", -1, -1, 0); 

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);

                broker.Disconnect(); 
            }
        }
        
        [TestMethod]
        public void TestGetEducationItemsOnePage()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioGetEducationItemsCommand command = new DsioGetEducationItemsCommand(broker);

                command.AddCommandArguments("", "", "", 3, 2, 0);

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);

                broker.Disconnect();
            }
        }

        [TestMethod]
        public void TestGetEducationItemsFiltered()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioGetEducationItemsCommand command = new DsioGetEducationItemsCommand(broker);

                //command.AddCommandArguments("", "","PRINTED MATERIAL", 2, 2);
                command.AddCommandArguments("", "", "PRINTED MATERIAL", 0, 0, 0); 

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);

                broker.Disconnect();
            }
        }

        [TestMethod]
        public void TestDeleteEducationItem()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioSaveEducationItemCommand command = new DsioSaveEducationItemCommand(broker);

                DsioEducationItem edItem = new DsioEducationItem()
                {
                    Description = "This is something I want to delete on Tuesday",
                    Category = "Smoking",
                    ItemType = "L",
                    CodeSystem = "None",
                    Url = "http://www.va.gov/vdl"
                };

                command.AddCommandArguments(edItem);

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);
                Assert.IsNotNull(command.Ien);

                DsioDeleteEducationItemCommand delCommand = new DsioDeleteEducationItemCommand(broker);

                delCommand.AddCommandArguments(command.Ien);

                response = delCommand.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);

                DsioGetEducationItemsCommand getCommand = new DsioGetEducationItemsCommand(broker);

                getCommand.AddCommandArguments(command.Ien, "", "", 0, 0, 0);

                response = getCommand.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);
                Assert.IsNull(getCommand.EducationItems); 

                broker.Disconnect();
            }
        }

        [TestMethod]
        public void TestSavePatientItem()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioSavePatientEducationCommand command = new DsioSavePatientEducationCommand(broker);

                DsioPatientEducationItem edItem = new DsioPatientEducationItem()
                {
                    PatientDfn = "647", 
                    CompletedOn = Util.GetFileManDateAndTime(DateTime.Now),
                    Description = "Testing",
                    Category = "Other",
                    ItemType = "E",
                    CodeSystem = "N",
                    //Url = "http://testurl"
                    //Description = "D234567891123456789212345678931234567894123456789512345678961234567897123456789812345678991234567890",
                    //Category = "C234567891123456789212345678931234567894123456789512345678961234567897123456789812345678991234567890",
                    //ItemType = "L",
                    //CodeSystem = "None",
                    //Url = "U234567891123456789212345678931234567894123456789512345678961234567897123456789812345678991234567890"
                };

                command.AddCommandArguments(edItem);

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);
                Assert.IsNotNull(command.Ien);

                broker.Disconnect();
            }
        }

        [TestMethod]
        public void TestSavePatientItemCopy()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioSavePatientEducationCommand command = new DsioSavePatientEducationCommand(broker);

                DsioPatientEducationItem edItem = new DsioPatientEducationItem()
                {
                    PatientDfn = "715",
                    CompletedOn = Util.GetFileManDate(DateTime.Now),
                    EducationItemIen = "8"
                };

                command.AddCommandArguments(edItem);

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);
                Assert.IsNotNull(command.Ien);

                broker.Disconnect();
            }
        }

        [TestMethod]
        public void TestGetPatientEducationItems()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2); 

                DsioGetPatientEducationCommand command = new DsioGetPatientEducationCommand(broker);

                command.AddCommandArguments("647", "", "", "", "", 1, 1000);

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);

            }
        }

        [TestMethod]
        public void TestGetPatientEducationItem()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioGetPatientEducationCommand command = new DsioGetPatientEducationCommand(broker);

                command.AddCommandArguments("715","4", "", "", "", 1, 1000);

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);

            }
        }

        [TestMethod]
        public void TestGetPatientEducationItemsByDate()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioGetPatientEducationCommand command = new DsioGetPatientEducationCommand(broker);

                command.AddCommandArguments("715", "","3140904", "", "", 1, 1000);

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);

            }
        }

        [TestMethod]
        public void TestGetPatientEducationItemsByDate2()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioGetPatientEducationCommand command = new DsioGetPatientEducationCommand(broker);

                command.AddCommandArguments("715", "", "", "3140903", "", 1, 1000);

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);

            }
        }

        [TestMethod]
        public void TestGetPatientEducationItemsByType()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioGetPatientEducationCommand command = new DsioGetPatientEducationCommand(broker);

                command.AddCommandArguments("715", "", "", "", "L", 1, 1000);

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);

            }
        }

        [TestMethod]
        public void TestGetPatientEducationItemsPaged()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioGetPatientEducationCommand command = new DsioGetPatientEducationCommand(broker);

                command.AddCommandArguments("715", "", "", "", "", 2, 2);

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);

            }
        }
    }
}
