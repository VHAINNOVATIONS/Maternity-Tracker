// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace VA.Gov.Artemis.CDA
{
    public class ConsolidatedCdaDocument : RawCdaDocument
    {
        public ConsolidatedCdaDocument(): base()
        {
            // *** C-CDA id ***
            this.templateId = new II[] { new II() { root = "2.16.840.1.113883.10.20.22.1.1" } };
        }
    }
}