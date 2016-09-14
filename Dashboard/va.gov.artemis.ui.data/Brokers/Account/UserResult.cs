using VA.Gov.Artemis.UI.Data.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using VA.Gov.Artemis.UI.Data.Models.Account;
using VA.Gov.Artemis.UI.Data.Brokers.Common; 

namespace VA.Gov.Artemis.UI.Data.Brokers.Account
{
    public class UserResult: BrokerOperationResult
    {
        public User UserData { get; set; }

        public UserResult()
        {
            this.UserData = new User(); 
        }

    }
}