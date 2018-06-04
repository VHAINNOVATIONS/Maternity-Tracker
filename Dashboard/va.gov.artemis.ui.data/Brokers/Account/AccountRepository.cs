// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Vista.Commands.Orwu;
using VA.Gov.Artemis.Commands.Xus;
using VA.Gov.Artemis.UI.Data.Models;
using VA.Gov.Artemis.Commands.Orwu;
using System.Configuration;
using VA.Gov.Artemis.UI.Data.Models.Account;
using VA.Gov.Artemis.UI.Data.Brokers.Common;
using VA.Gov.Artemis.Commands.Xwb; 

namespace VA.Gov.Artemis.UI.Data.Brokers.Account
{
    public class AccountRepository: RepositoryBase, IAccountRepository 
    {
        public AccountRepository(IRpcBroker newBroker): base(newBroker) {}

        public LoginResult GetLoginData()
        {
            // *** Get the login setup ***

            LoginResult returnVal = new LoginResult();

            if (this.broker != null)
            {
                // *** Signon Setup ***
                XusSignonSetupCommand setupCmd = new XusSignonSetupCommand(this.broker);
                setupCmd.Execute();

                // *** Check status ***
                if (setupCmd.Response.Status == RpcResponseStatus.Success)
                {
                    returnVal.LoginData.SetSignonSetup(setupCmd.SignonSetup);

                    // *** Get Intro Message ***
                    XusIntroMsgCommand cmdIntro = new XusIntroMsgCommand(this.broker);
                    cmdIntro.Execute();

                    // *** Check status ***
                    if (cmdIntro.Response.Status == RpcResponseStatus.Success)
                    {
                        // *** Set the login message ***
                        returnVal.LoginData.IntroMessage = cmdIntro.Response.Data;

                        returnVal.SetResult(true, ""); 
                    }
                    else
                    {
                        returnVal.LoginData.IntroMessage = cmdIntro.Response.InformationalMessage;
                        returnVal.SetResult(false, cmdIntro.Response.InformationalMessage); 
                    }
                }
                else
                {
                    returnVal.SetResult(false, setupCmd.Response.InformationalMessage); 
                }
            }
            else
                returnVal.SetResult(false, "No Broker");

            return returnVal;
        }

        public LoginResult PerformLogin(Login loginData)
        {
            LoginResult returnResult = new LoginResult();

            returnResult.LoginData = loginData; 

            if (this.broker != null)
            {
                // *** Verify AV Codes ***
                XusAvCodeCommand avCodeCommand = new XusAvCodeCommand(this.broker);
                avCodeCommand.AddCommandArguments(loginData.AccessCode, loginData.VerifyCode); 
                avCodeCommand.Execute();

                // *** Check status ***
                if (avCodeCommand.Response.Status == RpcResponseStatus.Success)
                {
                    // *** Get user info ***
                    XusGetUserInfoCommand getUserCommand = new XusGetUserInfoCommand(this.broker);
                    getUserCommand.Execute();

                    // *** Check status ***
                    if (getUserCommand.Response.Status == RpcResponseStatus.Success)
                    {
                        loginData.UserName = getUserCommand.UserInfo.StandardName;
                        returnResult.SetResult(true, ""); 
                    }
                    else
                    {
                        loginData.LoginMessage = getUserCommand.Response.InformationalMessage;
                        returnResult.SetResult(false, getUserCommand.Response.InformationalMessage);
                    }
                }
                else
                {
                    loginData.LoginMessage = avCodeCommand.Response.InformationalMessage;
                    returnResult.SetResult(false, avCodeCommand.Response.InformationalMessage);
                }

                if (avCodeCommand.SignonResults.MustChangeVerifyCode == true)
                    loginData.ChangeVerifyCode = avCodeCommand.SignonResults.MustChangeVerifyCode;

            }

            return returnResult;
        }

        public UserResult GetUserData()
        {
            UserResult returnVal = new UserResult();

            if (this.broker != null)
            {
                // *** Get user info ***
                XusGetUserInfoCommand getUserCommand = new XusGetUserInfoCommand(this.broker);
                getUserCommand.Execute();

                // *** Check status ***
                if (getUserCommand.Response.Status == RpcResponseStatus.Success)
                {
                    returnVal.UserData.UserName = getUserCommand.UserInfo.StandardName;
                    returnVal.SetResult(true, "");
                }
                else
                    returnVal.SetResult(false, getUserCommand.Response.InformationalMessage);
            }

            return returnVal;
        }

        //public ChangeVerifyCodeData ChangeVerifyCode(ChangeVerifyCodeData changeVerifyCodeData)
        //{
        //    if (this.broker != null)
        //    {
        //        XusCvcCommand cvcCommand = new XusCvcCommand(this.broker, changeVerifyCodeData.OriginalVerifyCode, changeVerifyCodeData.NewVerifyCode, changeVerifyCodeData.ConfirmVerifyCode);
        //        cvcCommand.Execute();

        //        if (cvcCommand.Response.Status == ResponseStatus.Success)
        //            changeVerifyCodeData.SetLastOperation(true, cvcCommand.Response.InformationalMessage);
        //        else
        //            changeVerifyCodeData.SetLastOperation(false, cvcCommand.Response.InformationalMessage);
        //    }
        //    else
        //        changeVerifyCodeData.SetLastOperation(false, "No valid connection");

        //    return changeVerifyCodeData;
        //}

        public BrokerOperationResult ChangeVerifyCode(ChangeVerifyCode changeVerifyCodeData)
        {
            BrokerOperationResult returnResult = new BrokerOperationResult();

            if (this.broker != null)
            {
                XusCvcCommand cvcCommand = new XusCvcCommand(this.broker);
                
                // *** Make sure everything is upper case ***
                changeVerifyCodeData.OriginalVerifyCode = changeVerifyCodeData.OriginalVerifyCode.ToUpper().Trim();
                changeVerifyCodeData.NewVerifyCode = changeVerifyCodeData.NewVerifyCode.ToUpper().Trim();
                changeVerifyCodeData.ConfirmVerifyCode = changeVerifyCodeData.ConfirmVerifyCode.ToUpper().Trim(); 

                cvcCommand.AddCommandArguments(changeVerifyCodeData.OriginalVerifyCode, changeVerifyCodeData.NewVerifyCode, changeVerifyCodeData.ConfirmVerifyCode);

                RpcResponse response = cvcCommand.Execute();

                if (response.Status == RpcResponseStatus.Success)
                    returnResult.SetResult(true, cvcCommand.Response.InformationalMessage);
                else
                {
                    string message = string.IsNullOrWhiteSpace(cvcCommand.Response.InformationalMessage) ? "An unspecified error has occurred" : cvcCommand.Response.InformationalMessage;
                    returnResult.SetResult(false, message);
                }
            }
            else
                returnResult.SetResult(false, "No valid connection");

            return returnResult;
        }

        public int GetUserTimeout()
        {
            // *** Returns value in seconds ***

            int returnVal = 600;

            if (this.broker != null)
            {
                OrwuUserInfoCommand command = new OrwuUserInfoCommand(broker);
                RpcResponse response = command.Execute();

                if (command.Response.Status == RpcResponseStatus.Success)
                    returnVal = command.UserInfo.Timeout;

            }

            return returnVal;
        }

        public AdminResult GetUserAdmin()
        {
            AdminResult returnVal = new AdminResult();

            if (this.broker != null)
            {
                OrwuHasKeyCommand command = new OrwuHasKeyCommand(broker);

                command.AddCommandArguments("WEBM ADMIN"); 

                command.Execute();

                if (command.Response.Status == RpcResponseStatus.Success)
                    returnVal.UserHasAdminSecurityKey = command.HasKeyResult; 

            }

            return returnVal; 
        }

        public BrokerOperationResult CreateContext()
        {
            BrokerOperationResult result = new BrokerOperationResult();

            string applicationContext = ConfigurationManager.AppSettings["AppContext"];

            if (!string.IsNullOrWhiteSpace(applicationContext))
            {
                RpcResponse response = this.broker.CreateContext(applicationContext);

                result.Success = (response.Status == RpcResponseStatus.Success);
                result.Message = string.Format("The user must have the menu context, '{0},' assigned to them in order to use this application.", applicationContext); 
            }
            else
            {
                result.Success = false;
                result.Message = "Missing application context in configuration file"; 
            }

            return result; 
        }

        /// <summary>
        /// Keeps connection to VistA active 
        /// </summary>
        /// <returns></returns>
        public BrokerOperationResult ImHere()
        {
            BrokerOperationResult result = new BrokerOperationResult();

            // *** Create the command ***
            XwbImHereCommand command = new XwbImHereCommand(this.broker);

            // *** Execute ***
            RpcResponse response = command.Execute();

            // *** Put the comamnd response into the result ***
            result.SetResult(response.Status == RpcResponseStatus.Success, response.InformationalMessage); 

            return result;
        }
    }
}