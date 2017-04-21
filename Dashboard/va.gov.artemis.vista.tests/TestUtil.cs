// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.Vista.Tests    
{
    [TestClass]
    public class TestUtil
    {
        [TestMethod]
        public void TestDelimSplit()
        {            
            string delim = ","; 
            string[] shouldSplitAs = new string[] {"1", "2", "3", "4", "5"};

            string stringToSplit = string.Join(delim, shouldSplitAs); 

            string[] result = Util.Split(stringToSplit, delim);

            Assert.AreEqual(shouldSplitAs.Length, result.Length); 

            for (int i = 0; i < result.Length; i++)
                Assert.AreEqual(shouldSplitAs[i], result[i]);
            
        }

        [TestMethod]
        public void TestDelimSplitEmpty()
        {
            string delim = ",";
            string[] shouldSplitAs = new string[0];

            string[] result = Util.Split("", delim);

            Assert.AreEqual(shouldSplitAs.Length, result.Length);

            for (int i = 0; i < result.Length; i++)
                Assert.AreEqual(shouldSplitAs[i], result[i]);

        }

        [TestMethod]
        public void TestDelimSplitTrailingDelim()
        {
            string delim = ",";
            string[] shouldSplitAs = new string[] { "1", "2", "3", "4", "5" };

            string stringToSplit = "1,2,3,4,5,"; 

            string[] result = Util.Split(stringToSplit, delim);

            Assert.AreEqual(shouldSplitAs.Length, result.Length);

            for (int i = 0; i < result.Length; i++)
                Assert.AreEqual(shouldSplitAs[i], result[i]);

        }


        [TestMethod]
        public void TestDelimSplitLeadingDelim()
        {
            string delim = ",";
            string[] shouldSplitAs = new string[] {"", "1", "2", "3", "4", "5" };

            string stringToSplit = ",1,2,3,4,5";

            string[] result = Util.Split(stringToSplit, delim);

            Assert.AreEqual(shouldSplitAs.Length, result.Length);

            for (int i = 0; i < result.Length; i++)
                Assert.AreEqual(shouldSplitAs[i], result[i]);

        }

        [TestMethod]
        public void TestSplit()
        {
            string[] shouldSplitAs = new string[] 
                {"Some ", " thing ", " that ", " will ", 
                    " split ", " into ", " lines."}; 

            string stringToSplit = "Some \r\n thing \r\n that \n will \n split \r into \r lines.";

            string[] result = Util.Split(stringToSplit);

            Assert.AreEqual(shouldSplitAs.Length, result.Length);

            for (int i = 0; i < result.Length; i++)
                Assert.AreEqual(shouldSplitAs[i], result[i]);


        }

        [TestMethod]
        public void TestPiece()
        {
            string firstPiece = "abc";
            string secondPiece = "123";
            string delim = ";";

            string stringToTest = firstPiece + delim + secondPiece;

            string result = Util.Piece(stringToTest, delim, 1);

            Assert.AreEqual(firstPiece, result);

            result = Util.Piece(stringToTest, delim, 2);

            Assert.AreEqual(secondPiece, result); 

        }

        [TestMethod]
        public void TestPieceNull()
        {
            string stringToTest = null;

            string result = Util.Piece(stringToTest, ",", 1);

            Assert.IsTrue(true); 

        }

        [TestMethod]
        public void TestUtilDateTime()
        {
            DateTime testDateTime = Util.GetDateTime("3000329.161");
            Assert.AreNotEqual(DateTime.MinValue, testDateTime);
            
            testDateTime = Util.GetDateTime("3000329.1");
            Assert.AreNotEqual(DateTime.MinValue, testDateTime);

            testDateTime = Util.GetDateTime("3141230.12");
            Assert.AreNotEqual(DateTime.MinValue, testDateTime);

            testDateTime = Util.GetDateTime("3141230.09");
            Assert.AreNotEqual(DateTime.MinValue, testDateTime);
            
        }

        [TestMethod]
        public void TestFileManDateTime()
        {
            DateTime testDate = new DateTime(2014, 6, 6);

            string filemanDate = Util.GetFileManDate(testDate);

            DateTime processedDate = Util.GetDateTime(filemanDate);

            Assert.AreEqual(testDate.Date, processedDate.Date);
        }
        
        [TestMethod]
        public void TestFileManDateTime2()
        {
            string filemanDate = "3160720.135";

            DateTime processedDate = Util.GetDateTime(filemanDate);

            Assert.AreNotEqual(DateTime.MinValue, processedDate); 
        }
    }
}
