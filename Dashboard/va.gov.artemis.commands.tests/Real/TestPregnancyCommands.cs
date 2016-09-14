using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Commands.Dsio;
using VA.Gov.Artemis.Commands.Dsio.Pregnancy;
using System.Collections.Generic;
using VA.Gov.Artemis.Commands.Dsio.Base;

namespace VA.Gov.Artemis.Commands.Tests.Real
{
    [TestClass]
    public class TestPregnancyCommands: TestCommandsBase
    {
        [TestMethod]
        public void TestAndRetrievePerson()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                // *** First save the person ***

                DsioSavePersonCommand command = new DsioSavePersonCommand(broker);

                DsioLinkedPerson person = new DsioLinkedPerson()
                {
                    PatientDfn = "126", 
                    Name = "Third, Today"
                };

                command.AddCommandArguments(person);
                RpcResponse response = command.Execute();
                Assert.AreEqual(RpcResponseStatus.Success, response.Status);
                Assert.IsNotNull(command.Ien);

                // *** Then get by ien ***
                DsioGetPersonCommand getCommand = new DsioGetPersonCommand(broker);
                getCommand.AddCommandArguments("", command.Ien);
                response = getCommand.Execute();
                Assert.AreEqual(RpcResponseStatus.Success, response.Status);
                Assert.IsNotNull(getCommand.PersonList);
                Assert.IsTrue(getCommand.PersonList.Count > 0);
                Assert.AreEqual(person.Name, getCommand.PersonList[0].Name);
                Assert.AreEqual(person.PatientDfn, getCommand.PersonList[0].PatientDfn); 

                // *** Then get by patient ***
                getCommand.PersonList.Clear(); 
                getCommand.AddCommandArguments(person.PatientDfn, "");
                response = getCommand.Execute();
                Assert.AreEqual(RpcResponseStatus.Success, response.Status);
                Assert.IsNotNull(getCommand.PersonList);
                Assert.IsTrue(getCommand.PersonList.Count > 0);
                //Assert.AreEqual(person.Name, getCommand.PersonList[0].Name);
                //Assert.AreEqual(person.PatientDfn, getCommand.PersonList[0].PatientDfn); 

            }
        }

        [TestMethod]
        public void TestSavePerson()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioSavePersonCommand command = new DsioSavePersonCommand(broker);

                DsioLinkedPerson fof = new DsioLinkedPerson();

                fof.PatientDfn = "715"; 

                DsioAddress addr = new DsioAddress();
                addr.StreetLine1 = "1234 Five Street";
                addr.StreetLine2 = "#3";
                addr.City = "Seven";
                addr.State = "SC";
                addr.ZipCode = "90099";

                fof.Address = addr;

                List<DsioTelephone> telList = new List<DsioTelephone>();
                telList.Add(new DsioTelephone() { Number = "800-800-8000", Usage = DsioTelephone.HomePhoneUsage });
                telList.Add(new DsioTelephone() { Number = "900-900-9000", Usage = DsioTelephone.WorkPhoneUsage });
                telList.Add(new DsioTelephone() { Number = "700-700-7000", Usage = DsioTelephone.MobilePhoneUsage });

                fof.TelephoneList.AddRange(telList);

                string temp = Guid.NewGuid().ToString();

                // TODO: Need random name generator to test this successfully repeatedly...
                fof.Name = "Test,NamedOB";// +Guid.NewGuid().ToString();
                fof.DOB = DateTime.Now.Subtract(new TimeSpan(10000, 0, 0, 0)).ToShortDateString();
                fof.YearsSchool = "18"; 

                command.AddCommandArguments(fof);

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);

            }

        }

        [TestMethod]
        public void TestSaveBadPerson()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioSavePersonCommand command = new DsioSavePersonCommand(broker);

                DsioLinkedPerson fof = new DsioLinkedPerson(); 

                DsioAddress addr = new DsioAddress();
                addr.StreetLine1 = "1234 Five Street";
                addr.City = "Six";
                addr.State = "SC";
                addr.ZipCode = "90099";

                fof.Address = addr; 

                List<DsioTelephone> telList = new List<DsioTelephone>();
                telList.Add(new DsioTelephone() { Number = "800-800-8000", Usage = DsioTelephone.HomePhoneUsage });
                telList.Add(new DsioTelephone() { Number = "900-900-9000", Usage = DsioTelephone.WorkPhoneUsage });
                telList.Add(new DsioTelephone() { Number = "700-700-7000", Usage = DsioTelephone.MobilePhoneUsage });

                fof.TelephoneList.AddRange(telList);

                command.AddCommandArguments(fof);
                
                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Fail, response.Status);

            }
        }

        //[TestMethod]
        //public void TestSaveSpouse()
        //{
        //    using (RpcBroker broker = this.GetConnectedBroker())
        //    {
        //        this.SignonToBroker(broker, 0);

        //        DsioSavePersonCommand command = new DsioSavePersonCommand(broker);

        //        DsioLinkedPerson fof = new DsioLinkedPerson();

        //        fof.PatientDfn = "339";

        //        fof.Name = "SPOUSE";

        //        command.AddCommandArguments(fof);

        //        RpcResponse response = command.Execute();

        //        Assert.AreEqual(RpcResponseStatus.Success, response.Status);
        //    }
        //}
        
        [TestMethod]
        public void TestGetPerson()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioGetPersonCommand command = new DsioGetPersonCommand(broker);

                command.AddCommandArguments("715", "1");

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);

            }

        }

        [TestMethod]
        public void TestGetPersonNotFound()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioGetPersonCommand command = new DsioGetPersonCommand(broker);

                command.AddCommandArguments("715", "98");

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);

            }

        }
        [TestMethod]
        public void TestGetSpouse()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioGetPersonCommand command = new DsioGetPersonCommand(broker);

                command.AddCommandArguments("740", "SPOUSE");

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);

            }

        }

        [TestMethod]
        public void TestGetPersonsList()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioGetPersonCommand command = new DsioGetPersonCommand(broker);

                command.AddCommandArguments("715", "");

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);

            }

        }

        [TestMethod]
        public void TestSavePregnancy()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioSavePregDetailsCommand command = new DsioSavePregDetailsCommand(broker);

                DsioPregnancy preg = new DsioPregnancy();
                //preg.PatientDfn = "704";
                //preg.PatientDfn = "100007"; 
                //preg.PatientDfn = "763"; 
                preg.PatientDfn = "126"; 
                preg.Ien = "";
                preg.RecordType = "HISTORICAL";
                //preg.FatherOfFetusIen = "U";
                preg.EDD = "";
                //preg.StartDate = "09/13/2014";
                //preg.StartDate = "";
                preg.EndDate = "";
                preg.ObstetricianIen = "";
                preg.LDFacilityIen = "";
                preg.HighRisk = "1";
                preg.HighRiskDetails = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum";

                preg.GestationalAgeAtDelivery = "145";
                preg.LengthOfLabor = "12";
                preg.TypeOfDelivery = "Caesarean";
                preg.Anesthesia = "Epidural";
                preg.PretermDelivery = "YES";
                preg.Outcome = "P"; 
                
                command.AddCommandArguments(preg, false);

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);

            }
        }

        [TestMethod]
        public void TestGetPregnancies()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioGetPregDetailsCommand command = new DsioGetPregDetailsCommand(broker);

                //command.AddCommandArguments("715", "7");
                //command.AddCommandArguments("10", "");
                //command.AddCommandArguments("100010", "");
                //command.AddCommandArguments("144", "");
                //command.AddCommandArguments("100007", "");
                //command.AddCommandArguments("766", "41");
                //command.AddCommandArguments("367", "58");
                //command.AddCommandArguments("643", "68");
                command.AddCommandArguments("126", "");

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);

            }

        }

        [TestMethod]
        public void TestGetPregnanciesNotFound()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioGetPregDetailsCommand command = new DsioGetPregDetailsCommand(broker);

                command.AddCommandArguments("100070", "");

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);
                Assert.IsNull(command.PregnancyList); 

            }

        }

        [TestMethod]
        public void TestGetPregnanciesBadPatient()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioGetPregDetailsCommand command = new DsioGetPregDetailsCommand(broker);

                command.AddCommandArguments("100099", "");

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);
                Assert.IsNull(command.PregnancyList);


            }

        }

        [TestMethod]
        public void TestCreateAndRetrieveHistoricalPregnancy()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioSavePregDetailsCommand createCommand = new DsioSavePregDetailsCommand(broker);

                DsioPregnancy preg = new DsioPregnancy();
                preg.PatientDfn = "126";
                preg.Ien = "";
                preg.RecordType = "HISTORICAL";
                preg.FatherOfFetusIen = "U";
                preg.EDD = "";
                preg.StartDate = "";
                preg.EndDate = "05/05/2011";
                preg.ObstetricianIen = "";
                preg.LDFacilityIen = "";

                preg.GestationalAgeAtDelivery = "145";
                preg.LengthOfLabor = "12";
                preg.TypeOfDelivery = "Caesarean";
                preg.Anesthesia = "Epidural";
                preg.PretermDelivery = "YES";
                preg.Outcome = "PretermDelivery";

                preg.Comment = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
                preg.HighRisk = "1";

                preg.HighRiskDetails = "eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";

                createCommand.AddCommandArguments(preg, false);

                RpcResponse response = createCommand.Execute();

                Assert.IsNotNull(response); 
                Assert.AreEqual(RpcResponseStatus.Success, response.Status);
                Assert.IsFalse(string.IsNullOrWhiteSpace(createCommand.Ien)); 

                string ien = createCommand.Ien;

                DsioGetPregDetailsCommand getCommand = new DsioGetPregDetailsCommand(broker);

                getCommand.AddCommandArguments("126", ien);

                response = getCommand.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);
                Assert.IsNotNull(getCommand.PregnancyList); 
                Assert.IsTrue(getCommand.PregnancyList.Count > 0); 
                Assert.IsTrue(getCommand.PregnancyList.Count == 1); 

                DsioPregnancy returnedPreg = getCommand.PregnancyList[0];

                Assert.AreEqual(preg.PatientDfn, returnedPreg.PatientDfn);
                Assert.AreNotEqual(preg.Ien, returnedPreg.Ien);
                Assert.AreEqual(preg.RecordType, returnedPreg.RecordType);
                Assert.IsTrue(preg.FatherOfFetusIen.Equals(returnedPreg.FatherOfFetusIen, StringComparison.InvariantCultureIgnoreCase));
                Assert.AreEqual(preg.EDD, returnedPreg.EDD);
                Assert.AreEqual(preg.StartDate, returnedPreg.StartDate);
                Assert.AreEqual(preg.EndDate, returnedPreg.EndDate);

                Assert.AreEqual(preg.GestationalAgeAtDelivery, returnedPreg.GestationalAgeAtDelivery);
                Assert.AreEqual(preg.LengthOfLabor, returnedPreg.LengthOfLabor);                
                Assert.AreEqual(preg.Anesthesia, returnedPreg.Anesthesia);
                Assert.AreEqual(preg.Comment, returnedPreg.Comment);
                Assert.AreEqual(preg.HighRiskDetails, returnedPreg.HighRiskDetails); 
                
                Assert.AreEqual(preg.HighRisk, returnedPreg.HighRisk); 
                Assert.AreEqual(preg.TypeOfDelivery, returnedPreg.TypeOfDelivery);
                Assert.AreEqual(preg.PretermDelivery, returnedPreg.PretermDelivery);
                Assert.AreEqual(preg.Outcome, returnedPreg.Outcome);
            }

        }

    }
}
