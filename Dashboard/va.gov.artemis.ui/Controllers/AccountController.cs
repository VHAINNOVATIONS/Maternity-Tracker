using VA.Gov.Artemis.UI.Filters;
using System.Web.Mvc;
using System.Web.Security;
using VA.Gov.Artemis.Core;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Commands.Xus;
using System.Collections.Generic;
using System.Web.Routing;
using VA.Gov.Artemis.UI.Data.Models.Account;
using VA.Gov.Artemis.UI.Data.Brokers.Account;
using VA.Gov.Artemis.UI.Data.Brokers.Common;
using VA.Gov.Artemis.UI.Data.Brokers.Division;

namespace VA.Gov.Artemis.UI.Controllers
{
    [DisableLocalCache]
    public partial class AccountController : DashboardController
    {
        // *** Default constructor used by MVC ***
        public AccountController() : base() { }

        // *** Broker constructor for testing with mock broker ***
        public AccountController(IRpcBroker broker): base(broker) {}
                
        //private string defaultAction = "All"; 
        private string defaultAction = "Dashboard"; 

        [HttpGet]
        [AllowAnonymous]
        public ActionResult Login()
        {
            // *** Begin login process ***

            ActionResult returnResult = null;

            // *** Prepare parameters ***
            string returnUrl = Request.QueryString["ReturnUrl"];
            bool alreadyAuthenticated = this.UserIsAuthenticated();
            int timeout = 2; 

            // *** Process the request ***
            returnResult = ProcessLoginGet(alreadyAuthenticated, returnUrl, out timeout);

            // *** Set timeout ***
            if (timeout > 525600)
                timeout = 525600;

            // *** Set timeout ***
            VistaLogger.Log(string.Format("Setting Session Timeout to {0} minutes", timeout), "", -1, null, ""); 
            Session.Timeout = timeout; 
        
            // TODO: Remove AUTO LOGIN ! ...
            //returnResult = AutoLogin(); 

            // *** Return
            return returnResult;
        }

        [NonAction]
        public ActionResult ProcessLoginGet(bool userAuthenticated, string returnUrl, out int timeout)
        {
            // *** Begin login process ***

            ActionResult returnResult = null;

            // *** Set default timeout for login to 2 minutes ***
            timeout = 2; 

            // *** Check if already logged in ***
            if (userAuthenticated)
            {
                this.Information("You are already logged in");

                returnResult = RedirectToAction(defaultAction, "PatientList");
            }
            else
            {
                if (this.CreateBroker())
                {
                    // *** Get the login data ***
                    LoginResult loginResult = this.DashboardRepository.Accounts.GetLoginData();

                    // *** Check if successful ***
                    if (loginResult.Success)
                    {
                        // *** Add the requested url ***
                        loginResult.LoginData.RequestedUrl = returnUrl;

                        // *** Return the default view ***
                        returnResult = View(loginResult.LoginData);
                    }
                    else
                    {
                        //string msg = (string.IsNullOrWhiteSpace(loginResult.Message)) ? "Could not initiate login" : loginResult.Message;
                        //this.Error(msg);
                        this.Error("Could not initiate connection to VistA");
                        this.CloseBroker(); 
                        ErrorLogger.Log("AccountController.Login: Could not retrieve login information");
                        returnResult = RedirectToAction("Index", "Home");
                    }
                }
                else
                {
                    this.Error("Could not connect to VistA");
                    ErrorLogger.Log("AccountController.ProcessLoginGet: Could not connect to broker");
                    returnResult = RedirectToAction("Index", "Home");
                }
            }

            return returnResult;
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        [VerifySession]
        [AllowAnonymous]
        public ActionResult Login(Login loginModel)
        {
            // *** Login Post Action ***

            ActionResult returnResult = null;

            // *** Prepare parameters for processing ***
            bool modelStateValid = ModelState.IsValid; 
            int timeout = 0;
            string authorizedUser = "";
            List<XusDivision> divisions; 

            // *** Process the request ***
            returnResult = ProcessLoginPost(modelStateValid, loginModel, out timeout, out authorizedUser, out divisions);

            // *** Set authorized user ***
            if (!string.IsNullOrWhiteSpace(authorizedUser))
                FormsAuthentication.SetAuthCookie(authorizedUser, false);

            VistaLogger.Log(string.Format("Setting Session Timeout to {0} minutes", timeout), "", -1, null, ""); 
            Session.Timeout = timeout;

            // TODO: Timeout testing...
            //Session.Timeout = 1; 

            // *** Place divisions in session ***
            if (divisions != null)
                TempData[DivisionDataKey] = divisions; // Session["DivisionData"] = divisions;

            return returnResult; 
        }

        [NonAction]
        public ActionResult ProcessLoginPost(bool modelStateValid, Login loginModel, out int timeout, out string authorizedUser, out List<XusDivision> divisions)
        {
            // *** Attempt to login with AV Codes ***

            ActionResult returnResult = null;

            // *** Default return values ***
            timeout = 2;
            authorizedUser = "";
            divisions = null; 

            // *** Check model state ***
            if (modelStateValid)
            {
                // *** Determine if user wants to change v code ***
                bool userChangeVerify = loginModel.ChangeVerifyCode;

                // *** Do login ***
                LoginResult loginResult = this.DashboardRepository.Accounts.PerformLogin(loginModel);

                 // *** This indicates vista requires change of v code ***
                if (loginResult.LoginData.ChangeVerifyCode)
                {
                    this.Information(loginResult.Message);
                    returnResult = RedirectToAction("ChangeVerifyCode", new { @requestedurl = loginModel.RequestedUrl });
                }
                else
                {
                    // *** Check result ***
                    if (loginResult.Success)
                    {
                        // *** Set authorization cookie indicating logged in ***
                        authorizedUser = loginResult.LoginData.UserName;

                        // *** For user cvc, use a redirect ***
                        if (userChangeVerify)
                            returnResult = RedirectToAction("ChangeVerifyCode");
                        else
                        {
                            // *** Check if need to select division ***
                            DivisionResult divisionResult = this.DashboardRepository.Divisions.GetList();

                            // *** If we have multiple divisions available, allow selection ***
                            if (divisionResult.Success)
                            {
                                if (divisionResult.Divisions != null)
                                    if (divisionResult.Divisions.Count > 0)
                                    {
                                        // *** Keep data temporarily in session ***
                                        divisions = divisionResult.Divisions;

                                        // *** Flag that this is pending ***
                                        TempData["DivSelectPending"] = "true"; 

                                        // *** Redirect to division controller ***
                                        returnResult = RedirectToAction("Select", "Division");
                                    }
                            }
                            else
                                this.Error("Could not get a list of divisions: " + divisionResult.Message);

                            // *** If still no redirect... ***
                            if (returnResult == null)
                            {
                                // *** Check that user has the proper context ***
                                BrokerOperationResult result = this.DashboardRepository.Accounts.CreateContext();

                                if (!result.Success)
                                {
                                    //this.Error(result.Message);
                                    //this.CloseBroker();
                                    //authorizedUser = "";
                                    //returnResult = RedirectToAction("Login");
                                    returnResult = RedirectToAction("NoContext"); 
                                }
                                else
                                {
                                    // *** Set the session timeout based on value in vista ***                            
                                    int timeoutInSeconds = this.DashboardRepository.Accounts.GetUserTimeout();

                                    // *** Set timeout ***
                                    if (timeoutInSeconds > 525600)
                                        timeoutInSeconds = 525600;

                                    // *** Convert timeout to minutes ***
                                    timeout = timeoutInSeconds / 60; 

                                    if (!string.IsNullOrWhiteSpace(loginModel.RequestedUrl))
                                        returnResult = Redirect(loginModel.RequestedUrl); // *** Redirect to original url ***                    
                                    else
                                        returnResult = RedirectToAction(defaultAction, "PatientList");
                                }
                            }
                        }
                    }
                    else
                        returnResult = this.View(loginModel);                    
                }
            }
            else
            {
                loginModel.LoginMessage = "Access Code and Verify Code are both required";
                returnResult = this.View(loginModel);
            }

            return returnResult; 
        }

        [HttpGet]
        [AllowAnonymous]
        public ActionResult Logout()
        {
            // *** Sign out ***

            this.CloseBroker(); 

            FormsAuthentication.SignOut();

            Session.Abandon(); 
                        
            return RedirectToAction("Index", "Home");
        }

        [VerifySession]
        [HttpGet]
        [AllowAnonymous]
        public ActionResult ChangeVerifyCode(string requestedurl)
        {
            // *** Show the change v code view ***

            ActionResult returnResult; 

            ChangeVerifyCode cvcD = new ChangeVerifyCode();

            cvcD.RequestedUrl = Request.UrlReferrer.AbsolutePath; 

            returnResult = View(cvcD); 

            return returnResult; 
        }

        [HttpPost]
        [ValidateAntiForgeryToken]        
        [VerifySession]
        [AllowAnonymous]
        public ActionResult ChangeVerifyCode(ChangeVerifyCode changeVerifyCodeData)
        {
            // *** Change Verify Code Post Action ***

            ActionResult returnResult = null; 

            // *** Prepare the data needed for processing ***
            bool modelStateValid = this.ModelState.IsValid;
            bool isAuthenticated = this.User.Identity.IsAuthenticated;
            int timeout = 0;
            string authorizedUser = ""; 

            // *** Process the request ***
            returnResult = ProcessChangeVerifyCodePost(changeVerifyCodeData, modelStateValid, isAuthenticated, out timeout, out authorizedUser);

            // *** Set timeout ***
            if (timeout > 525600)
                timeout = 525600; 

            // *** Set timeout ***
            if (timeout > 0)
            {
                VistaLogger.Log(string.Format("Setting Session Timeout to {0} minutes", timeout), "", -1, null, ""); 
                Session.Timeout = timeout;
            }

            // *** Set authorized user ***
            if (!string.IsNullOrWhiteSpace(authorizedUser))
                FormsAuthentication.SetAuthCookie(authorizedUser, false);

            return returnResult; 
        }

        [HttpPost]
        [AllowAnonymous]
        public ActionResult ImHere()
        {
            BrokerOperationResult result = this.DashboardRepository.Accounts.ImHere();

            return new JsonResult() { Data = new { TimeoutMinutes = this.Session.Timeout } };
        }

        [HttpGet]
        [AllowAnonymous]
        public ActionResult NoContext()
        {
            this.CloseBroker();
            FormsAuthentication.SignOut();
            Session.Abandon();

            this.Error("The user does not have the required secondary menu context, DSIO GUI CONTEXT"); 

            return View(); 
        }

        [NonAction]
        public ActionResult ProcessChangeVerifyCodePost(ChangeVerifyCode changeVerifyCodeData, bool modelStateValid, bool isAuthenticated, out int timeout, out string authorizedUser)
        {
            // *** Change the verify code ***

            ActionResult returnResult = null;

            // *** Default return values ***
            timeout = 2;
            authorizedUser = "";

            // *** Check model state ***
            if (modelStateValid)
            {
                // *** Change VC ***
                BrokerOperationResult opResult = this.DashboardRepository.Accounts.ChangeVerifyCode(changeVerifyCodeData);
                                
                changeVerifyCodeData.Message = opResult.Message; 

                // *** Check result ***
                if (opResult.Success)
                {
                    // *** If the user is not authenticated yet, do it now ***
                    if (isAuthenticated == false)
                    {
                        // *** Get the user data ***
                        UserResult userResult = this.DashboardRepository.Accounts.GetUserData();

                        // *** Check success ***
                        if (userResult.Success)
                        {
                            // *** Check that user has the proper context ***
                            BrokerOperationResult result = this.DashboardRepository.Accounts.CreateContext();

                            if (!result.Success)
                            {
                                //this.Error(result.Message);
                                //this.CloseBroker();
                                //authorizedUser = "";
                                //returnResult = RedirectToAction("Login");
                                returnResult = RedirectToAction("NoContext"); 
                            }
                            else
                            {
                                // *** Set the session timeout based on value in vista ***                            
                                int timeoutInSeconds = this.DashboardRepository.Accounts.GetUserTimeout();

                                // *** Set timeout ***
                                if (timeoutInSeconds > 525600)
                                    timeoutInSeconds = 525600;

                                // *** Convert timeout to minutes ***
                                timeout = timeoutInSeconds / 60; 

                                // *** Set authorization cookie indicating logged in ***
                                authorizedUser = userResult.UserData.UserName;

                                this.Information("Your verify code has been changed");

                                // *** Redirect to original url ***
                                returnResult = Redirect(changeVerifyCodeData.RequestedUrl);
                            }
                        }
                        else
                        {
                            this.Error("Your verify code has been changed; but the user information could not be obtained.  Please log in again.");
                            returnResult = RedirectToAction("Index", "Home");
                        }
                    }
                    else
                    {
                        this.Information("Your verify code has been changed");
                        returnResult = RedirectToAction("Index", "Home");
                    }
                }
                else
                    returnResult = this.View(changeVerifyCodeData);

            }
            else
            {
                changeVerifyCodeData.Message = "All fields are required.";
                returnResult = this.View(changeVerifyCodeData);
            }

            return returnResult; 
        }

        private bool UserIsAuthenticated()
        {            
            bool returnVal = false;

            if (this.User != null)
                if (this.User.Identity != null)
                    if (this.User.Identity.IsAuthenticated)
                        returnVal = true; 

            return returnVal; 
        }



    }

}
