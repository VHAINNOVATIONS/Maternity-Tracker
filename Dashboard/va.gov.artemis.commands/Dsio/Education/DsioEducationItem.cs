using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.Commands.Dsio.Education
{
    public class DsioEducationItem
    {
        public string Ien { get; set; }
        public string Description { get; set; }
        public string Category { get; set; }

        // (D)iscussion Topic, (L)ink to Material, (P)rinted Material, (E)nrollment, or (O)ther 
        public string ItemType { get; set; }
        
        public string Url { get; set; }
        public string Code { get; set; }

        // (L)oinc, (S)nomed, (N)one 
        public string CodeSystem { get; set; }        
    }
}
