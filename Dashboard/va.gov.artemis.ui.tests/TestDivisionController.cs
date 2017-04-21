// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using VA.Gov.Artemis.UI.Controllers;
using VA.Gov.Artemis.Vista.Broker;
using System.Web.Mvc;
using System.Collections.Generic;
using VA.Gov.Artemis.Commands.Xus;
using VA.Gov.Artemis.UI.Mock;

namespace VA.Gov.Artemis.UI.Tests
{
    [TestClass]
    public class TestDivisionController
    {
        //[TestMethod]
        //public void TestSelectGetBroker()
        //{
        //    IRpcBroker broker = MockRpcBrokerFactory.GetXusDivisionGetBroker(true);

        //    DivisionController controller = new DivisionController(broker);

        //    ActionResult result = controller.Select();

        //    Assert.IsNotNull(result);
        //    Assert.IsInstanceOfType(result, typeof(ViewResult));
        //    ViewResult viewResult = (ViewResult)result;
        //    Assert.IsInstanceOfType(viewResult.Model, typeof(List<XusDivision>));
        //    List<XusDivision> divs = (List<XusDivision>)viewResult.Model;
        //    Assert.IsTrue(divs.Count > 0);
        //}

        //[TestMethod]
        //public void TestSelectGetTempData()
        //{
        //    IRpcBroker broker = MockRpcBrokerFactory.GetXusDivisionGetBroker(true);

        //    DivisionController controller = new DivisionController(broker);

        //    controller.TempData[DashboardController.DivisionDataKey] = new List<XusDivision>()
        //    {
        //        new XusDivision() { ID = "2", Name = "something", StationNumber="232"}, 
        //        new XusDivision() { ID = "1", Name = "else", StationNumber="43"}
        //    };

        //    ActionResult result = controller.Select();

        //    Assert.IsNotNull(result);
        //    Assert.IsInstanceOfType(result, typeof(ViewResult));
        //    ViewResult viewResult = (ViewResult)result;
        //    Assert.IsInstanceOfType(viewResult.Model, typeof(List<XusDivision>));
        //    List<XusDivision> divs = (List<XusDivision>)viewResult.Model;
        //    Assert.IsTrue(divs.Count > 0);
        //    Assert.AreEqual("something", divs[0].Name);
        //}

        //[TestMethod]
        //public void TestSelectPost()
        //{

        // TODO: Need session object to test...

        //    IRpcBroker broker = MockRpcBrokerFactory.GetXusDivisionSetBroker(true);

        //    DivisionController controller = new DivisionController(broker);

        //    FormCollection formCollection = new FormCollection();

        //    formCollection["division.IsDefault"] = "1";

        //    ActionResult result = controller.Select(formCollection);

        //    Assert.IsNotNull(result);
        //    Assert.IsInstanceOfType(result, typeof(RedirectToRouteResult));
        //    RedirectToRouteResult routeResult = (RedirectToRouteResult)result;
        //    Assert.AreEqual("TrackedPatient", routeResult.RouteValues["controller"]);
        //    Assert.AreEqual("Index", routeResult.RouteValues["action"]);
            
        //}

        [TestMethod]
        public void TestSelectPost_NoSelection()
        {
            IRpcBroker broker = MockRpcBrokerFactory.GetXusDivisionSetBroker(true);

            DivisionController controller = new DivisionController(broker);

            FormCollection formCollection = new FormCollection();

            ActionResult result = controller.Select(formCollection);

            Assert.IsNotNull(result);
            Assert.IsInstanceOfType(result, typeof(RedirectToRouteResult));
            RedirectToRouteResult routeResult = (RedirectToRouteResult)result;
            Assert.AreEqual("Select", routeResult.RouteValues["action"]);

        }
        
        [TestMethod]
        public void TestSelectPostFailure()
        {
            IRpcBroker broker = MockRpcBrokerFactory.GetXusDivisionSetBroker(false);

            DivisionController controller = new DivisionController(broker);

            FormCollection formCollection = new FormCollection();

            ActionResult result = controller.Select(formCollection);

            Assert.IsNotNull(result);
            Assert.IsInstanceOfType(result, typeof(RedirectToRouteResult));
            RedirectToRouteResult routeResult = (RedirectToRouteResult)result;
            Assert.AreEqual("Select", routeResult.RouteValues["action"]);

        }
    }
}
