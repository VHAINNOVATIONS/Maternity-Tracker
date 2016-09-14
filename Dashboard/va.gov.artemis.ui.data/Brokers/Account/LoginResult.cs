using VA.Gov.Artemis.UI.Data.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using VA.Gov.Artemis.UI.Data.Models.Account;
using VA.Gov.Artemis.UI.Data.Brokers.Common; 

namespace VA.Gov.Artemis.UI.Data.Brokers.Account
{
    public class LoginResult: BrokerOperationResult
    {
        public Login LoginData { get; set; }

        public LoginResult()
        {
            this.LoginData = new Login(); 
        }
    }
}