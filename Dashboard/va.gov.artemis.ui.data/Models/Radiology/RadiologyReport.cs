using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.UI.Data.Models.Radiology
{
    public class RadiologyReport
    {
        public string Location { get; set; }
        public DateTime ExamDateTime { get; set; }
        public string Procedure { get; set; }
        public string ReportStatus { get; set; }
        public string CptCode { get; set; }
        public string ReasonForStudy { get; set; }
        public string ClinicalHistory { get; set; }
        public string Impression { get; set; }
        public string ReportText { get; set; }
        public string Piece10 { get; set; }

        public string ExamDateTimeDisplay
        {
            get
            {
                string returnVal = "";

                if (this.ExamDateTime != DateTime.MinValue)
                    returnVal = this.ExamDateTime.ToString(VistaDates.UserDateTimeFormat);

                return returnVal;
            }
        }

//        Exam Date/Time   
// 03/18/1998 13:15
//Procedure Name                                 
// WRIST 2 VIEWS
//Reason for Study
 
//Clinical History
// Normal white female reporting wrist pain.  
//Impression
// Normal bone structure, referring to a neurology.  
//Report
// Patient shows no visual signs of inflamation or swelling with relatioin to 
// the hand bone structure.  No fractures seen. 
//Facility: VAMC ALBANY

        public string Detail
        {
            get
            {
                StringBuilder sb = new StringBuilder();

                sb.AppendLine("Exam Date/Time");
                sb.AppendLine(string.Format(" {0}", this.ExamDateTimeDisplay));
                sb.AppendLine("Procedure Name");
                sb.AppendLine(string.Format(" {0}", this.Procedure));
                sb.AppendLine("Reason for Study");
                sb.AppendLine(string.Format(" {0}", this.ReasonForStudy));
                sb.AppendLine("Clinical History");
                sb.AppendLine(string.Format(" {0}", this.ClinicalHistory));
                sb.AppendLine("Impression");
                sb.AppendLine(string.Format(" {0}", this.Impression));
                sb.AppendLine("Report"); 
                sb.AppendLine(string.Format(" {0}", this.ReportText));
                sb.AppendLine(string.Format("Facility: {0}", this.Location)); 

                return sb.ToString();
            }
        }

    }
}
