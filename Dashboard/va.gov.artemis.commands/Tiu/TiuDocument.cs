// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.Commands.Tiu
{
    public class TiuDocument
    {
        public string Ien { get; set; }
        public string Title { get; set; }
        public string DocumentDateTime { get; set; }
        public string DisplayName { get; set; }
        public string Author { get; set; }
        public string Location { get; set; }
        public string SignatureStatus { get; set; }
        public string VisitDateTime { get; set; }
        public string DischargeDateTime { get; set; }
        public string RequestPointer { get; set; }
        public string AssociatedImages { get; set; }
        public string Subject { get; set; }
        public string HasChildren { get; set; }
        public string ParentIen { get; set; }

        public string AddendaIen { get; set; }

        // *** Notes may be associated with a pregnancy ***
        public string PregnancyIen { get; set; }
    }
}
