using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.CDA
{
    public class CdaAssignedAuthoringDevice : CdaAssignedAuthor
    {
        public string ManufacturerModelName { get; set; }
        public string SoftwareName { get; set; }
    }
}
