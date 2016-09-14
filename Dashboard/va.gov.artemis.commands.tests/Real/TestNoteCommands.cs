using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using VA.Gov.Artemis.Commands.Dsio.Notes;
using VA.Gov.Artemis.Vista.Broker;
using System.Diagnostics;

namespace VA.Gov.Artemis.Commands.Tests.Real
{
    [TestClass]
    public class TestNoteCommands: TestCommandsBase
    {
        private const string patDfn = "126"; 

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
                    command.AddCommandArguments(patDfn, title, "Monday Notes", "test subject", new DsioNoteData(), "");
                    //command.AddCommandArguments("740", "MCC DASHBOARD NOTE", "Monday Notes", "test subject", new DsioNoteData());
                    //command.AddCommandArguments("740", "MCC Phone Call #1 (Initial Contact)", "Test MCC Call #1", "test subject", new DsioNoteData());
                    //command.AddCommandArguments("740", "PHONE CALL #7 (6 WEEKS POST-PARTUM) TOPICS", "Monday Notes", "test subject", new DsioNoteData());
                    //command.AddCommandArguments("740", "PHONE CALL #6A (41 WEEKS NOT DELIVERED)", "Monday Notes", "test subject", new DsioNoteData());

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

                command.AddCommandArguments("100017", "MCC DASHBOARD NOTE", "Note Text Here", "Some Subject", new DsioNoteData(), "");

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status, "MCC DASHBOARD NOTE could not be created");

                Assert.IsFalse(string.IsNullOrWhiteSpace(command.Ien));

                DsioGetTiuNotesCommand getCommand = new DsioGetTiuNotesCommand(broker);

                getCommand.AddCommandArguments("100017", new string[] {"MCC DASHBOARD NOTE"}, "", "", 0, 0, false, command.Ien, "");

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

                   command.AddCommandArguments(patDfn, title, "Testing Discrete Data", "test subject", noteData, "");

                   RpcResponse response = command.Execute();

                   Assert.AreEqual(RpcResponseStatus.Success, response.Status);
                   Assert.IsFalse(string.IsNullOrWhiteSpace(command.Ien));

                   Debug.WriteLine(string.Format("IEN RETURNED: {0}", command.Ien)); 

                   //DsioGetNoteElementCommand getCommand = new DsioGetNoteElementCommand(broker);
                   DsioDdcsGetControlValue getCommand = new DsioDdcsGetControlValue(broker); 

                   getCommand.AddCommandArguments(command.Ien);
                   //getCommand.AddCommandArguments("5143");

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
                
                //DsioGetRecordTextCommand cmd = new DsioGetRecordTextCommand(broker);

                //cmd.AddCommandArgument(command.Ien, DsioGetRecordTextMode.HeaderAndBody);

                //response = cmd.Execute();

                //Assert.AreEqual(RpcResponseStatus.Success, response.Status);
            }
        }

        [TestMethod]
        public void TestGetDashboardNotes()
        {
            using (RpcBroker broker = GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioGetTiuNotesCommand command = new DsioGetTiuNotesCommand(broker);

                command.AddCommandArguments(patDfn, new string[]{"MCC DASHBOARD NOTE"}, "", "", 1, 100, true, "", "");

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

                //command.AddCommandArguments("100032", tiuNoteTitleText, "", "", 1, 100, true, "", "");
                command.AddCommandArguments("168", tiuNoteTitleText, "", "", 1, 100, true, "", "");

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

                commandCreate.AddCommandArguments(patDfn, "MCC DASHBOARD NOTE", "Note text for Friday", "test subject", new DsioNoteData(), "");

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

                DsioGetRecordTextCommand command = new DsioGetRecordTextCommand(broker);

                //command.AddParameter("461");
                //command.AddCommandArgument("4999", DsioGetRecordTextMode.HeaderAndBody);
                //command.AddCommandArgument("5016", DsioGetRecordTextMode.HeaderAndBody);
                command.AddCommandArgument("4850", DsioGetRecordTextMode.HeaderAndBody);

                RpcResponse response = command.Execute();

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

                commandCreate.AddCommandArguments(patDfn, "MCC DASHBOARD NOTE", "Note text for Friday", "test subject", new DsioNoteData(), "");

                RpcResponse response = commandCreate.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);

                DsioSignANoteCommand command = new DsioSignANoteCommand(broker);

                command.AddCommandArguments(commandCreate.Ien, "NUR1234");

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

                commandCreate.AddCommandArguments(patDfn, "MCC DASHBOARD NOTE", "Note text for Friday", "test subject", new DsioNoteData(), "");

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

                commandCreate.AddCommandArguments(patDfn, "MCC DASHBOARD NOTE", "Note text for Friday", "test subject", new DsioNoteData(), "");

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

                command.AddCommandArguments(patDfn, "MCC DASHBOARD NOTE", "Testing Discrete Data", "test subject", noteData, "");

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

                command.AddCommandArguments(patDfn, TiuNoteTitleText, "", "", 1, 100, true, "", "");

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

                command.AddCommandArguments(patDfn, TiuNoteTitleText, "08/11/2014", "08/15/2014", 1, 100, true, "", "");

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

                // TODO: Use a real pregnancy...
                //command.AddCommandArguments("197", "PHONE CALL #1 (FIRST CONTACT)", "Final Tuesday Testing?", "A Subject Goes Here", new DsioNoteData(), "140");
                //command.AddCommandArguments("197", "PHONE CALL #1 (FIRST CONTACT)", "Wed Note", "A Subject Goes Here", new DsioNoteData(), "");
                command.AddCommandArguments("100017", "PHONE CALL #1 (FIRST CONTACT)", "Tue Note", "A Subject Goes Here", new DsioNoteData(), "57");

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

                DsioUpdateANoteCommand command = new DsioUpdateANoteCommand(broker);

                //command.AddCommandArguments("197", "PHONE CALL #1 (FIRST CONTACT)", "Thursday Notes", "test subject", new DsioNoteData(), "9999");
                command.AddCommandArguments("4850", "This is edited without preg", "New Subject", null, "");

                RpcResponse response = command.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);
            }
        }
    }
}
