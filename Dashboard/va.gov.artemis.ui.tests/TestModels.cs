using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using VA.Gov.Artemis.UI.Data.Models.Common;

namespace VA.Gov.Artemis.UI.Tests
{
    [TestClass]
    public class TestModels
    {
        [TestMethod]
        public void TestDateDescription()
        {
            BasePatient pat = new BasePatient();

            pat.LastContactDate = DateTime.Now;
            Assert.AreEqual("Today", pat.LastContactDescription);

            pat.LastContactDate = DateTime.Now.AddDays(-1);
            Assert.AreEqual("Yesterday", pat.LastContactDescription);

            pat.LastContactDate = DateTime.Now.AddDays(1);
            Assert.AreEqual("Tomorrow", pat.LastContactDescription);

            pat.LastContactDate = DateTime.Now.AddDays(5);
            Assert.AreEqual("In 5 Days", pat.LastContactDescription);

            pat.LastContactDate = DateTime.Now.AddDays(14);
            Assert.AreEqual("In 2 Weeks", pat.LastContactDescription);

            pat.LastContactDate = DateTime.Now.AddDays(77);
            Assert.AreEqual("In 2 Months", pat.LastContactDescription);

            pat.LastContactDate = DateTime.Now.AddDays(740);
            Assert.AreEqual("In 2 Years", pat.LastContactDescription);

            pat.LastContactDate = DateTime.Now.AddDays(-5);
            Assert.AreEqual("5 Days Ago", pat.LastContactDescription);

            pat.LastContactDate = DateTime.Now.AddDays(-14);
            Assert.AreEqual("2 Weeks Ago", pat.LastContactDescription);

            pat.LastContactDate = DateTime.Now.AddDays(-77);
            Assert.AreEqual("2 Months Ago", pat.LastContactDescription);

            pat.LastContactDate = DateTime.Now.AddDays(-740);
            Assert.AreEqual("2 Years Ago", pat.LastContactDescription);
        }
    }
}
