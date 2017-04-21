// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.CDA.Common;
using VA.Gov.Artemis.CDA.ValueSets;
using VA.Gov.Artemis.Commands.Dsio.Observation;
using VA.Gov.Artemis.Commands.Dsio.Patient;
using VA.Gov.Artemis.Commands.Dsio.Pregnancy;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.Commands.Tests.Real
{
    [TestClass]
    public class TestObservationCommands: TestCommandsBase
    {
        [TestMethod]
        public void TestCreateObservation()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                this.CreateObservation(broker);

            }
        }

        private string CreateObservation(IRpcBroker broker)
        {
            DsioSaveObservationCommand command = new DsioSaveObservationCommand(broker);

            // Missing LOINC code problem...
            DsioObservation obs = new DsioObservation();
            obs.PatientDfn = TestConfiguration.DefaultPatientDfn;
            obs.Ien = "";
            obs.ExamDate = DateTime.Now.ToString("MM/dd/yyyy@hh:mm:ss");
            obs.PregnancyIen = "";
            obs.BabyIen = "";
            obs.Category = "Pregnancy History";
            obs.Code.CodeSystem = DsioObservation.LoincCodeSystem;
            obs.Code.Code = "57062-2";
            obs.Code.DisplayName = "Still Births";
            obs.Value = "3";

            command.AddCommandArguments(obs);

            RpcResponse response = command.Execute();

            Assert.AreEqual(RpcResponseStatus.Success, response.Status);

            return command.Ien; 
        }

        [TestMethod]
        public void TestGravidaParaSummary()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioSaveObservationCommand command = new DsioSaveObservationCommand(broker);

                DsioObservation obs = new DsioObservation();
                obs.PatientDfn = TestConfiguration.DefaultPatientDfn;
                obs.Ien = "";
                obs.ExamDate = DateTime.Now.ToString("MM/dd/yyyy@hh:mm:ss");
                obs.PregnancyIen = "";
                obs.BabyIen = "";
                obs.Category = "Pregnancy History";
                obs.Code.CodeSystem = "1.2.3.4.5.6.7";
                obs.Code.CodeSystemName = "Code System Name Here";
                obs.Code.Code = "GravidaParaSummary";
                obs.Code.DisplayName = "Gravida & Para Summary";
                obs.Value = "G2 P2002";
                obs.Negation = "True";
                obs.EffectiveTimeEnd = DateTime.Now.ToString("MM/dd/yyyy@hh:mm:ss");
                obs.EffectiveTimeStart = DateTime.Now.ToString("MM/dd/yyyy@hh:mm:ss");
                obs.Relationship = "Relationship";
                obs.Unit = "Units";
                obs.ValueType = "Value Type";
                obs.ValueCode.CodeSystem = "Value Code System";
                obs.ValueCode.CodeSystemName = "Value Code System Name";
                obs.ValueCode.Code = "Value Code";
                obs.ValueCode.DisplayName = "Value Display Name";

                command.AddCommandArguments(obs);

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);
                Assert.IsFalse(string.IsNullOrWhiteSpace(command.Ien));

                DsioGetObservationsCommand getCommand = new DsioGetObservationsCommand(broker);

                getCommand.AddCommandArguments(obs.PatientDfn, command.Ien, "", "", "", "", "", "", 1, 1000);

                response = getCommand.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);
                Assert.IsNotNull(getCommand.ObservationsList);
                Assert.IsTrue(getCommand.ObservationsList.Count == 1);

                DsioObservation retrievedObservation = getCommand.ObservationsList[0];

                Assert.IsTrue(retrievedObservation.Category.Equals(obs.Category, StringComparison.CurrentCultureIgnoreCase));
                Assert.AreEqual(retrievedObservation.Code.CodeSystem, obs.Code.CodeSystem);
                Assert.AreEqual(retrievedObservation.Code.Code, obs.Code.Code);
                Assert.AreEqual(retrievedObservation.Code.DisplayName, obs.Code.DisplayName);
                Assert.AreEqual(retrievedObservation.Value, obs.Value);                 

            }
        }

        [TestMethod]
        public void TestGravidaParaSummary2()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioSaveObservationCommand command = new DsioSaveObservationCommand(broker);

                DsioObservation obs = new DsioObservation();
                obs.PatientDfn = TestConfiguration.DefaultPatientDfn;
                obs.Ien = "";
                obs.ExamDate = DateTime.Now.ToString("MM/dd/yyyy@hh:mm:ss");
                obs.PregnancyIen = "";
                obs.BabyIen = "";
                obs.Category = "Pregnancy History";
                obs.Code.CodeSystemName = "NONE";
                obs.Code.Code = "GravidaParaSummary";
                obs.Code.DisplayName = "Gravida & Para Summary";
                obs.Value = "G4 P3104";

                command.AddCommandArguments(obs);

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);
                Assert.IsFalse(string.IsNullOrWhiteSpace(command.Ien));

                DsioGetPatientInformationCommand patCommand = new DsioGetPatientInformationCommand(broker);

                patCommand.AddCommandArguments(obs.PatientDfn);

                response = patCommand.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);
                Assert.AreEqual(obs.Value, patCommand.Patient.GravidaPara); 

            }
        }

        [TestMethod]
        public void TestGetObservations_All()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioGetObservationsCommand command = new DsioGetObservationsCommand(broker);

                // Get all for patient...
                command.AddCommandArguments(TestConfiguration.DefaultPatientDfn, "", "", "", "", "", "", "", -1, -1);

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);

            }
        }

        [TestMethod]
        public void TestGetObservationByIen()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioGetObservationsCommand command = new DsioGetObservationsCommand(broker);

                string ien = this.CreateObservation(broker); 

                // Get all for patient...
                command.AddCommandArguments(TestConfiguration.DefaultPatientDfn, ien, "", "", "", "", "", "", -1, -1);

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);

            }
        }

        [TestMethod]
        public void TestGetObservations_ByCategory()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioGetObservationsCommand command = new DsioGetObservationsCommand(broker);

                // Get category...
                command.AddCommandArguments(TestConfiguration.DefaultPatientDfn, "", "", "", "", "", "", "Contact", -1, -1);

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);

            }
        }

        [TestMethod]
        public void TestGetObservationsNone()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioGetObservationsCommand command = new DsioGetObservationsCommand(broker);

                // Get all for patient...
                command.AddCommandArguments(TestConfiguration.DefaultPatientDfn, "", "", "", "", "", "", "", 1, 1000);

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);

            }
        }

        [TestMethod]
        public void TestGetObservationsUnknownCategory()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioGetObservationsCommand command = new DsioGetObservationsCommand(broker);

                // Get all for patient...
                command.AddCommandArguments(TestConfiguration.DefaultPatientDfn, "", "", "", "", "", "", "NONEXISTENT", 1, 1000);

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);

            }
        }

        [TestMethod]
        public void TestCreateLactatingObservations()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                // *** Test values ***
                //string patDfn = "100037";
                //string patDfn = "751";
                bool origObsValue = false;
                bool newObsValue = true; 

                DsioSaveObservationCommand command = new DsioSaveObservationCommand(broker);
                
                DsioObservation obs = new DsioObservation();
                obs.PatientDfn = TestConfiguration.DefaultPatientDfn;
                obs.Ien = "";
                obs.ExamDate = DateTime.Now.ToString("MM/dd/yyyy@hh:mm:ss");
                obs.PregnancyIen = "";
                obs.BabyIen = "";
                obs.Category = "Postpartum";
                obs.Code.CodeSystem = DsioObservation.OtherCodeSystem;
                obs.Code.Code = "Lactating";
                obs.Code.DisplayName = "The patient is currently lactating";
                obs.Value = origObsValue.ToString();

                command.AddCommandArguments(obs);

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);

                DsioGetPatientInformationCommand patCommand = new DsioGetPatientInformationCommand(broker);

                patCommand.AddCommandArguments(TestConfiguration.DefaultPatientDfn);

                response = patCommand.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);
                Assert.AreEqual(origObsValue, patCommand.Patient.Lactating == "YES");

                obs.Value = newObsValue.ToString();

                command.AddCommandArguments(obs);

                response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);

                patCommand.AddCommandArguments(TestConfiguration.DefaultPatientDfn);

                response = patCommand.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);
                Assert.AreEqual(newObsValue, patCommand.Patient.Lactating == "YES");

            }
        }

        [TestMethod]
        public void TestNextContactDue()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DateTime nextContact = DateTime.Now.AddDays(10);

                // *** Create the observation ***
                DsioObservation obs = new DsioObservation();
                obs.PatientDfn = TestConfiguration.DefaultPatientDfn;
                obs.Ien = "";
                obs.ExamDate = DateTime.Now.ToString(VistaDates.VistADateFormatFour);
                obs.PregnancyIen = "";
                obs.BabyIen = "";
                obs.Category = "Contact";
                obs.Code.CodeSystem = DsioObservation.OtherCodeSystem;
                obs.Code.Code = "NextContactDate";
                obs.Code.DisplayName = string.Format("The patient is due to be contacted on {0}", nextContact.ToString(VistaDates.VistADateOnlyFormat));
                obs.Value = nextContact.ToString(VistaDates.VistADateOnlyFormat);

                DsioSaveObservationCommand command = new DsioSaveObservationCommand(broker);

                command.AddCommandArguments(obs);

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);

                DsioGetPatientInformationCommand patCommand = new DsioGetPatientInformationCommand(broker);

                patCommand.AddCommandArguments(TestConfiguration.DefaultPatientDfn);

                response = patCommand.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);
                Assert.AreEqual(obs.Value, patCommand.Patient.NextContactDue); 
            }
        }

        [TestMethod]
        public void TestLastContactDate()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DateTime lastContact = DateTime.Now.AddDays(-10);

                // *** Create the observation ***
                DsioObservation obs = new DsioObservation();
                obs.PatientDfn = TestConfiguration.DefaultPatientDfn;
                obs.Ien = "";
                obs.ExamDate = DateTime.Now.ToString(VistaDates.VistADateFormatFour);
                obs.PregnancyIen = "";
                obs.BabyIen = "";
                obs.Category = "Contact";
                obs.Code.CodeSystem = DsioObservation.OtherCodeSystem;
                obs.Code.Code = "LastContactDate";
                obs.Code.DisplayName = string.Format("The last contact with the patient occurred on {0}", lastContact.ToString(VistaDates.VistADateOnlyFormat));
                obs.Value = lastContact.ToString(VistaDates.VistADateOnlyFormat);

                DsioSaveObservationCommand command = new DsioSaveObservationCommand(broker);

                command.AddCommandArguments(obs);

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);

                DsioGetPatientInformationCommand patCommand = new DsioGetPatientInformationCommand(broker);

                patCommand.AddCommandArguments(TestConfiguration.DefaultPatientDfn);

                response = patCommand.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);
                Assert.AreEqual(obs.Value, patCommand.Patient.LastContactDate); 
 
            }
        }

        [TestMethod]
        public void TestNextChecklistDue()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DateTime nextChecklist = DateTime.Now.AddDays(5);

                // *** Create the observation ***
                DsioObservation obs = new DsioObservation();
                obs.PatientDfn = TestConfiguration.DefaultPatientDfn;
                obs.Ien = "";
                obs.ExamDate = DateTime.Now.ToString(VistaDates.VistADateFormatFour);
                obs.PregnancyIen = "";
                obs.BabyIen = "";
                obs.Category = "Contact";
                obs.Code.CodeSystem = DsioObservation.OtherCodeSystem;
                obs.Code.Code = "NextChecklistDate";
                obs.Code.DisplayName = string.Format("The next checklist item is due on {0}", nextChecklist.ToString(VistaDates.VistADateOnlyFormat));
                obs.Value = nextChecklist.ToString(VistaDates.VistADateOnlyFormat);
                
                DsioSaveObservationCommand command = new DsioSaveObservationCommand(broker);

                command.AddCommandArguments(obs);

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);

                DsioGetPatientInformationCommand patCommand = new DsioGetPatientInformationCommand(broker);

                patCommand.AddCommandArguments(TestConfiguration.DefaultPatientDfn);

                response = patCommand.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);
                Assert.AreEqual(obs.Value, patCommand.Patient.NextChecklistDue);

            }
        }

        [TestMethod]
        public void TestBabyObservations()
        {
            //string patDfn = "126";

            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                // 1. Does this patient have any pregnancies to work with? 

                DsioGetPregDetailsCommand getPregCommand = new DsioGetPregDetailsCommand(broker);
                getPregCommand.AddCommandArguments(TestConfiguration.DefaultPatientDfn, "");
                RpcResponse response = getPregCommand.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);

                DsioPregnancy preg = null;

                if (getPregCommand.PregnancyList != null)
                    if (getPregCommand.PregnancyList.Count > 0)
                        preg = getPregCommand.PregnancyList[0];

                // 2. If not, create one 
                bool saveIt = false;
                bool addBaby = false;
                if (preg == null)
                {
                    preg = new DsioPregnancy()
                    {
                        PatientDfn = TestConfiguration.DefaultPatientDfn,
                        RecordType = "HISTORICAL",
                        EDD = "12/12/2015"
                    };

                    preg.Babies.Add(new DsioBaby() { Number = "1" });
                    saveIt = true;
                }
                else if (preg.Babies.Count == 0)
                {
                    addBaby = true;
                    saveIt = true; 
                }

                if (saveIt)
                {
                    DsioSavePregDetailsCommand savePregCommand = new DsioSavePregDetailsCommand(broker);

                    savePregCommand.AddCommandArguments(preg, addBaby);

                    response = savePregCommand.Execute();

                    Assert.AreEqual(RpcResponseStatus.Success, response.Status);

                    getPregCommand = new DsioGetPregDetailsCommand(broker);

                    getPregCommand.AddCommandArguments(TestConfiguration.DefaultPatientDfn, savePregCommand.Ien);

                    response = getPregCommand.Execute();

                    Assert.AreEqual(RpcResponseStatus.Success, response.Status);

                    if (getPregCommand.PregnancyList != null)
                        if (getPregCommand.PregnancyList.Count > 0)
                            preg = getPregCommand.PregnancyList[0];

                }

                Assert.IsNotNull(preg);
                Assert.IsNotNull(preg.Babies);
                Assert.IsTrue(preg.Babies.Count > 0);
                Assert.IsFalse(String.IsNullOrWhiteSpace(preg.Babies[0].Ien));

                DsioSaveObservationCommand saveCommand = new DsioSaveObservationCommand(broker);

                DsioObservation testObservation = new DsioObservation()
                {
                    PatientDfn = TestConfiguration.DefaultPatientDfn,
                    PregnancyIen = preg.Ien,
                    BabyIen = preg.Babies[0].Ien,
                    Category = "BabyDetails",
                    Code = new DsioCode() { Code = "BabySomething", CodeSystem = "1.2.3.4", CodeSystemName="Made Up Code System Name", DisplayName = "This is a baby observation" },
                    Value = "Test Val",
                    ExamDate = DateTime.Now.ToString(VistaDates.VistADateFormatFour),
                };

                saveCommand.AddCommandArguments(testObservation);

                response = saveCommand.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);
                Assert.IsFalse(string.IsNullOrWhiteSpace(saveCommand.Ien));

                DsioGetObservationsCommand getCommand = new DsioGetObservationsCommand(broker);

                getCommand.AddCommandArguments("", saveCommand.Ien, "", "", "", "", "", "", 0, 0);
                //getCommand.AddCommandArguments(testObservation.PatientDfn, "", testObservation.PregnancyIen, testObservation.BabyIen, "", "", "", 0, 0);

                response = getCommand.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);
                Assert.IsNotNull(getCommand.ObservationsList);
                Assert.IsTrue(getCommand.ObservationsList.Count > 0);

                DsioObservation retrievedObs = getCommand.ObservationsList[0];

                Assert.AreEqual(saveCommand.Ien, retrievedObs.Ien); 
                Assert.AreEqual(testObservation.PatientDfn, retrievedObs.PatientDfn);
                Assert.AreEqual(testObservation.PregnancyIen, retrievedObs.PregnancyIen);
                Assert.AreEqual(testObservation.BabyIen, retrievedObs.BabyIen);
                Assert.IsTrue(testObservation.Category.Equals(retrievedObs.Category, StringComparison.CurrentCultureIgnoreCase));
                Assert.AreEqual(testObservation.Code.Code, retrievedObs.Code.Code);
                Assert.AreEqual(testObservation.Code.CodeSystem, retrievedObs.Code.CodeSystem);
                //Assert.AreEqual(testObservation.Code.CodeSystemName, retrievedObs.Code.CodeSystemName);
                Assert.IsTrue(testObservation.Code.CodeSystemName.Equals(retrievedObs.Code.CodeSystemName, StringComparison.CurrentCultureIgnoreCase));
                Assert.AreEqual(testObservation.Code.DisplayName, retrievedObs.Code.DisplayName);
                Assert.AreEqual(testObservation.Value, retrievedObs.Value);
                Assert.AreEqual(testObservation.ExamDate, retrievedObs.ExamDate); 
                
            }
        }

        [TestMethod]
        public void TestCreateChiefComplaint()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioSaveObservationCommand saveCommand = new DsioSaveObservationCommand(broker);

                DsioObservation testObservation = new DsioObservation()
                {
                    PatientDfn = TestConfiguration.DefaultPatientDfn,
                    PregnancyIen = "",
                    BabyIen = "",
                    Category = "Chief Complaint",
                    Code = new DsioCode() { CodeSystem = "2.16.840.1.113883.6.1", Code = "10154-3", DisplayName = "Chief Complaint", CodeSystemName = "LOINC" }, 
                    ExamDate = DateTime.Now.ToString(VistaDates.VistADateFormatFour),
                    Narrative = @"This is a longer description 
of the patient's chief complaint
that goes for more than one line"
                };

                saveCommand.AddCommandArguments(testObservation);

                RpcResponse response = saveCommand.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);
                Assert.IsFalse(string.IsNullOrWhiteSpace(saveCommand.Ien));

                DsioGetObservationsCommand getCommand = new DsioGetObservationsCommand(broker);

                getCommand.AddCommandArguments(testObservation.PatientDfn, "", "", "", "", "", "", "Chief Complaint", -1, -1);

                response = getCommand.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);
                Assert.IsTrue(getCommand.ObservationsList.Count > 0); 


            }

        }

        [TestMethod]
        public void TestCreatePresentIllnessObs()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioSaveObservationCommand saveCommand = new DsioSaveObservationCommand(broker);

                DsioObservation testObservation = new DsioObservation()
                {
                    PatientDfn = TestConfiguration.DefaultPatientDfn,
                    PregnancyIen = "",
                    BabyIen = "",
                    Category = "History of Present Illness",
                    Code = new DsioCode()
                    {
                        CodeSystem = "LOINC",
                        CodeSystemName = "2.1.2.1.2.1.2.1", 
                        Code = "10164-2",
                        DisplayName = "History of Present Illness"
                    },
                    ExamDate = DateTime.Now.ToString(VistaDates.VistADateFormatFour),
                    //Value = "Nauseous in the AM"
                    Narrative = "This is a test"
                };
                
                saveCommand.AddCommandArguments(testObservation);

                RpcResponse response = saveCommand.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);
                Assert.IsFalse(string.IsNullOrWhiteSpace(saveCommand.Ien));

                DsioGetObservationsCommand getCommand = new DsioGetObservationsCommand(broker);

                //getCommand.AddCommandArguments("", saveCommand.Ien, "", "", "", "", "", 0, 0);
                getCommand.AddCommandArguments(testObservation.PatientDfn, "", "", "", "", "", "", "History of Present Illness", -1, -1);

                response = getCommand.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);
            }

        }

        [TestMethod]
        public void TestCreatePastIllnessNarrative()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioSaveObservationCommand saveCommand = new DsioSaveObservationCommand(broker);

                DsioObservation testObservation = new DsioObservation()
                {
                    PatientDfn = TestConfiguration.DefaultPatientDfn,
                    PregnancyIen = "",
                    BabyIen = "",
                    Category = "History of Past Illness",
                    Code = new DsioCode() { CodeSystemName = "LOINC", Code = "11348-0", DisplayName = "History of Past Illness", CodeSystem="2.16.840.1.113883.6.1" }, 
                    ExamDate = DateTime.Now.ToString(VistaDates.VistADateFormatFour),
                    Narrative = @"In 2011, the patient experienced a minor stroke, 
which caused temporary paralysis on her left side. 
She was monitored in hospital for three weeks and recovered. 
She has been taking warfarin since then and is expected 
continue on with with close monitoring.
She has had type II diabetes, poorly controlled for many years. 
Since the diagnosis, her kidney functions are compromised and she 
is predisposed to developing peripheral neuropathy. occlusion.
Two weeks prior to this current hospital admission, she was also 
diagnosed with hypercholesterolemia. She is currently taking 
Lipitor to manage this."
                };

                saveCommand.AddCommandArguments(testObservation);

                RpcResponse response = saveCommand.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);
                Assert.IsFalse(string.IsNullOrWhiteSpace(saveCommand.Ien));

                DsioGetObservationsCommand getCommand = new DsioGetObservationsCommand(broker);

                //getCommand.AddCommandArguments("", saveCommand.Ien, "", "", "", "", "", 0, 0);
                getCommand.AddCommandArguments(testObservation.PatientDfn, "", "", "", "", "", "", "History of Past Illness", -1, -1);

                response = getCommand.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);
            }
        }

        [TestMethod]
        public void TestHistoryOfInfection()
        {
            DsioObservation testObservation = new DsioObservation()
            {
                PatientDfn = TestConfiguration.DefaultPatientDfn,
                PregnancyIen = "",
                BabyIen = "",
                Category = "History of Infection",
                ExamDate = DateTime.Now.ToString(VistaDates.VistADateFormatFour),                
                Code = new DsioCode() { CodeSystemName = "LOINC", Code = "56838-6", DisplayName = "History of Infectious Disease", CodeSystem="2.16.840.1.113883.6.1"  },
                Narrative = @"In 2011, the patient was exposed to TB,
which caused temporary paralysis on her left side. 
She was monitored in hospital for three weeks and 
recovered. She has been taking warfarin since then 
and is expected continue on with with close monitoring."
            };

            TestCreateObservation(testObservation); 
        }

        [TestMethod]
        public void TestCodedHistoryOfInfection()
        {
            DsioObservation testObservation = new DsioObservation()
            {
                PatientDfn = TestConfiguration.DefaultPatientDfn,
                PregnancyIen = "",
                BabyIen = "",
                Category = "History of Infection",
                ExamDate = DateTime.Now.ToString(VistaDates.VistADateFormatFour),
                Value = "True",
                Code = new DsioCode() { CodeSystemName = "SNOMED-CT", Code = "170464005", DisplayName = "Live with someone with TB or exposed to TB" }
            };

            TestCreateObservation(testObservation);

            testObservation.Code.Code = "402888002";
            testObservation.Code.DisplayName = "History of Genital Herpes";

            TestCreateObservation(testObservation);

            testObservation.Code.Code = "235871004";
            testObservation.Code.DisplayName = "Hepatitis B";
            testObservation.Value = "False"; 

            TestCreateObservation(testObservation);

        }

        private void TestCreateObservation(DsioObservation testObservation)
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioSaveObservationCommand saveCommand = new DsioSaveObservationCommand(broker);

                saveCommand.AddCommandArguments(testObservation);

                RpcResponse response = saveCommand.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);
                Assert.IsFalse(string.IsNullOrWhiteSpace(saveCommand.Ien));

                DsioGetObservationsCommand getCommand = new DsioGetObservationsCommand(broker);

                getCommand.AddCommandArguments(testObservation.PatientDfn, "", "", "", "", "", "", testObservation.Category, -1, -1);

                response = getCommand.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);
            }
        }
        [TestMethod]
        public void TestCreatePastIllnessObservations()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioSaveObservationCommand saveCommand = new DsioSaveObservationCommand(broker);

                DsioObservation testObservation = new DsioObservation()
                {
                    PatientDfn = TestConfiguration.DefaultPatientDfn,
                    PregnancyIen = "",
                    BabyIen = "",
                    Category = "History of Past Illness",
                    ExamDate = DateTime.Now.ToString(VistaDates.VistADateFormatFour),
                    Value = "True",
                    Code = new DsioCode() { CodeSystem = "2.16.840.1.113883.6.96", CodeSystemName = "SNOMED-CT", Code = "440047008", DisplayName = "Diabetes" }
                };

                saveCommand.AddCommandArguments(testObservation);

                RpcResponse response = saveCommand.Execute();

                testObservation = new DsioObservation()
                {
                    PatientDfn = TestConfiguration.DefaultPatientDfn,
                    PregnancyIen = "",
                    BabyIen = "",
                    Category = "History of Past Illness",
                    ExamDate = DateTime.Now.ToString(VistaDates.VistADateFormatFour),
                    Value = "True",
                    Code = new DsioCode() { CodeSystem = "2.16.840.1.113883.6.96", CodeSystemName = "SNOMED-CT", Code = "38341003", DisplayName = "Hypertension" }
                };

                saveCommand.AddCommandArguments(testObservation);

                response = saveCommand.Execute();

                testObservation = new DsioObservation()
                {
                    PatientDfn = TestConfiguration.DefaultPatientDfn,
                    PregnancyIen = "",
                    BabyIen = "",
                    Category = "History of Past Illness",
                    ExamDate = DateTime.Now.ToString(VistaDates.VistADateFormatFour),
                    Value = "False",
                    Code = new DsioCode() { CodeSystem = "2.16.840.1.113883.6.96", CodeSystemName = "SNOMED-CT", Code = "56265001", DisplayName = "Heart Disease" }
                };

                saveCommand.AddCommandArguments(testObservation);

                response = saveCommand.Execute();
                
                Assert.AreEqual(RpcResponseStatus.Success, response.Status);
                Assert.IsFalse(string.IsNullOrWhiteSpace(saveCommand.Ien));

                DsioGetObservationsCommand getCommand = new DsioGetObservationsCommand(broker);

                //getCommand.AddCommandArguments("", saveCommand.Ien, "", "", "", "", "", 0, 0);
                getCommand.AddCommandArguments(testObservation.PatientDfn, "", "", "", "", "", "", "History of Past Illness", -1, -1);

                response = getCommand.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);
            }
        }

        [TestMethod]
        public void TestSocialHistory()
        {
            DsioObservation testObservation = new DsioObservation()
            {
                PatientDfn = TestConfiguration.DefaultPatientDfn,
                PregnancyIen = "",
                BabyNum = "",
                Category = "Social History: Smoking",
                Code = new DsioCode(){ Code = "229819007",CodeSystemName = "SNOMED-CT", DisplayName = "Smoking"},
                ExamDate = DateTime.Now.ToString(VistaDates.VistADateFormatFour),
                Value = "2",
                Unit = "{packs}/day"
            };

            TestCreateObservation(testObservation);

            testObservation.Category = "Social History: Exercise";
            //testObservation.Code = "256235009";
            testObservation.Code = new DsioCode() { Code = "256235009", CodeSystemName = "SNOMED-CT", DisplayName = "Exercise" };
            testObservation.ExamDate = DateTime.Now.ToString(VistaDates.VistADateFormatFour);
            testObservation.Value = "4";
            testObservation.Unit = "{times}/wk";

            TestCreateObservation(testObservation);

            testObservation.Category = "Social History: Alcohol";
            //testObservation.Code = "160573003";
            testObservation.Code = new DsioCode() { Code = "160573003", CodeSystemName = "SNOMED-CT", DisplayName = "ETOH (Alcohol)" };
            testObservation.ExamDate = DateTime.Now.ToString(VistaDates.VistADateFormatFour);
            testObservation.Value = "10";
            testObservation.Unit = "{drinks}/wk"; 

            TestCreateObservation(testObservation);

            testObservation.Category = "Social History: Diet";
            //testObservation.Code = "230122008";
            testObservation.Code = new DsioCode() { Code = "230122008", CodeSystemName = "SNOMED-CT", DisplayName = "Calcium Intake" };
            testObservation.ExamDate = DateTime.Now.ToString(VistaDates.VistADateFormatFour);
            testObservation.Value = "Drinking Milk Daily";

            TestCreateObservation(testObservation);

            testObservation.Category = "Social History: Drug Use"; // 363908000
            //testObservation.Code = "398705004";
            testObservation.Code = new DsioCode() { Code = "398705004", CodeSystemName = "SNOMED-CT", DisplayName = "Cannibis" };
            testObservation.ExamDate = DateTime.Now.ToString(VistaDates.VistADateFormatFour);
            testObservation.Value = "True";

            TestCreateObservation(testObservation);

            testObservation.Category = "Social History: Narrative"; // 363908000
            //testObservation.Code = "29762-2";
            //testObservation.CodeSystem = "LOINC";
            testObservation.Code = new DsioCode() { Code = "29762-2", CodeSystemName = "LOINC", DisplayName = "Social History" };
            testObservation.ExamDate = DateTime.Now.ToString(VistaDates.VistADateFormatFour);
            testObservation.Value = "The patient smokes two packs a day, exercises 4 times a week, and drinks 2 alcholic beverages per week.";

            TestCreateObservation(testObservation);

        }

        [TestMethod]
        public void TestFamilyMedicalHistory()
        {
            DsioObservation testObservation = new DsioObservation()
            {
                PatientDfn = TestConfiguration.DefaultPatientDfn,
                PregnancyIen = "",
                BabyNum = "",
                Category = "Family Medical History",
                Code = new DsioCode() { CodeSystemName = "SNOMED-CT", DisplayName = "Arthritis", Code = "3723001"},
                ExamDate = DateTime.Now.ToString(VistaDates.VistADateFormatFour),
                Value = "True",
                Relationship = "MTH"
            };

            TestCreateObservation(testObservation);

            testObservation.Code.Code = "195967001";
            testObservation.ExamDate = DateTime.Now.ToString(VistaDates.VistADateFormatFour);
            testObservation.Code.DisplayName = "Asthma";

            TestCreateObservation(testObservation);

            testObservation.Code.Code = "35489007";
            testObservation.ExamDate = DateTime.Now.ToString(VistaDates.VistADateFormatFour);
            testObservation.Code.DisplayName = "Depressive disorder";

            TestCreateObservation(testObservation);

            testObservation.Code.Code = "84757009";
            testObservation.ExamDate = DateTime.Now.ToString(VistaDates.VistADateFormatFour);
            testObservation.Code.DisplayName = "Epilepsy";
            testObservation.Relationship = "FTH";

            TestCreateObservation(testObservation);

            testObservation.Code.Code = "422504002";
            testObservation.ExamDate = DateTime.Now.ToString(VistaDates.VistADateFormatFour);
            testObservation.Code.DisplayName = "Ischemic Stroke";

            TestCreateObservation(testObservation);

            testObservation.Code.Code = "73211009";
            testObservation.ExamDate = DateTime.Now.ToString(VistaDates.VistADateFormatFour);
            testObservation.Code.DisplayName = "Diabetes Mellitus";

            TestCreateObservation(testObservation);

            AntepartumFamilyHistoryValueSet vs = new AntepartumFamilyHistoryValueSet();

            bool val = false;
            foreach (var item in vs.Items)
            {
                testObservation.Category = "Something Else";
                testObservation.Code = new DsioCode() { Code = item.Code, DisplayName = item.ItemName };
                testObservation.ExamDate = DateTime.Now.ToString(VistaDates.VistADateFormatFour);
                testObservation.Relationship = "FAMMEMB";
                val = !val;
                testObservation.Value = val.ToString();

                TestCreateObservation(testObservation);
            }

        }

        [TestMethod]
        public void TestRosMenstrualHistory()
        {
            DsioObservation testObservation = new DsioObservation()
            {
                PatientDfn = TestConfiguration.DefaultPatientDfn,
                PregnancyIen = "",
                BabyIen = "",
                Category = "Review of Systems",
                ExamDate = DateTime.Now.ToString(VistaDates.VistADateFormatFour),
                Value = "Patient reports pain in left wrist",
                Code = new DsioCode() { CodeSystemName = "LOINC", Code = "10187-3", DisplayName = "Review of Systems" }
            };

            TestCreateObservation(testObservation);

            testObservation.Category = "Menstrual History";
            testObservation.Code.CodeSystemName = "SNOMED-CT";
            testObservation.Code.Code = "21840007";
            testObservation.ExamDate = DateTime.Now.ToString(VistaDates.VistADateFormatFour);
            testObservation.Code.DisplayName = "Date of Last Menstrual Period";
            testObservation.Value = "08/08/2014"; 

            TestCreateObservation(testObservation);

            testObservation.Code.Code = "364307006";
            testObservation.ExamDate = DateTime.Now.ToString(VistaDates.VistADateFormatFour);
            testObservation.Code.DisplayName = "Regularity of Menstrual Cycle";
            testObservation.Value = true.ToString(); 

            TestCreateObservation(testObservation);

            testObservation.Code.Code = "364306002";
            testObservation.ExamDate = DateTime.Now.ToString(VistaDates.VistADateFormatFour);
            testObservation.Code.DisplayName = "Frequency of Menstruation (Days)";
            testObservation.Value = "6";
            testObservation.Unit = "days"; 

            TestCreateObservation(testObservation);

            testObservation.Code.Code = "xx-onbcp";
            testObservation.ExamDate = DateTime.Now.ToString(VistaDates.VistADateFormatFour);
            testObservation.Code.DisplayName = "On birth control pills at conception";
            testObservation.Value = false.ToString(); 

            TestCreateObservation(testObservation);

            testObservation.Code.Code = "398700009";
            testObservation.ExamDate = DateTime.Now.ToString(VistaDates.VistADateFormatFour);
            testObservation.Code.DisplayName = "Age at menarche";
            testObservation.Value = "12";
            testObservation.Unit = "years"; 

            TestCreateObservation(testObservation);

            testObservation.Code.Code = "67900009";
            testObservation.ExamDate = DateTime.Now.ToString(VistaDates.VistADateFormatFour);
            testObservation.Code.DisplayName = "Human chorionic gonadotropin measurement";
            testObservation.Value = "10/01/2014";

            TestCreateObservation(testObservation);

        }

        [TestMethod]
        public void TestVitalSigns()
        {
            DsioObservation testObservation = new DsioObservation()
            {
                PatientDfn = TestConfiguration.DefaultPatientDfn,
                PregnancyIen = "",
                BabyIen = "",
                Category = "Vital Signs",
                ExamDate = DateTime.Now.ToString(VistaDates.VistADateFormatFour),
                Value = "12", 
                Unit = "{breaths}/min",
                Code = new DsioCode() { CodeSystem = "LOINC", Code = "9279-1", DisplayName = "Respiration Rate" }
            };

            TestCreateObservation(testObservation);

            testObservation.Code.Code = "8867-4";
            testObservation.Code.DisplayName = "Heart Rate";
            testObservation.Value = "60";
            testObservation.Unit = "bpm";

            TestCreateObservation(testObservation);

            testObservation.Code.Code = "2710-2";
            testObservation.Code.DisplayName = "Oxygen Saturation";
            testObservation.Value = "80";
            testObservation.Unit = "%";

            TestCreateObservation(testObservation);

            testObservation.Code.Code = "8480-6";
            testObservation.Code.DisplayName = "Intravascular Systolic";
            testObservation.Value = "120";
            testObservation.Unit = "mm[Hg]";

            TestCreateObservation(testObservation);

            testObservation.Code.Code = "8462-4";
            testObservation.Code.DisplayName = "Intravascular Diastolic";
            testObservation.Value = "80";
            testObservation.Unit = "mm[Hg]";

            TestCreateObservation(testObservation);

            testObservation.Code.Code = "8310-5";
            testObservation.Code.DisplayName = "Body Temperature";
            testObservation.Value = "98.6";
            testObservation.Unit = "deg F";

            TestCreateObservation(testObservation);

            testObservation.Code.Code = "8302-2";
            testObservation.Code.DisplayName = "Body Height (Measured)";
            testObservation.Value = "66";
            testObservation.Unit = "in";

            TestCreateObservation(testObservation);

            testObservation.Code.Code = "8306-3";
            testObservation.Code.DisplayName = "Body Height (Lying)";
            testObservation.Value = "67";
            testObservation.Unit = "in";

            TestCreateObservation(testObservation);

            testObservation.Code.Code = "8287-5";
            testObservation.Code.DisplayName = "Head Occipital-frontal circumference by tape measure";
            testObservation.Value = "14";
            testObservation.Unit = "in";

            TestCreateObservation(testObservation);

            testObservation.Code.Code = "3141-9";
            testObservation.Code.DisplayName = "Body Weight (Measured)";
            testObservation.Value = "150";
            testObservation.Unit = "lbs";

            TestCreateObservation(testObservation);

            testObservation.Category = "Physical Exam";
            testObservation.Code.Code = "10210-3";
            testObservation.Code.DisplayName = "General Appearance";
            testObservation.Value = "Patient appeared groggy and slow-moving";

            TestCreateObservation(testObservation);

            testObservation.Code.Code = "29302-7";
            testObservation.Code.DisplayName = "Integumentary System";
            testObservation.Value = "A severe rash covers the patient's back";

            TestCreateObservation(testObservation);
        }

        [TestMethod]
        public void TestPhysicalExam()
        {
            DsioObservation testObservation = new DsioObservation()
            {
                PatientDfn = TestConfiguration.DefaultPatientDfn,
                Category = "Physical Exam",
                ExamDate = DateTime.Now.ToString(VistaDates.VistADateFormatFour),
                Value = "Patient appeared groggy and slow-moving",
                Code = new DsioCode() { CodeSystemName = "LOINC", Code = "10210-3", DisplayName = "General Appearance" }
            };

            TestCreateObservation(testObservation);

            testObservation.Category = "Physical Exam";
            testObservation.Code.Code = "11412-4";
            testObservation.Code.DisplayName = "Respiratory System";
            testObservation.Value = "Patient has congestion in the lungs";

            TestCreateObservation(testObservation);

            testObservation.Code.Code = "29302-7";
            testObservation.Code.DisplayName = "Integumentary System";
            testObservation.Value = "A severe rash covers the patient's back";

            TestCreateObservation(testObservation);
        }

        [TestMethod]
        public void TestCreateCdaPregnancyObservations()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioSaveObservationCommand saveCommand = new DsioSaveObservationCommand(broker);

                //DsioObservation testObservation = new DsioObservation()
                //{
                //    PatientDfn = "126",
                //    PregnancyIen = "125",
                //    BabyNum = "",
                //    Category = "Pregnancy History",
                //    CodeSystem = "LOINC",
                //    Code = "21112-8",
                //    Value = "05/05/2011",
                //    Date = DateTime.Now.ToString(VistaDates.VistADateFormatFour),
                //    Description = "Birth Date"
                //};

                //DsioObservation testObservation = new DsioObservation()
                //{
                //    PatientDfn = "126",
                //    PregnancyIen = "125",
                //    BabyNum = "",
                //    Category = "Pregnancy History",
                //    CodeSystem = "LOINC",
                //    Code = "32396-9",
                //    Value = "18",
                //    Date = DateTime.Now.ToString(VistaDates.VistADateFormatFour),
                //    Description = "Length of Labor"
                //};

                //DsioObservation testObservation = new DsioObservation()
                //{
                //    PatientDfn = "126",
                //    PregnancyIen = "125",
                //    BabyNum = "1",
                //    Category = "Baby Details",
                //    CodeSystem = "LOINC",
                //    Code = "8339-4",
                //    Value = "117",
                //    Date = DateTime.Now.ToString(VistaDates.VistADateFormatFour),
                //    Description = "Birth Weight"
                //};

                // TODOBABY...
                //DsioObservation testObservation = new DsioObservation()
                //{
                //    PatientDfn = "28",
                //    PregnancyIen = "4",
                //    BabyNum = "1",
                //    Category = "Baby Details",
                //    Value = "False",
                //    Date = DateTime.Now.ToString(VistaDates.VistADateFormatFour),
                //    Code = new DsioCode() { CodeSystem = "LOINC", Code = "75207-1", DisplayName = "Stillborn" }
                //}; 
                
                //saveCommand.AddCommandArguments(testObservation);

                //RpcResponse response = saveCommand.Execute();

                //Assert.AreEqual(RpcResponseStatus.Success, response.Status);
                //Assert.IsFalse(string.IsNullOrWhiteSpace(saveCommand.Ien));
            }
        }

        [TestMethod]
        public void TestCreateLatexAllergyObservation()
        {            
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioSaveObservationCommand saveCommand = new DsioSaveObservationCommand(broker);

                DsioObservation testObservation = new DsioObservation()
                {
                    PatientDfn = TestConfiguration.DefaultPatientDfn,
                    PregnancyIen = "",
                    BabyIen = "",
                    Category = "Allergy",
                    Code = new DsioCode() 
                    { 
                        CodeSystem = CdaCode.SnomedCtSystemId, 
                        CodeSystemName = CdaCode.SnomedCtSystemName,
                        Code = "300916003", 
                        DisplayName = "Latex Allergy"                    
                    },
                    ExamDate = DateTime.Now.ToString(VistaDates.VistADateFormatFour),
                    Negation = "true"
                };

                saveCommand.AddCommandArguments(testObservation);

                RpcResponse response = saveCommand.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);
                Assert.IsFalse(string.IsNullOrWhiteSpace(saveCommand.Ien));

                DsioGetObservationsCommand getCommand = new DsioGetObservationsCommand(broker);

                //getCommand.AddCommandArguments("", saveCommand.Ien, "", "", "", "", "", 0, 0);
                getCommand.AddCommandArguments(testObservation.PatientDfn, "", "", "", "", "", "", "Allergy", -1, -1);

                response = getCommand.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);

            }
        }

        [TestMethod]
        public void TestCreateAdvanceDirectiveObservation()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioSaveObservationCommand saveCommand = new DsioSaveObservationCommand(broker);

                DsioObservation testObservation = new DsioObservation()
                {
                    PatientDfn = TestConfiguration.DefaultPatientDfn,
                    PregnancyIen = "",
                    BabyIen = "",
                    Category = "Advance Directive",
                    //Code = new DsioCode()
                    //{
                    //    CodeSystem = CdaCode.SnomedCtSystemId,
                    //    CodeSystemName = CdaCode.SnomedCtSystemName,
                    //    Code = "116859006",
                    //    DisplayName = "Transfusion of Blood Product"
                    //},
                    Code = new DsioCode()
                    {
                        CodeSystem = CdaCode.LoincSystemId,
                        CodeSystemName = CdaCode.LoincSystemName,
                        Code = "(xx-bld-transf-ok)",
                        DisplayName = "Transfusion of Blood Product"
                    },
                    ExamDate = DateTime.Now.ToString(VistaDates.VistADateFormatFour),
                    Value = "true"
                };

                saveCommand.AddCommandArguments(testObservation);

                RpcResponse response = saveCommand.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);
                Assert.IsFalse(string.IsNullOrWhiteSpace(saveCommand.Ien));

                DsioGetObservationsCommand getCommand = new DsioGetObservationsCommand(broker);

                //getCommand.AddCommandArguments("", saveCommand.Ien, "", "", "", "", "", 0, 0);
                getCommand.AddCommandArguments(testObservation.PatientDfn, "", "", "", "", "", "", "Advance Directive", -1, -1);

                response = getCommand.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);

            }
        }

        [TestMethod]
        public void TestCreateCarePlanObservations()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioSaveObservationCommand saveCommand = new DsioSaveObservationCommand(broker);

                DsioObservation testObservation = new DsioObservation()
                {
                    PatientDfn = TestConfiguration.DefaultPatientDfn,
                    PregnancyIen = "",
                    BabyIen = "",
                    Category = "Care Plan",
                    Code = new DsioCode()
                    {
                        CodeSystem = CdaCode.LoincSystemId,
                        CodeSystemName = CdaCode.LoincSystemName,
                        Code = "(xx-anest-cons-pland)",
                        DisplayName = "Anesthesia Consult Planned"
                    },
                    ExamDate = DateTime.Now.ToString(VistaDates.VistADateFormatFour),
                    Value = "true"
                };

                saveCommand.AddCommandArguments(testObservation);

                RpcResponse response = saveCommand.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);
                Assert.IsFalse(string.IsNullOrWhiteSpace(saveCommand.Ien));

                testObservation = new DsioObservation()
                {
                    PatientDfn = TestConfiguration.DefaultPatientDfn,
                    PregnancyIen = "",
                    BabyIen = "",
                    Category = "Care Plan",
                    Code = new DsioCode()
                    {
                        CodeSystem = CdaCode.LoincSystemId,
                        CodeSystemName = CdaCode.LoincSystemName,
                        Code = "(xx-type-of-anesth-pland)",
                        DisplayName = "Type of Anesthesia Planned"
                    },
                    ExamDate = DateTime.Now.ToString(VistaDates.VistADateFormatFour),
                    Value = "Epidural"
                };

                saveCommand.AddCommandArguments(testObservation);

                response = saveCommand.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);
                Assert.IsFalse(string.IsNullOrWhiteSpace(saveCommand.Ien));

                DsioGetObservationsCommand getCommand = new DsioGetObservationsCommand(broker);

                //getCommand.AddCommandArguments("", saveCommand.Ien, "", "", "", "", "", 0, 0);
                getCommand.AddCommandArguments(testObservation.PatientDfn, "", "", "", "", "", "", "Care Plan", -1, -1);

                response = getCommand.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);

            }
        }

        [TestMethod]
        public void TestCreateVisitSummaryObservations()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioSaveObservationCommand saveCommand = new DsioSaveObservationCommand(broker);

                DsioObservation testObservation = new DsioObservation()
                {
                    PatientDfn = TestConfiguration.DefaultPatientDfn,
                    PregnancyIen = "",
                    BabyIen = "",
                    Category = "Visit Summary",
                    Code = new DsioCode()
                    {
                        CodeSystem = CdaCode.LoincSystemId,
                        CodeSystemName = CdaCode.LoincSystemName,
                        Code = "8348-5",
                        DisplayName = "Pre-Pregnancy Weight"
                    },
                    ExamDate = DateTime.Now.ToString(VistaDates.VistADateFormatFour),
                    Value = "130", 
                    Unit = "lb_av"
                };

                saveCommand.AddCommandArguments(testObservation);

                RpcResponse response = saveCommand.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);
                Assert.IsFalse(string.IsNullOrWhiteSpace(saveCommand.Ien));
            }
        }
    }
}
