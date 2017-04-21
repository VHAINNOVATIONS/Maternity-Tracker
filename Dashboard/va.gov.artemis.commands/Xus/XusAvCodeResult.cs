// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.Commands.Xus
{
    [Serializable]
    public class XusAvCodeResult
    {
        public bool Success { get; set; } // based on first line
        public string FailReasonCode { get; set; } // based on second line 
        public bool MustChangeVerifyCode { get; set; } // based on third line 
        public string RpcMessage { get; set; } // based on fourth line 
        public string RpcAdditionalMessage { get; set; }

        public string Duz { get; set; } // from first line 
        public bool AcccountIsLocked { get; set; } // line 2 = "1"

        //// *** Indicates that that broker made the call and ***
        //// *** received a response ***
        //public bool BrokerSuccess { get; set; }

        //// *** Messages from the broker go here ***
        //public string BrokerMessage { get; set; }

    }
}
