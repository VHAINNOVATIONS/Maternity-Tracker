// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Commands.Dsio.Base;

namespace VA.Gov.Artemis.Commands.Dsio.Cda
{
    /// <summary>
    /// A small class to hold provider details, derived from DsioPerson
    /// </summary>
    public class DsioProvider: DsioPerson
    {
        public string Title { get; set; }
        public string Service { get; set; }
        public string Npi { get; set; }
    }
}
