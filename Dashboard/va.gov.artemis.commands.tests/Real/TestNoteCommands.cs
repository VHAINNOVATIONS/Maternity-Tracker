// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using VA.Gov.Artemis.Commands.Dsio.Notes;
using VA.Gov.Artemis.Vista.Broker;
using System.Diagnostics;
using VA.Gov.Artemis.Commands.Dsio.Pregnancy;

namespace VA.Gov.Artemis.Commands.Tests.Real
{
    [TestClass]
    public class TestNoteCommands: TestCommandsBase
    {
        //private const string patDfn = "126"; 

        [TestMethod]
        public void TestCreateANote()
        {
            using (RpcBroker broker = GetConnectedBroker())
            {
                this.SignonToBroker(broker, 3);

                DsioCreateANoteCommand command = new DsioCreateANoteCommand(broker);

                string[] TiuNoteTitleText = new string[] { 
                    "MCC DASHBOARD NOTE", 
                    "DASHBOARD CDA INCOMING", 
                    "PHONE CALL #1 (FIRST CONTACT)",
                    "PHONE CALL #2 (12 WEEKS)",
                    "PHONE CALL #3 (20 WEEKS)",
                    "PHONE CALL #4 (28 WEEKS)",
                    "PHONE CALL #5 (36 WEEKS)",
                    "PHONE CALL #6A (41 WEEKS NOT DELIVERED)",
                    "PHONE CALL #6B (41 WEEKS DELIVERED) TOPICS",
                    "PHONE CALL #7 (6 WEEKS POSTPARTUM) TOPICS", 
                    };

                foreach (string title in TiuNoteTitleText)
                {
                    command.AddCommandArguments(TestConfiguration.DefaultPatientDfn, title, "Monday Notes", "test subject", new DsioNoteData(), "");

                    RpcResponse response = command.Execute();
                    
                    Assert.AreEqual(RpcResponseStatus.Success, response.Status, string.Format("{0} could not be created", title));
                }
            }
        }

        [TestMethod]
        public void TestCreateDashboardNote()
        {
            using (RpcBroker broker = GetConnectedBroker())
            {
                this.SignonToBroker(broker, 3);

                DsioCreateANoteCommand command = new DsioCreateANoteCommand(broker);

                command.AddCommandArguments(TestConfiguration.DefaultPatientDfn, "MCC DASHBOARD NOTE", "Note Text Here", "Some Subject", new DsioNoteData(), "");

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status, "MCC DASHBOARD NOTE could not be created");

                Assert.IsFalse(string.IsNullOrWhiteSpace(command.Ien));

                DsioGetTiuNotesCommand getCommand = new DsioGetTiuNotesCommand(broker);

                getCommand.AddCommandArguments(TestConfiguration.DefaultPatientDfn, new string[] {"MCC DASHBOARD NOTE"}, "", "", 0, 0, false, command.Ien, "");

                response = getCommand.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status, "MCC DASHBOARD NOTE could not be retrieved");

                Assert.IsNotNull(getCommand.Notes);
                Assert.IsTrue(getCommand.Notes.Count == 1);
                Assert.AreEqual(getCommand.Notes[0].Ien, command.Ien); 
            }
        }

        [TestMethod]
        public void TestCreateANoteWithData()
        {
            using (RpcBroker broker = GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioCreateANoteCommand command = new DsioCreateANoteCommand(broker);

                DsioNoteData noteData = new DsioNoteData();

                noteData.Add("INTRO_1", "Patient's");
                noteData.Add("INTRO_2", false.ToString());
                noteData.Add("COVERAGE_1", true.ToString());
                noteData.Add("COVERAGE_2", false.ToString());
                //S^INTRODUCTIONCALL.PATIENTAVAILABLE^INTRODUCTIONCALL.PATIENTAVAILABLE^True

                // Too long...
                //noteData.Add("INT_AVAILXXXXXXXXXXXXXXXXXXXXXX", true.ToString()); 
                //noteData.Add("INT_AVAIL", true.ToString()); 

                //string title = "PHONE CALL #4 (28 WEEKS)";
                //string title = "MCC DASHBOARD NOTE";

               //string[] TiuNoteTitleText = new string[] { 
               //     "MCC DASHBOARD NOTE", 
               //     "DASHBOARD CDA INCOMING", 
               //     "PHONE CALL #1 (FIRST CONTACT)",
               //     "PHONE CALL #2 (12 WEEKS)",
               //     "PHONE CALL #3 (20 WEEKS)",
               //     "PHONE CALL #4 (28 WEEKS)",
               //     "PHONE CALL #5 (36 WEEKS)",
               //     "PHONE CALL #6A (41 WEEKS NOT DELIVERED)",
               //     "PHONE CALL #6B (41 WEEKS DELIVERED) TOPICS",
               //     "PHONE CALL #7 (6 WEEKS POSTPARTUM) TOPICS", 
               //     };

                // *** Only these are configured for now ***
                string[] TiuNoteTitleText = new string[] { 
                    "MCC DASHBOARD NOTE", 
                    "PHONE CALL #1 (FIRST CONTACT)",
                    };

               foreach (string title in TiuNoteTitleText)
               {
                   Debug.WriteLine(" - Adding Note - ");
                   Debug.WriteLine(title);

                   command.AddCommandArguments(TestConfiguration.DefaultPatientDfn, title, "Testing Discrete Data", "test subject", noteData, "");

                   RpcResponse response = command.Execute();

                   Assert.AreEqual(RpcResponseStatus.Success, response.Status);
                   Assert.IsFalse(string.IsNullOrWhiteSpace(command.Ien));

                   Debug.WriteLine(string.Format("IEN RETURNED: {0}", command.Ien)); 

                   DsioDdcsGetControlValue getCommand = new DsioDdcsGetControlValue(broker); 

                   getCommand.AddCommandArguments(command.Ien);

                   response = getCommand.Execute();

                   Assert.AreEqual(RpcResponseStatus.Success, response.Status);

                   Debug.WriteLine("Return from DSIO GET NOTE ELEMENT...");
                   Debug.WriteLine(response.Data); 

                   string val = "";
                   if (getCommand.NoteData != null)
                       getCommand.NoteData.TryGetValue("COVERAGE_2", out val);

                   Assert.AreEqual(noteData["COVERAGE_2"], val);

                   Debug.WriteLine(" -- "); 
               }                
               
            }
        }

        [TestMethod]
        public void TestGetDashboardNotes()
        {
            using (RpcBroker broker = GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioGetTiuNotesCommand command = new DsioGetTiuNotesCommand(broker);

                command.AddCommandArguments(TestConfiguration.DefaultPatientDfn, new string[]{"MCC DASHBOARD NOTE"}, "", "", 1, 100, true, "", "");

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);
            }
        }

        [TestMethod]
        public void TestGetAllNotes()
        {
            using (RpcBroker broker = GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioGetTiuNotesCommand command = new DsioGetTiuNotesCommand(broker);

                string[] tiuNoteTitleText = new string[] { 
                    "MCC DASHBOARD NOTE", 
                    "DASHBOARD CDA INCOMING", 
                    "PHONE CALL #1 (FIRST CONTACT)",
                    "PHONE CALL #2 (12 WEEKS)",
                    "PHONE CALL #3 (20 WEEKS)",
                    "PHONE CALL #4 (28 WEEKS)",
                    "PHONE CALL #5 (36 WEEKS)",
                    "PHONE CALL #6A (41 WEEKS NOT DELIVERED)",
                    "PHONE CALL #6B (41 WEEKS DELIVERED) TOPICS",
                    "PHONE CALL #7 (6 WEEKS POSTPARTUM) TOPICS", 
                    };

                command.AddCommandArguments(TestConfiguration.DefaultPatientDfn, tiuNoteTitleText, "", "", 1, 100, true, "", "");

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);
            }
        }

        [TestMethod]
        public void TestUpdateANote()
        {
            using (RpcBroker broker = GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioCreateANoteCommand commandCreate = new DsioCreateANoteCommand(broker);

                commandCreate.AddCommandArguments(TestConfiguration.DefaultPatientDfn, "MCC DASHBOARD NOTE", "Note text for Friday", "test subject", new DsioNoteData(), "");

                RpcResponse response = commandCreate.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);

                DsioUpdateANoteCommand command = new DsioUpdateANoteCommand(broker);

                command.AddCommandArguments(commandCreate.Ien, "This is UPDATED Saturday", "updated subject", new DsioNoteData(), "");

                response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);
            }
        }

        [TestMethod]
        public void TestGetProgressNoteText()
        {
            using (RpcBroker broker = GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioCreateANoteCommand command = new DsioCreateANoteCommand(broker);

                command.AddCommandArguments(TestConfiguration.DefaultPatientDfn, "MCC DASHBOARD NOTE", "Note Text Here", "Some Subject", new DsioNoteData(), "");

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status, "MCC DASHBOARD NOTE could not be created");

                Assert.IsFalse(string.IsNullOrWhiteSpace(command.Ien));

                DsioGetRecordTextCommand getCommand = new DsioGetRecordTextCommand(broker);

                getCommand.AddCommandArgument(command.Ien, DsioGetRecordTextMode.HeaderAndBody);

                response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);

                broker.Disconnect();
            }
        }

        [TestMethod]
        public void TestGetProgressNoteTextMissing()
        {
            using (RpcBroker broker = GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioGetRecordTextCommand command = new DsioGetRecordTextCommand(broker);

                command.AddCommandArgument("9999", DsioGetRecordTextMode.HeaderAndBody);

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Fail, response.Status);

                broker.Disconnect();
            }
        }

        [TestMethod]
        public void TestSignNote()
        {
            using (RpcBroker broker = GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioCreateANoteCommand commandCreate = new DsioCreateANoteCommand(broker);

                commandCreate.AddCommandArguments(TestConfiguration.DefaultPatientDfn, "MCC DASHBOARD NOTE", "Note text for Friday", "test subject", new DsioNoteData(), "");

                RpcResponse response = commandCreate.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);

                DsioSignANoteCommand command = new DsioSignANoteCommand(broker);

                command.AddCommandArguments(commandCreate.Ien, TestConfiguration.ValidSigs[2]);

                response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);

                broker.Disconnect();
            }
        }

        [TestMethod]
        public void TestCreateAddendum()
        {
            using (RpcBroker broker = GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioCreateANoteCommand commandCreate = new DsioCreateANoteCommand(broker);

                commandCreate.AddCommandArguments(TestConfiguration.DefaultPatientDfn, "MCC DASHBOARD NOTE", "Note text for Friday", "test subject", new DsioNoteData(), "");

                RpcResponse response = commandCreate.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);

                DsioMakeAddendumCommand command = new DsioMakeAddendumCommand(broker);

                command.AddCommandArguments(commandCreate.Ien, "This is an addendum for Saturday", "test subject", new DsioNoteData());

                response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);
            }
        }

        [TestMethod]
        public void TestDeleteNote()
        {
            using (RpcBroker broker = GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioCreateANoteCommand commandCreate = new DsioCreateANoteCommand(broker);

                commandCreate.AddCommandArguments(TestConfiguration.DefaultPatientDfn, "MCC DASHBOARD NOTE", "Note text for Friday", "test subject", new DsioNoteData(), "");

                RpcResponse response = commandCreate.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);

                DsioDeleteANoteCommand command = new DsioDeleteANoteCommand(broker);

                command.AddCommandArguments(commandCreate.Ien, "This note was added to the wrong patient");

                response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);
            }
        }

        //[TestMethod]
        //public void TestNoteData()
        //{
        //    using (RpcBroker broker = GetConnectedBroker())
        //    {
        //        this.SignonToBroker(broker, 0);

        //        DsioDdscStoreCommand command = new DsioDdscStoreCommand(broker);

        //        command.AddCommandArguments("5093", null);

        //        RpcResponse response = command.Execute();

        //        Assert.AreEqual(RpcResponseStatus.Success, response.Status);

        //        broker.Disconnect();
        //    }
        //}

        [TestMethod]
        public void TestUpdateNoteData()
        {
            using (RpcBroker broker = GetConnectedBroker())
            {
                this.SignonToBroker(broker, 3);

                DsioCreateANoteCommand command = new DsioCreateANoteCommand(broker);

                DsioNoteData noteData = new DsioNoteData();

                noteData.Add("INTRO_1", true.ToString());
                noteData.Add("INTRO_2", false.ToString());
                noteData.Add("COVERAGE_1", true.ToString());
                noteData.Add("COVERAGE_2", false.ToString());

                command.AddCommandArguments(TestConfiguration.DefaultPatientDfn, "MCC DASHBOARD NOTE", "Testing Discrete Data", "test subject", noteData, "");

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);
                Assert.IsFalse(string.IsNullOrWhiteSpace(command.Ien));

                //DsioGetNoteElementCommand getCommand = new DsioGetNoteElementCommand(broker);
                DsioDdcsGetControlValue getCommand = new DsioDdcsGetControlValue(broker); 

                getCommand.AddCommandArguments(command.Ien);

                response = getCommand.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);

                DsioUpdateANoteCommand updateCommand = new DsioUpdateANoteCommand(broker);

                noteData.Clear(); 

                noteData.Add("INTRO_1",false.ToString());
                    
                updateCommand.AddCommandArguments(command.Ien, "Updated note text", "", noteData, "");

                response = updateCommand.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);

                response = getCommand.Execute();
            }

        }

        [TestMethod]
        public void TestGetContactNotes()
        {
            using (RpcBroker broker = GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioGetTiuNotesCommand command = new DsioGetTiuNotesCommand(broker);

                string[] TiuNoteTitleText = new string[] { 
                        "PHONE CALL #1 (FIRST CONTACT)",
                        "PHONE CALL #2 (12 WEEKS)",
                        "PHONE CALL #3 (20 WEEKS)",
                        "PHONE CALL #4 (28 WEEKS)",
                        "PHONE CALL #5 (36 WEEKS)",
                        "PHONE CALL #6A (41 WEEKS",
                        "PHONE CALL #6B (41 WEEKS",
                        "PHONE CALL #7 (6 WEEKS POSTPARTUM) TOPICS", 
                        "MCC Phone Call – Additional"}; 

                command.AddCommandArguments(TestConfiguration.DefaultPatientDfn, TiuNoteTitleText, "", "", 1, 100, true, "", "");

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);
                broker.Disconnect(); 
            }
        }

        [TestMethod]
        public void TestGetContactNotesByDateRange()
        {
            using (RpcBroker broker = GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioGetTiuNotesCommand command = new DsioGetTiuNotesCommand(broker);

                string[] TiuNoteTitleText = new string[] { 
                        "PHONE CALL #1 (FIRST CONTACT)",
                        "PHONE CALL #2 (12 WEEKS)",
                        "PHONE CALL #3 (20 WEEKS)",
                        "PHONE CALL #4 (28 WEEKS)",
                        "PHONE CALL #5 (36 WEEKS)",
                        "PHONE CALL #6A (41 WEEKS",
                        "PHONE CALL #6B (12 WEEKS)",
                        "PHONE CALL #7 (6 WEEKS POSTPARTUM) TOPICS", 
                        "MCC Phone Call – Additional"};

                command.AddCommandArguments(TestConfiguration.DefaultPatientDfn, TiuNoteTitleText, "08/11/2014", "08/15/2014", 1, 100, true, "", "");

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);
                broker.Disconnect();
            }
        }

        [TestMethod]
        public void TestCreateANoteWithPregnancy()
        {
            using (RpcBroker broker = GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioCreateANoteCommand command = new DsioCreateANoteCommand(broker);

                DsioPregnancy preg = this.GetOrCreatePregnancy(broker, TestConfiguration.DefaultPatientDfn);

                Assert.IsNotNull(preg);

                command.AddCommandArguments(TestConfiguration.DefaultPatientDfn, "PHONE CALL #1 (FIRST CONTACT)", "Tue Note", "A Subject Goes Here", new DsioNoteData(), preg.Ien);

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);
            }
        }

        [TestMethod]
        public void TestUpdateANoteWithPregnancy()
        {
            using (RpcBroker broker = GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioCreateANoteCommand command = new DsioCreateANoteCommand(broker);

                DsioPregnancy preg = this.GetOrCreatePregnancy(broker, TestConfiguration.DefaultPatientDfn);

                Assert.IsNotNull(preg);

                command.AddCommandArguments(TestConfiguration.DefaultPatientDfn, "PHONE CALL #1 (FIRST CONTACT)", "Tue Note", "A Subject Goes Here", new DsioNoteData(), preg.Ien);

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);

                DsioUpdateANoteCommand updCommand = new DsioUpdateANoteCommand(broker);

                //command.AddCommandArguments("197", "PHONE CALL #1 (FIRST CONTACT)", "Thursday Notes", "test subject", new DsioNoteData(), "9999");
                updCommand.AddCommandArguments(command.Ien, "This is edited without preg", "New Subject", null, "");

                response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);
            }
        }
    }
}
