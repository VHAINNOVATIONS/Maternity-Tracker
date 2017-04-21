// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using VA.Gov.Artemis.UI.Data.Models;
using VA.Gov.Artemis.UI.Data.Models.Account;
using VA.Gov.Artemis.UI.Data.Brokers.Common; 

namespace VA.Gov.Artemis.UI.Data.Brokers.Account
{
    public class VerifyCodeResult: BrokerOperationResult
    {
        public ChangeVerifyCode ChangeVerifyCodeData { get; set; }

        public VerifyCodeResult()
        {
            this.ChangeVerifyCodeData = new ChangeVerifyCode(); 
        }
    }
}