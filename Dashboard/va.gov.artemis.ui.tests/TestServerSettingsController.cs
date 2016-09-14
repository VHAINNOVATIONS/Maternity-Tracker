using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using VA.Gov.Artemis.UI.Controllers;
using System.Web.Mvc;
using VA.Gov.Artemis.UI.Data.Models;
using VA.Gov.Artemis.UI.Data.Models.ServerSettings;

namespace VA.Gov.Artemis.UI.Tests
{
    [TestClass]
    public class TestServerSettingsController
    {
        [TestMethod]
        public void TestEditGet()
        {
            ServerSettingsController controller = new ServerSettingsController();

            ActionResult result = controller.Edit();

            Assert.IsNotNull(result);
            Assert.IsInstanceOfType(result, typeof(ViewResult));
            ViewResult viewResult = (ViewResult)result;
            Assert.IsInstanceOfType(viewResult.Model, typeof(ServerConfig));
            ServerConfig config = (ServerConfig)viewResult.Model;
            Assert.IsFalse(string.IsNullOrWhiteSpace(config.ServerName));
            Assert.IsTrue(config.ListenerPort > 0);

        }

        [TestMethod]
        public void TestEditPost()
        {
            ServerSettingsController controller = new ServerSettingsController();

            ServerConfig serverConfig = new ServerConfig()
            {
                ServerName = "localhost",
                ListenerPort = 9000
            };

            ActionResult result = controller.ProcessEditGet(serverConfig, true);

            Assert.IsNotNull(result);
            Assert.IsInstanceOfType(result, typeof(RedirectToRouteResult));
            RedirectToRouteResult routeResult = (RedirectToRouteResult)result;
            //Assert.AreEqual("Index", routeResult.RouteValues["action"]);
            //Assert.AreEqual("TrackedPatient", routeResult.RouteValues["controller"]);

        }

        [TestMethod]
        public void TestTestConnection_Valid()
        {
            ServerSettingsController controller = new ServerSettingsController();

            ActionResult result = controller.TestConnection("localhost", "9000");

            Assert.IsNotNull(result);
            Assert.IsInstanceOfType(result, typeof(ContentResult));
            ContentResult contentResult = (ContentResult)result;
            Assert.AreEqual("true", contentResult.Content);
        }

        [TestMethod]
        public void TestTestConnection_Invalid()
        {
            ServerSettingsController controller = new ServerSettingsController();

            ActionResult result = controller.TestConnection("sdfsd", "3");

            Assert.IsNotNull(result);
            Assert.IsInstanceOfType(result, typeof(ContentResult));
            ContentResult contentResult = (ContentResult)result;
            Assert.AreEqual("false", contentResult.Content);
        }

    }
}
