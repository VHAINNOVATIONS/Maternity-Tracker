// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.Commands.Dsio.Tracking
{
    public class DsioPatient
    {
        public string Dfn { get; set; }

        public string LastName { get; set; }

        public string FirstName { get; set; }

        public string Last4 { get; set; }

        public string DateOfBirth { get; set; }

    }
}
