// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using VA.Gov.Artemis.UI.Controllers;
using System.Web.Mvc;
using System.Web;
using VA.Gov.Artemis.UI.Data.Models;
using VA.Gov.Artemis.UI.Data.Brokers;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Commands.Xus;
using System.Collections.Generic;
using VA.Gov.Artemis.UI.Mock;
using VA.Gov.Artemis.UI.Data.Models.Account;
using VA.Gov.Artemis.UI.Data.Brokers.Common;
using System.Configuration;

namespace VA.Gov.Artemis.UI.Tests
{
    [TestClass]
    public class TestAccountController
    {
        protected string[] ValidAccessCodes
        {
            get
            {
                string concatenated = ConfigurationManager.AppSettings["validAccessCodes"];

                return concatenated.Split(',');
            }
        }

        protected string[] ValidVerifyCodes
        {
            get
            {
                string concatenated = ConfigurationManager.AppSettings["validVerifyCodes"];

                return concatenated.Split(',');
            }
            set
            {
                string concatenated = string.Join(",", value);

                Configuration config = ConfigurationManager.OpenExeConfiguration(ConfigurationUserLevel.None);

                config.AppSettings.Settings["validVerifyCodes"].Value = concatenated;

                config.Save();

                //ConfigurationManager.AppSettings["validVerifyCodes"] = concatenated; 

            }
        }

        [TestMethod]
        public void TestLoginGetAuthenticated()
        {
            MockRpcBroker broker = new MockRpcBroker(); 

            AccountController controller = new AccountController(broker);

            int timeout; 
            ActionResult result = controller.ProcessLoginGet(true, "", out timeout);

            // *** Acceptible results ***
            Assert.IsNotNull(result);
            Assert.IsInstanceOfType(result, typeof(RedirectToRouteResult));
            RedirectToRouteResult routeResult = (RedirectToRouteResult)result;
            Assert.AreEqual("PatientList", routeResult.RouteValues["controller"]);
            Assert.AreEqual("Dashboard", routeResult.RouteValues["action"]);
            
        }

        //[TestMethod]
        //public void TestLoginGetNotAuthenticated()
        //{
        //    IRpcBroker broker = MockRpcBrokerFactory.GetLoginSuccessBroker();

        //    AccountController controller = new AccountController(broker);

        //    int timeout;
        //    string returnUrl = "something"; 
        //    ActionResult result = controller.ProcessLoginGet(false, returnUrl, out timeout);

        //    // *** Acceptible results ***
        //    Assert.IsNotNull(result);
        //    Assert.IsInstanceOfType(result, typeof(ViewResult));
        //    ViewResult viewResult = (ViewResult)result;
        //    Assert.IsInstanceOfType(viewResult.Model, typeof(Login));
        //    Login login = (Login) viewResult.Model;
        //    Assert.AreEqual(returnUrl, login.RequestedUrl); ;
        //    Assert.IsFalse(string.IsNullOrWhiteSpace(login.IntroMessage));
        //    Assert.IsFalse(string.IsNullOrWhiteSpace(login.Port));
        //    Assert.IsFalse(string.IsNullOrWhiteSpace(login.Server));
        //    Assert.IsFalse(string.IsNullOrWhiteSpace(login.UCI));
        //    Assert.IsFalse(string.IsNullOrWhiteSpace(login.Volume));

        //    // TODO: If testing with broker...
        //    //Assert.IsTrue(BrokerStore.Count > 0);
        //}

        //[TestMethod]
        //public void TestLoginGetNotAuthenticatedNoResult()
        //{
        //    IRpcBroker broker = MockRpcBrokerFactory.GetDisconnectedBroker();

        //    AccountController controller = new AccountController(broker);

        //    int timeout;
        //    string returnUrl = "something";
        //    ActionResult result = controller.ProcessLoginGet(false, returnUrl, out timeout);

        //    // *** Acceptible results ***
        //    Assert.IsNotNull(result);
        //    Assert.IsInstanceOfType(result, typeof(RedirectToRouteResult));

        //    RedirectToRouteResult redirectResult = (RedirectToRouteResult)result;

        //    Assert.AreEqual("Home", redirectResult.RouteValues["controller"], "wrong controller");
        //    Assert.AreEqual("Index", redirectResult.RouteValues["action"], "wrong action");

        //}


        [TestMethod]
        public void TestLoginPostInvalidModelState()
        {
            IRpcBroker broker = MockRpcBrokerFactory.GetLoginPostBroker(true);

            AccountController controller = new AccountController(broker);

            bool modelStateValid = false ;
            int timeout = 0;
            string authorizedUser = "";
            Login loginModel = new Login()
            {
                UserName = ValidAccessCodes[0],
                VerifyCode = "JFKDSJFLDSJF"
            };

            List<XusDivision> divisions;

            ActionResult returnResult = controller.ProcessLoginPost(modelStateValid, loginModel, out timeout, out authorizedUser, out divisions);

            Assert.IsInstanceOfType(returnResult, typeof(ViewResult));
            ViewResult viewResult = (ViewResult)returnResult;
            Assert.IsInstanceOfType(viewResult.Model, typeof(Login)); 
        }

        [TestMethod]
        public void TestLoginPostInvalidVerify()
        {
            IRpcBroker broker = MockRpcBrokerFactory.GetLoginPostBroker(false);

            AccountController controller = new AccountController(broker);

            bool modelStateValid = true;
            int timeout = 0;
            string authorizedUser = "";
            Login loginModel = new Login()
            {
                UserName = ValidAccessCodes[0],
                VerifyCode = ""
            };

            List<XusDivision> divisions;

            ActionResult returnResult = controller.ProcessLoginPost(modelStateValid, loginModel, out timeout, out authorizedUser, out divisions);

            Assert.IsInstanceOfType(returnResult, typeof(ViewResult));
            ViewResult viewResult = (ViewResult)returnResult;
            Assert.IsInstanceOfType(viewResult.Model, typeof(Login)); 

        }

        //[TestMethod]
        //public void TestChangeVerifyCodeGet()
        //{
        //    AccountController controller = new AccountController();

        //    string expectedLink = "anything"; 

        //    ActionResult result = controller.ChangeVerifyCode(expectedLink);

        //    Assert.IsNotNull(result);
        //    Assert.IsInstanceOfType(result, typeof(ViewResult));
        //    ViewResult viewResult = (ViewResult)result;
        //    Assert.IsInstanceOfType(viewResult.Model, typeof(ChangeVerifyCode));
        //    ChangeVerifyCode cvc = (ChangeVerifyCode)viewResult.Model;
        //    Assert.AreEqual(cvc.RequestedUrl, expectedLink);

        //}

        //[TestMethod]
        //public void TestChangeVerifyCodePost_SuccessUnauthorized()
        //{
        //    string testUrl = "/lskfj"; 

        //    IRpcBroker broker = MockRpcBrokerFactory.GetChangeVerifyCodePostBroker(true);

        //    AccountController controller = new AccountController(broker);

        //    ChangeVerifyCode cvc = new ChangeVerifyCode()
        //    {
        //        OriginalVerifyCode = "",
        //        NewVerifyCode = "",
        //        ConfirmVerifyCode = "", 
        //        RequestedUrl = testUrl
        //    };

        //    int timeout = 0;
        //    string authorizedUser = ""; 

        //    ActionResult result = controller.ProcessChangeVerifyCodePost(cvc, true, false, out timeout, out authorizedUser);

        //    Assert.IsNotNull(result);
        //    Assert.IsInstanceOfType(result, typeof(RedirectResult));
        //    RedirectResult redirResult = (RedirectResult)result;
        //    Assert.AreEqual("~" + testUrl, redirResult.Url);
        //    Assert.IsTrue(timeout > 0);
        //    Assert.IsFalse(string.IsNullOrWhiteSpace(authorizedUser));

        //}

        [TestMethod]
        public void TestChangeVerifyCodePost_InvalidModelState()
        {
            string testUrl = "/lskfj";

            IRpcBroker broker = MockRpcBrokerFactory.GetChangeVerifyCodePostBroker(true);

            AccountController controller = new AccountController(broker);

            ChangeVerifyCode cvc = new ChangeVerifyCode()
            {
                OriginalVerifyCode = "",
                NewVerifyCode = "",
                ConfirmVerifyCode = "",
                RequestedUrl = testUrl
            };

            int timeout = 0;
            string authorizedUser = "";

            ActionResult result = controller.ProcessChangeVerifyCodePost(cvc, false, false, out timeout, out authorizedUser);

            Assert.IsNotNull(result);
            Assert.IsInstanceOfType(result, typeof(ViewResult));
            ViewResult viewResult = (ViewResult)result;
            Assert.IsInstanceOfType(viewResult.Model, typeof(ChangeVerifyCode));
        }

        [TestMethod]
        public void TestChangeVerifyCodePost_SuccessAuthorized()
        {
            string testUrl = "/lskfj"; 

            IRpcBroker broker = MockRpcBrokerFactory.GetChangeVerifyCodePostBroker(true);

            AccountController controller = new AccountController(broker);

            ChangeVerifyCode cvc = new ChangeVerifyCode()
            {
                OriginalVerifyCode = "",
                NewVerifyCode = "",
                ConfirmVerifyCode = "", 
                RequestedUrl = testUrl
            };

            int timeout = 0;
            string authorizedUser = ""; 

            ActionResult result = controller.ProcessChangeVerifyCodePost(cvc, true, true, out timeout, out authorizedUser);

            Assert.IsNotNull(result);
            Assert.IsInstanceOfType(result, typeof(RedirectToRouteResult));
            RedirectToRouteResult routeResult = (RedirectToRouteResult)result;
            Assert.AreEqual("Home", routeResult.RouteValues["controller"]);
            Assert.AreEqual("Index", routeResult.RouteValues["action"]);
            Assert.IsTrue(timeout > 0);
            Assert.IsTrue(string.IsNullOrWhiteSpace(authorizedUser));

        }

        [TestMethod]
        public void TestChangeVerifyCodePost_FailedChange()
        {
            string testUrl = "/lskfj";

            IRpcBroker broker = MockRpcBrokerFactory.GetChangeVerifyCodePostBroker(false);

            AccountController controller = new AccountController(broker);

            ChangeVerifyCode cvc = new ChangeVerifyCode()
            {
                OriginalVerifyCode = "",
                NewVerifyCode = "",
                ConfirmVerifyCode = "",
                RequestedUrl = testUrl
            };

            int timeout = 0;
            string authorizedUser = "";

            ActionResult result = controller.ProcessChangeVerifyCodePost(cvc, true, false, out timeout, out authorizedUser);

            Assert.IsNotNull(result);
            Assert.IsInstanceOfType(result, typeof(ViewResult));
            ViewResult viewResult = (ViewResult)result;
            Assert.IsInstanceOfType(viewResult.Model, typeof(ChangeVerifyCode));
        }

        [TestMethod]
        public void TestChangeVerifyCodePost_NoUser()
        {
            string testUrl = "/lskfj";

            IRpcBroker broker = MockRpcBrokerFactory.GetChangeVerifyCodePostBroker(true, false);

            AccountController controller = new AccountController(broker);

            ChangeVerifyCode cvc = new ChangeVerifyCode()
            {
                OriginalVerifyCode = "",
                NewVerifyCode = "",
                ConfirmVerifyCode = "",
                RequestedUrl = testUrl
            };

            int timeout = 0;
            string authorizedUser = "";

            ActionResult result = controller.ProcessChangeVerifyCodePost(cvc, true, true, out timeout, out authorizedUser);

            Assert.IsNotNull(result);
            Assert.IsInstanceOfType(result, typeof(RedirectToRouteResult));
            RedirectToRouteResult routeResult = (RedirectToRouteResult)result;
            Assert.AreEqual("Home", routeResult.RouteValues["controller"]);
            Assert.AreEqual("Index", routeResult.RouteValues["action"]);
            Assert.IsTrue(timeout > 0);
            Assert.IsTrue(string.IsNullOrWhiteSpace(authorizedUser));

        }

        [TestCleanup]
        public void Cleanup()
        {
            BrokerStore.Cleanup();
        }
    }


}
