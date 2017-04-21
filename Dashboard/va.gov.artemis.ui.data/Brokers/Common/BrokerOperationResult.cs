// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace VA.Gov.Artemis.UI.Data.Brokers.Common
{
    public class BrokerOperationResult
    {
        public bool Success { get; set; }
        public string Message { get; set; }

        public void SetResult(bool success, string message)
        {
            this.Success = success;
            this.Message = message;
        }

        public void SetResult(string message)
        {
            this.Message = message;
        }
    }
}