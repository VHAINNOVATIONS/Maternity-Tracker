using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.UI.Mock;
using VA.Gov.Artemis.UI.Controllers;
using System.Web.Mvc;
using VA.Gov.Artemis.UI.Data.Models;

namespace VA.Gov.Artemis.UI.Tests
{
    [TestClass]
    public class TestPatientSearchController
    {
        [TestMethod]
        public void TestPatientSearchGet()
        {
            IRpcBroker broker = new MockRpcBroker(); 

            PatientSearchController controller = new PatientSearchController(broker);

            ActionResult result = controller.Search("", "");

            Assert.IsNotNull(result);
            Assert.IsInstanceOfType(result, typeof(ViewResult));             

        }

        //[TestMethod]
        //public void TestPatientSearchPost()
        //{
        //    // TODO: Need URL and TempData mocked to test this controller action...

        //    IRpcBroker broker = MockRpcBrokerFactory.GetDsioFemalePatientSearchBroker();

        //    PatientSearchController controller = new PatientSearchController(broker);

        //    PatientSearch patSearchModel = new PatientSearch() { SearchCriteria = "abc" };

        //    ActionResult result = controller.Search("abc","");

        //    Assert.IsNotNull(result);
        //    Assert.IsInstanceOfType(result, typeof(ViewResult));
        //    ViewResult viewResult = (ViewResult)result;
        //    Assert.IsInstanceOfType(viewResult.Model, typeof(PatientSearch));
        //    PatientSearch patSearchResult = (PatientSearch)viewResult.Model;
        //    Assert.IsNotNull(patSearchResult.Patients);
        //    Assert.IsTrue(patSearchResult.Patients.Count > 0);
        //}
    }
}
