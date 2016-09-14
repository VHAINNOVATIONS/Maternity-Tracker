using System;
using System.Text;
using System.Collections.Generic;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Commands.Dsio;
using System.IO;
using VA.Gov.Artemis.Commands.Dsio.Cda;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.Commands.Tests.Real
{
    /// <summary>
    /// Summary description for TestIheCommands
    /// </summary>
    [TestClass]
    public class TestIheCommands: TestCommandsBase
    {
        private const string testFile = @"Z:\VMShared\MT\IHE Samples\sampleAphp.xml";

        public TestIheCommands()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        private TestContext testContextInstance;

        /// <summary>
        ///Gets or sets the test context which provides
        ///information about and functionality for the current test run.
        ///</summary>
        public TestContext TestContext
        {
            get
            {
                return testContextInstance;
            }
            set
            {
                testContextInstance = value;
            }
        }

        #region Additional test attributes
        //
        // You can use the following additional attributes as you write your tests:
        //
        // Use ClassInitialize to run code before running the first test in the class
        // [ClassInitialize()]
        // public static void MyClassInitialize(TestContext testContext) { }
        //
        // Use ClassCleanup to run code after all tests in a class have run
        // [ClassCleanup()]
        // public static void MyClassCleanup() { }
        //
        // Use TestInitialize to run code before running each test 
        // [TestInitialize()]
        // public void MyTestInitialize() { }
        //
        // Use TestCleanup to run code after each test has run
        // [TestCleanup()]
        // public void MyTestCleanup() { }
        //
        #endregion

        [TestMethod]
        public void TestSaveIHE()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioSaveIheDocCommand command = new DsioSaveIheDocCommand(broker);

                // TODO: Get content somewhere else...
                //string content = File.ReadAllText(@"Z:\VMShared\Source\TestCCD\test_aphp_header.xml");
                string content = File.ReadAllText(testFile);

                // This works...
                command.AddCommandArguments("",Guid.NewGuid().ToString("B"), "126", "OUT", DateTime.Now.ToString(), DateTime.Now.ToString(), "APS", "This is a Test Title", "VA", "Outside Clinic", content);
                //command.AddCommandArguments("", Guid.NewGuid().ToString("B"), "299", "OUT", DateTime.Now.ToString(), DateTime.Now.ToString(), "APS", "This is a Test Title", "VA", "Outside Clinic", "");
                //command.AddCommandArguments("", Guid.NewGuid().ToString("B"), "144", "OUT", DateTime.Now.ToString(), DateTime.Now.ToString(), "APS", "This is a Test Title", "VA", "Outside Clinic", content);

                // These do not...
                //command.AddCommandArguments("", Guid.NewGuid().ToString("B"), "8", "OUT", DateTime.Now.ToString(), DateTime.Now.ToString(), "APS", "This is a Test Title", "VA", "Outside Clinic", "");
                //command.AddCommandArguments("", "12345", "8", "OUT", DateTime.Now.ToString(), DateTime.Now.ToString(), "APS", "This is a Test Title", "VA", "Outside Clinic", "");

                //command.AddCommandArguments("", Guid.NewGuid().ToString("B"), "144", "OUT", DateTime.Now.ToString(), DateTime.Now.ToString(), "APS", "This is a Test Title", "VA", "Outside Clinic", "");

                RpcResponse response = command.Execute();

                Assert.IsNotNull(response);
                Assert.AreEqual(RpcResponseStatus.Success, response.Status); 

            }
        }

        [TestMethod]
        public void TestGetIheDocsForPatient()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                //DsioIhePatientListCommand command = new DsioIhePatientListCommand(broker);
                DsioGetIheDocsCommand command = new DsioGetIheDocsCommand(broker); 

                command.AddCommandArguments("126","", 1, 100);

                RpcResponse response = command.Execute();

                Assert.IsNotNull(response);
                Assert.AreEqual(RpcResponseStatus.Success, response.Status); 
            }
        }

        [TestMethod]
        public void TestPatientListEmpty()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                //DsioIhePatientListCommand command = new DsioIhePatientListCommand(broker);
                DsioGetIheDocsCommand command = new DsioGetIheDocsCommand(broker); 

                command.AddCommandArguments("704","", 1, 100);

                RpcResponse response = command.Execute();

                Assert.IsNotNull(response);
                Assert.AreEqual(RpcResponseStatus.Success, response.Status);
            }
        }

        [TestMethod]
        public void TestGetDoc()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioSaveIheDocCommand saveCommand = new DsioSaveIheDocCommand(broker);

                // TODO: Get content somewhere else...
                string content = File.ReadAllText(testFile);

                // This works...
                saveCommand.AddCommandArguments("", Guid.NewGuid().ToString("B"), "715", "OUT", DateTime.Now.ToString(), DateTime.Now.ToString(), "APS", "This is a Test Title", "VA", "Outside Clinic", content);

                RpcResponse saveResponse = saveCommand.Execute();

                string addedIen = saveCommand.Ien; 

                //DsioIheGetDocCommand command = new DsioIheGetDocCommand(broker);
                DsioGetIheDocsCommand command = new DsioGetIheDocsCommand(broker); 

                command.AddCommandArguments("", addedIen, -1, -1);

                RpcResponse response = command.Execute();

                Assert.IsNotNull(response);
                Assert.AreEqual(RpcResponseStatus.Success, response.Status); 
            }
        }

        [TestMethod]
        public void TestGetDocEmpty()
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                string addedIen = "";

                //DsioIheGetDocCommand command = new DsioIheGetDocCommand(broker);
                DsioGetIheDocsCommand command = new DsioGetIheDocsCommand(broker); 

                command.AddCommandArguments("", addedIen, -1, -1);

                RpcResponse response = command.Execute();

                Assert.IsNotNull(response);
                Assert.AreEqual(RpcResponseStatus.Success, response.Status);
                Assert.IsNull(command.DocumentList);
            }
        }

        [TestMethod]
        public void TestIheDocSaveAndRetrieveWithId()
        {
            TestSaveAndRetrieve("123543");
        }

        [TestMethod]
        public void TestIheDocSaveAndRetrieveNoId()
        {
            TestSaveAndRetrieve("");
        }

        public void TestSaveAndRetrieve(string id)
        {
            using (RpcBroker broker = this.GetConnectedBroker())
            {
                this.SignonToBroker(broker, 2);

                DsioSaveIheDocCommand saveCommand = new DsioSaveIheDocCommand(broker);

                // TODO: Get content somewhere else...
                string content = File.ReadAllText(testFile);

                DateTime createdOn = DateTime.Now;
                DateTime importExportDate = DateTime.Now; 

                // This works...
                DsioCdaDocument doc = new DsioCdaDocument()
                {
                    Ien = "",
                    Id = id,
                    PatientDfn = "126",
                    Direction = "OUT",
                    CreatedOn = createdOn.ToString(VistaDates.VistADateFormatFour),
                    ImportExportDate = importExportDate.ToString(VistaDates.VistADateFormatFour),
                    DocumentType = "APS",
                    Title = "Test Title",
                    Sender = "Test Sender",
                    IntendedRecipient = "Test Recipient",
                    Content = content
                };

                //saveCommand.AddCommandArguments("", "12345", "715", "OUT", DateTime.Now.ToString(), DateTime.Now.ToString(), "APS", "This is a Test Title", "VA", "Outside Clinic", content);
                saveCommand.AddCommandArguments(
                    doc.Ien, doc.Id, doc.PatientDfn, doc.Direction, 
                    doc.CreatedOn, doc.ImportExportDate, doc.DocumentType, 
                    doc.Title, doc.Sender, doc.IntendedRecipient, doc.Content);

                RpcResponse response = saveCommand.Execute();

                Assert.IsNotNull(response);
                Assert.AreEqual(RpcResponseStatus.Success, response.Status);
                Assert.IsFalse(string.IsNullOrWhiteSpace(saveCommand.Ien)); 

                string ien = saveCommand.Ien;

                //DsioIheGetDocCommand getCommand = new DsioIheGetDocCommand(broker);
                DsioGetIheDocsCommand getCommand = new DsioGetIheDocsCommand(broker); 

                getCommand.AddCommandArguments("", ien, -1, -1);

                response = getCommand.Execute();

                Assert.IsNotNull(response);
                Assert.AreEqual(RpcResponseStatus.Success, response.Status);
                Assert.IsNotNull(getCommand.DocumentList);
                Assert.IsTrue(getCommand.DocumentList.Count > 0);
                Assert.AreEqual(doc.Id, getCommand.DocumentList[0].Id);
                Assert.AreEqual(doc.PatientDfn, getCommand.DocumentList[0].PatientDfn);
                Assert.AreEqual(doc.Direction, getCommand.DocumentList[0].Direction);

                string expectedDate = createdOn.ToString("MM/dd/yyyy@HH:mm:ss").ToUpper();
                Assert.AreEqual(expectedDate, getCommand.DocumentList[0].CreatedOn);

                expectedDate = importExportDate.ToString("MM/dd/yyyy@HH:mm:ss").ToUpper();
                Assert.AreEqual(expectedDate, getCommand.DocumentList[0].ImportExportDate);
                
                Assert.AreEqual(doc.DocumentType, getCommand.DocumentList[0].DocumentType);
                Assert.AreEqual(doc.Title, getCommand.DocumentList[0].Title);
                Assert.AreEqual(doc.Sender, getCommand.DocumentList[0].Sender);
                Assert.AreEqual(doc.IntendedRecipient, getCommand.DocumentList[0].IntendedRecipient);

                DsioGetIheContentCommand contentCommand = new DsioGetIheContentCommand(broker);

                contentCommand.AddCommandArguments(ien);

                response = contentCommand.Execute();

                Assert.AreEqual(RpcResponseStatus.Success, response.Status);
                Assert.IsNotNull(contentCommand.Document);
                //Assert.AreEqual(contentCommand.Document.Content, content); 

            }

        }
    }
}
