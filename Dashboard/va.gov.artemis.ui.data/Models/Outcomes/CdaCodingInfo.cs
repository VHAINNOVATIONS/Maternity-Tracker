using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.CDA.Common;

namespace VA.Gov.Artemis.UI.Data.Models.Outcomes
{
    public class CdaCodingInfo : Attribute
    {
        public CodingSystem CodeSystem { get; set; }
        public string Code { get; set; }
        public string DisplayName { get; set; }
    }
}
