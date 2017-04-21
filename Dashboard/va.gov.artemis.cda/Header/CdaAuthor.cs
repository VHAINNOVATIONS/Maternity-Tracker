// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.CDA
{
    public abstract class CdaAuthor
    {
        public DateTime Time { get; set; }

        public abstract POCD_MT000040Author ToPocdAuthor();
    }
}
