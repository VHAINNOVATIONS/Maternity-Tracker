using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.Commands.Orwrp
{
    public class OrwrpReport
    {
        public string Location { get; set; }
        public string ExamDateTime { get; set; }
        public string Procedure { get; set; }
        public string ReportStatus { get; set; }
        public string CptCode { get; set; }
        public string ReasonForStudy { get; set; }
        public string ClinicalHistory { get; set; }
        public string Impression { get; set; }
        public string ReportText { get; set; }
        public string Piece10 { get; set; }
    }
}
