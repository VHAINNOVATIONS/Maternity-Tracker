// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.Commands.Dsio.Observation
{
    public class DsioCode
    {
        public string CodeSystem { get; set; }
        public string CodeSystemName { get; set; }
        public string Code { get; set; }
        public string DisplayName { get; set; }
    }
}
