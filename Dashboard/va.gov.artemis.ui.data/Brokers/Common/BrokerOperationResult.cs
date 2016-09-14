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