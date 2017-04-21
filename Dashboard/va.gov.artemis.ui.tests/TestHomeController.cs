// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using VA.Gov.Artemis.UI.Controllers;
using System.Web.Mvc;
using VA.Gov.Artemis.UI.Data.Models;
using VA.Gov.Artemis.UI.Data.Models.Home;

namespace VA.Gov.Artemis.UI.Tests
{
    [TestClass]
    public class TestHomeController
    {
        [TestMethod]
        public void TestIndex()
        {
            HomeController controller = new HomeController();

            ActionResult result = controller.Index();

            Assert.IsNotNull(result);
            Assert.IsInstanceOfType(result, typeof(ViewResult));
            ViewResult viewResult = (ViewResult)result;
            Assert.IsInstanceOfType(viewResult.Model, typeof(HomeData));
            HomeData homeData = (HomeData)viewResult.Model;
            Assert.IsFalse(string.IsNullOrWhiteSpace(homeData.AccessHelpLink));
            Assert.IsFalse(string.IsNullOrWhiteSpace(homeData.WelcomeMessage));
            Assert.IsFalse(string.IsNullOrWhiteSpace(homeData.ProductDescription));

        }
    }
}
