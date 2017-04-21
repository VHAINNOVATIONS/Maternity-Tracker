// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using VA.Gov.Artemis.UI.Data.Brokers.Common;
using VA.Gov.Artemis.UI.Data.Models;
using VA.Gov.Artemis.UI.Data.Models.Account;

namespace VA.Gov.Artemis.UI.Data.Brokers.Account
{
    public interface IAccountRepository
    {
        LoginResult GetLoginData();

        LoginResult PerformLogin(Login loginData);

        UserResult GetUserData();

        BrokerOperationResult ChangeVerifyCode(ChangeVerifyCode changeVerifyCodeData);

        int GetUserTimeout();

        BrokerOperationResult CreateContext();

        BrokerOperationResult ImHere();
    }
}
