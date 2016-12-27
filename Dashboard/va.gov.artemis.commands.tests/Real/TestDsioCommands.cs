using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Commands.Xus;
using VA.Gov.Artemis.Commands.Dsio;
using VA.Gov.Artemis.Commands.Dsio.NonVA;
using VA.Gov.Artemis.Commands.Dsio.Tracking;
using VA.Gov.Artemis.Commands.Dsio.Notes;
using VA.Gov.Artemis.Commands.Dsio.Base;
using VA.Gov.Artemis.Commands.Dsio.PatientSearch;
using System.Text;

namespace VA.Gov.Artemis.Commands.Tests.Real
{
    [TestClass]
    public class TestDsioCommands: TestCommandsBase
    {
        //[TestMethod]
        //public void TestPatientList_Good()
        //{
        //    TestPatientList("CPRSPATIENT");
        //}

        //[TestMethod]
        //public void TestPatientList_Empty()
        //{
        //    TestPatientList("");
        //}

        //[TestMethod]
        //public void TestPatientList_MixedCase()
        //{
        //    TestPatientList("CpRsPatient");
        //}
        
        //private void TestPatientList(string lastName) 
        //{
        //    using (RpcBroker broker = GetConnectedBroker())
        //    {
        //        XusSignonSetupCommand signonSetupCommand = new XusSignonSetupCommand(broker);

        //        RpcResponse response = signonSetupCommand.Execute();

        //        Assert.AreEqual(RpcResponseStatus.Success, response.Status); 

        //        //XusAvCodeCommand avCodeCommand = new XusAvCodeCommand(broker, ValidAccessCodes[0], ValidVerifyCodes[0]);        

        //        response = avCodeCommand.Execute();

        //        Assert.AreEqual(RpcResponseStatus.Success, response.Status); 

        //        VfdwvPatientListCommand patListCommand = new VfdwvPatientListCommand(broker, lastName);

        //        response = patListCommand.Execute();

        //        Assert.AreEqual(RpcResponseStatus.Success, response.Status); 

        //        Assert.IsNotNull(patListCommand.ReturnData);

        //        broker.Disconnect();
        //    }
        //}

        // *** Requirements for Patient Search ***
        // *** Search by Initial of Last Name + Last 4 of SSN ***
        // *** Search by Partial last name ***
        // *** Search by Full name 

        //1.	Patient DFN
        //2.	Last Name
        //3.	First Name
        //4.	Last 4 of SSN
        //5.	DOB
        //6.	Veteran Status
        //7.	Location
        //8.	Room/Bed
        //9.	Service Connected
        //10.	Tracking Status
        //a.	0 = Yes, patient is currently being tracked
        //b.	1 = No, patient is NOT currently being tracked
        //c.	2 = Pending, patient has been automatically flagged for tracking by a trigger or data element but has not been accepted or rejected for tracking.

        [TestMethod]
        public void TestPatientSearch_ILast4()
        {
            //TestPatientSearch("C0008");
            //TestPatientSearch("C1719");
            TestPatientSearch(TestConfiguration.PatientSearchILast4[0]);
            TestPatientSearch(TestConfiguration.PatientSearchILast4[1]);
        }

        [TestMethod]
        public void TestPatientSearch_PartialLast()
        {
            //TestPatientSearch("R");
            TestPatientSearch(TestConfiguration.PatientSearchPartial);
        }

        [TestMethod]
        public void TestPatientSearch_FullName()
        {
            //TestPatientSearch("CPRSPATIENT,FO");
            //TestPatientSearch("CPRSPATIENT,TWO F");
            //TestPatientSearch("CPRSPATIENT,TWO ");
            //TestPatientSearch("CPRSPATIENT,EIGHT");
            //TestPatientSearch("CPRSPATIENT,EIGHT ");
            //TestPatientSearch("CPRSPATIENT,EIGHT F");
            //TestPatientSearch(" CPRSPATIENT,EIGHT");
            TestPatientSearch(TestConfiguration.PatientsSearchFullNames[0]);
            TestPatientSearch(TestConfiguration.PatientsSearchFullNames[0] + " ");
            TestPatientSearch(" " + TestConfiguration.PatientsSearchFullNames[0]);

            TestPatientSearch(TestConfiguration.PatientsSearchFullNames[1]);
            TestPatientSearch(TestConfiguration.PatientsSearchFullNames[1] + " ");
            TestPatientSearch(" " + TestConfiguration.PatientsSearchFullNames[1]);

        }

        [TestMethod]
        public void TestPatientSearch_NoParams()
        {
            TestPatientSearch("");
        }

        private void TestPatientSearch(string searchParam)
        {
            using (RpcBroker broker = GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioPatientListCommand command = new DsioPatientListCommand(broker); 
                                
                command.AddCommandArguments(searchParam, 1, 10); 

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);

                broker.Disconnect();
            }
        }

        //[TestMethod]
        //public void TestGetTracking()
        //{
        //    using (RpcBroker broker = GetConnectedBroker())
        //    {
        //        this.SignonToBroker(broker, 2);

        //        DsioGetTrackingCommand command = new DsioGetTrackingCommand(broker);

        //        // *** Add appropriate parameters ***
        //        command.AddGetTrackedPatientsParameters(-1, -1);

        //        RpcResponse response = command.Execute();

        //        Assert.AreEqual(RpcResponseStatus.Success, response.Status);
        //        Assert.IsNotNull(command.TrackingItems);

        //        if (command.TrackingItems.Count > 0)
        //        {
        //            foreach (DsioTrackingItem item in command.TrackingItems)
        //            {
        //                Assert.IsFalse(string.IsNullOrWhiteSpace(item.Id));
        //                Assert.IsFalse(string.IsNullOrWhiteSpace(item.Dfn));
        //                Assert.IsFalse(string.IsNullOrWhiteSpace(item.PatientName));
        //                //Assert.IsFalse(string.IsNullOrWhiteSpace(item.Reason));
        //                Assert.IsFalse(string.IsNullOrWhiteSpace(item.Source));
        //                Assert.IsFalse(string.IsNullOrWhiteSpace(item.TrackingItemDateTime));
        //                Assert.IsFalse(string.IsNullOrWhiteSpace(item.TrackingType));
        //                Assert.IsFalse(string.IsNullOrWhiteSpace(item.User));
        //            }
        //        }
        //        broker.Disconnect(); 
        //    }
        //}

        [TestMethod]
        public void TestGetTracking_AllEntries()
        {
            using (RpcBroker broker = GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioGetTrackingCommand command = new DsioGetTrackingCommand(broker);

                command.AddGetAllParameters(1, 5);

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);
                Assert.IsNotNull(command.TrackingItems);

                if (command.TrackingItems.Count > 0)
                {
                    foreach (DsioTrackingItem item in command.TrackingItems)
                    {
                        Assert.IsFalse(string.IsNullOrWhiteSpace(item.Id));
                        Assert.IsFalse(string.IsNullOrWhiteSpace(item.Dfn));
                        Assert.IsFalse(string.IsNullOrWhiteSpace(item.PatientName));
                        //Assert.IsFalse(string.IsNullOrWhiteSpace(item.Reason));
                        Assert.IsFalse(string.IsNullOrWhiteSpace(item.Source));
                        Assert.IsFalse(string.IsNullOrWhiteSpace(item.TrackingItemDateTime));
                        Assert.IsFalse(string.IsNullOrWhiteSpace(item.TrackingType));
                        Assert.IsFalse(string.IsNullOrWhiteSpace(item.User));
                    }
                }
                broker.Disconnect();

            }
        }

        [TestMethod]
        public void TestGetTracking_FlaggedPatients()
        {
            using (RpcBroker broker = GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioGetTrackingCommand command = new DsioGetTrackingCommand(broker);

                command.AddGetFlaggedPatientsParameters(1,1000); 

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status); 
                
                broker.Disconnect();
            }
        }

        [TestMethod]
        public void TestGetTracking_TrackedPatients()
        {
            using (RpcBroker broker = GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioGetTrackingCommand command = new DsioGetTrackingCommand(broker);

                command.AddGetTrackedPatientsParameters(1,100);

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);
                Assert.IsNotNull(command.TrackedPatients);

                broker.Disconnect();
            }
        }

        [TestMethod]
        public void TestGetTracking_AllEntriesByPatient()
        {
            using (RpcBroker broker = GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioGetTrackingCommand command = new DsioGetTrackingCommand(broker);

                command.AddPatientLogsParameter(TestConfiguration.DefaultPatientDfn, 1, 3);

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);
                Assert.IsNotNull(command.TrackingItems);
                
                broker.Disconnect(); 
            }
        }

        [TestMethod]
        public void TestCreateTrackingLog()
        {
            using (RpcBroker broker = GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioCreateTrackingLogCommand command = new DsioCreateTrackingLogCommand(broker);

                string dfn = TestConfiguration.DefaultPatientDfn;
                string eventType = "0";
                string reason = "Pregnant";
                string[] comment = new string[]{"line1","line2"};

                command.AddCommandArguments(dfn, eventType, reason, comment); 

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);

                eventType = "1";

                command.AddCommandArguments(dfn, eventType, reason, comment);

                response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);

                broker.Disconnect();
            }
        }

        [TestMethod]
        public void TestGetSelectList()
        {
            using (RpcBroker broker = GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioSelectListCommand command = new DsioSelectListCommand(broker);

                command.AddCommandArguments("R");

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);

                broker.Disconnect();
            }
        }

        [TestMethod]
        public void TestAddItemToSelectList()
        {
            using (RpcBroker broker = GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioSelectListCommand command = new DsioSelectListCommand(broker);

                command.AddCommandArguments("R", "Lactation", DsioSelectListCommand.SelectListOperation.Add);

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);

                broker.Disconnect();
            }

        }

        [TestMethod]
        public void TestDeleteItemFromSelectList()
        {
            using (RpcBroker broker = GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioSelectListCommand command = new DsioSelectListCommand(broker);

                command.AddCommandArguments("R", "Bogus Reason", DsioSelectListCommand.SelectListOperation.Delete);

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);

                broker.Disconnect();
            }

        }

        //[TestMethod]
        //public void TestPatientSearch2()
        //{
        //    using (RpcBroker broker = GetConnectedBroker())
        //    {
        //        this.SignonToBroker(broker, 2);

        //        DsioPatientListCommand command = new DsioPatientListCommand(broker); 

        //        command.AddCommandArguments("Ay", 1, 10);

        //        RpcResponse response = command.Execute();

        //        Assert.AreEqual(RpcResponseStatus.Success, response.Status);

        //        broker.Disconnect(); 
        //    }
        //}

        [TestMethod]
        public void TestPatientFind()
        {
            using (RpcBroker broker = GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioPatientListCommand command = new DsioPatientListCommand(broker); 

                command.AddCommandArguments(TestConfiguration.PatientSearchILast4[0], -1, -1);

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);

                broker.Disconnect();
            }
        }

        [TestMethod]
        public void TestSaveNonVAItem()
        {
            using (RpcBroker broker = GetConnectedBroker())
            {
                this.SignonToBroker(broker, 3);

                SaveNewNonVAItem(broker);
            }
        }

        private string SaveNewNonVAItem(IRpcBroker broker)
        {
            string returnVal = ""; 

            DsioSaveExternalEntityCommand command = new DsioSaveExternalEntityCommand(broker);

            DsioNonVAItem nonVAEntity = new DsioNonVAItem();

            nonVAEntity.Ien = "";
            nonVAEntity.EntityName = string.Format("New {0} Hospital", GetRandom());
            nonVAEntity.EntityType = "F";
            nonVAEntity.Address.StreetLine1 = "789 Test Street";
            nonVAEntity.Address.StreetLine2 = "Suite XFD";
            nonVAEntity.Address.City = "Sacramento";
            nonVAEntity.Address.State = "CA";
            nonVAEntity.Address.ZipCode = "93939";
            nonVAEntity.TelephoneList.Add(new DsioTelephone() { Number = "8009008000", Usage = DsioTelephone.WorkPhoneUsage });
            nonVAEntity.TelephoneList.Add(new DsioTelephone() { Number = "8887776666", Usage = DsioTelephone.FaxUsage });

            nonVAEntity.PrimaryContact = "Extra Important";
            nonVAEntity.Inactive = "0";

            command.AddCommandArguments(nonVAEntity);

            RpcResponse response = command.Execute();

            Assert.AreEqual(RpcResponseStatus.Success, response.Status);

            returnVal = command.Ien;

            return returnVal; 
        }

        [TestMethod]
        public void TestUpdateNonVAItem()
        {
            using (RpcBroker broker = GetConnectedBroker())
            {
                this.SignonToBroker(broker, 3);

                string newIen = SaveNewNonVAItem(broker); 

                DsioGetExternalEntityCommand getCommand = new DsioGetExternalEntityCommand(broker);

                getCommand.AddCommandArguments(newIen, 1, 10);

                RpcResponse response = getCommand.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status); 

                DsioSaveExternalEntityCommand command = new DsioSaveExternalEntityCommand(broker);

                Assert.IsNotNull(getCommand.NonVAEntities); 
                Assert.IsTrue(getCommand.NonVAEntities.Count == 1);

                DsioNonVAItem nonVAEntity = getCommand.NonVAEntities[0];

                nonVAEntity.EntityName =  string.Format("Updated {0} Hospital", GetRandom()); 

                command.AddCommandArguments(nonVAEntity);

                response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);
            }
        }

        [TestMethod]
        public void TestSaveNonVAProvider()
        {
            using (RpcBroker broker = GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioSaveExternalEntityCommand command = new DsioSaveExternalEntityCommand(broker);

                DsioNonVAItem nonVAEntity = new DsioNonVAItem();

                nonVAEntity.Ien = "";
                nonVAEntity.EntityName = "Wednesday Test OBGYNC";
                nonVAEntity.EntityType = "P";
                nonVAEntity.Address.StreetLine1 = "789 Test Street";
                nonVAEntity.Address.StreetLine2 = "Suite XFD";
                nonVAEntity.Address.City = "Sacramento";
                nonVAEntity.Address.State = "CA";
                nonVAEntity.Address.ZipCode = "93939";
                nonVAEntity.TelephoneList.Add(new DsioTelephone() { Number = "8009008000", Usage = DsioTelephone.WorkPhoneUsage });
                nonVAEntity.TelephoneList.Add(new DsioTelephone() { Number = "8887776666", Usage = DsioTelephone.FaxUsage });

                nonVAEntity.PrimaryContact = "Primary,Contact";
                nonVAEntity.Inactive = "0";

                command.AddCommandArguments(nonVAEntity);

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);
            }
        }
        [TestMethod]
        public void TestGetNonVAItems()
        {
            using (RpcBroker broker = GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioGetExternalEntityCommand command = new DsioGetExternalEntityCommand(broker);

                command.AddCommandArguments("P", 1, 100);

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);
            }
        }

        [TestMethod]
        public void TestGetNonVAItem()
        {
            using (RpcBroker broker = GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioGetExternalEntityCommand command = new DsioGetExternalEntityCommand(broker);

                command.AddCommandArguments("2", 1, 10);

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);
            }
        }

        [TestMethod]
        public void TestSaveNewNonVAItem()
        {
            using (RpcBroker broker = GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioSaveExternalEntityCommand command = new DsioSaveExternalEntityCommand(broker);

                DsioNonVAItem nonVAEntity = new DsioNonVAItem();

                string randomName = string.Format("{0} Hospital", GetRandom()); 
                
                nonVAEntity.Ien = "";
                nonVAEntity.EntityType = "P";
                nonVAEntity.EntityName = randomName;
                nonVAEntity.Address.StreetLine1 = "789 Test Street";
                nonVAEntity.Address.StreetLine2 = "Suite XFD";
                nonVAEntity.Address.City = "Sacramento";
                nonVAEntity.Address.State = "CA";
                nonVAEntity.Address.ZipCode = "93939";
                nonVAEntity.TelephoneList.Add(new DsioTelephone() { Number = "(800)900-8000", Usage = DsioTelephone.WorkPhoneUsage });
                nonVAEntity.TelephoneList.Add(new DsioTelephone() { Number = "(888)777-6666", Usage = DsioTelephone.FaxUsage });

                nonVAEntity.PrimaryContact = "Extra Important";
                nonVAEntity.Inactive = "0";

                command.AddCommandArguments(nonVAEntity);

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);

                Assert.IsFalse(string.IsNullOrWhiteSpace(command.Ien));

                DsioGetExternalEntityCommand getCommand = new DsioGetExternalEntityCommand(broker);

                getCommand.AddCommandArguments(command.Ien, 1, 100);

                response = getCommand.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);
                Assert.IsNotNull(getCommand.NonVAEntities);
                Assert.AreEqual(1, getCommand.NonVAEntities.Count);

                DsioNonVAItem item = getCommand.NonVAEntities[0];

                Assert.IsTrue(nonVAEntity.EntityName.Equals(item.EntityName, StringComparison.InvariantCultureIgnoreCase));
                //Assert.AreEqual(nonVAEntity.EntityType, item.EntityType);
                Assert.AreEqual(nonVAEntity.Address.StreetLine1, item.Address.StreetLine1);
                Assert.AreEqual(nonVAEntity.Address.StreetLine2, item.Address.StreetLine2);
                Assert.AreEqual(nonVAEntity.Address.City, item.Address.City);
                Assert.AreEqual(nonVAEntity.Address.State, item.Address.State);
                Assert.AreEqual(nonVAEntity.Address.ZipCode, item.Address.ZipCode);
                
                Assert.IsNotNull(item.TelephoneList);
                Assert.AreEqual(nonVAEntity.TelephoneList.Count, item.TelephoneList.Count);

                Assert.AreEqual(nonVAEntity.TelephoneList[0].Usage, item.TelephoneList[0].Usage); 
                Assert.AreEqual(nonVAEntity.TelephoneList[0].Number, item.TelephoneList[0].Number);

                Assert.AreEqual(nonVAEntity.TelephoneList[1].Usage, item.TelephoneList[1].Usage);
                Assert.AreEqual(nonVAEntity.TelephoneList[1].Number, item.TelephoneList[1].Number);

                Assert.AreEqual(nonVAEntity.PrimaryContact, item.PrimaryContact);
                Assert.AreEqual(nonVAEntity.Inactive, item.Inactive); 
            }
        }

        private static Random random = new Random((int)DateTime.Now.Ticks);

        private string GetRandom()
        {
            StringBuilder sb = new StringBuilder();

            for (int i = 0; i < 10; i++)
            {
                char c = (char)((int)Math.Floor(26 * random.NextDouble() + 65));
                sb.Append(c); 
            }

            return sb.ToString(); 
        }
    }
}
