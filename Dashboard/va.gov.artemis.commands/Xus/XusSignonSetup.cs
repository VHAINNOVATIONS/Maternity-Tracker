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
    public class XusSignonSetup
    {
        public string ServerName { get; set; }
        public string Volume { get; set; }
        public string UCI { get; set; }
        public string Port { get; set; }
        public bool IsSignonRequired { get; set; }
        public bool IsProductionAccount { get; set; }
        public string DomainName { get; set; }
        public string IntroMessage { get; set; }
    }
}
