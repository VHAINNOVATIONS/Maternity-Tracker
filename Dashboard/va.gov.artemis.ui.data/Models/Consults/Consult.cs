using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.UI.Data.Models.Consults
{
    public class Consult
    {
        public string Ien { get; set; }
        public DateTime ConsultDate { get; set; }
        public string Status { get; set; }
        public string Category { get; set; }
        public string Service { get; set; }
        public string Description { get; set; }

        public string ConsultDateDisplay
        {
            get
            {
                string returnVal = "";

                if (this.ConsultDate != DateTime.MinValue)
                    returnVal = this.ConsultDate.ToString(VistaDates.VistADateOnlyFormat);

                return returnVal;
            }
        }

        public string StatusDisplay
        {
            get
            {
                string returnVal = this.Status;

                switch (this.Status)
                {
                    case "p":
                        returnVal = "Pending";
                        break;
                    case "c":
                        returnVal = "Complete";
                        break;
                    case "pr":
                        returnVal = "Partial Result";
                        break;
                    case "a":
                        returnVal = "Active";
                        break;
                    case "dc":
                        returnVal = "Discontinued";
                        break;
                    case "s":
                        returnVal = "Scheduled";
                        break;
                }

                return returnVal;
            }
        }
    }
}
