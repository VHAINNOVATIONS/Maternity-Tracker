// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.Commands.Dsio.Checklist
{
    public class DsioChecklistItem
    {
        public string Ien { get; set; }
        public string Category {get; set; }
        public string Description { get; set; }
        public DsioChecklistItemType ItemType { get; set; }
        public DsioChecklistCalculationType DueCalculationType { get; set; }
        public string DueCalculationValue { get; set; }
        public string Link { get; set; }
        public string EducationIen { get; set; }
    }
}
