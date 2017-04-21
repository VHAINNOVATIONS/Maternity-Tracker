// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.UI.Data.Models.Labs
{
    public class LabItem
    {
        public string Id { get; set; }
        public string Specimen { get; set; }
        public string CollectionDateTime { get; set; }
        public string Test { get; set; }
        public string ResultStatus { get; set; }
        public string Flag { get; set; }
        public string Units { get; set; }
        public string RefRange { get; set; }

        public string Loinc { get; set; }
    }
}
