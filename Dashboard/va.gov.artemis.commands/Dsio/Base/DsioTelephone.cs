using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace VA.Gov.Artemis.Commands.Dsio.Base
{
    public class DsioTelephone
    {
        public const string WorkPhoneUsage = "WP";
        public const string HomePhoneUsage = "H";
        public const string MobilePhoneUsage = "MC"; 
        public const string FaxUsage = "FAX"; 

        public string Number { get; set; }
        public string Usage { get; set; }

        public string ToParam()
        {
            return string.Format("{0}^{1}", this.Usage, this.Number); 
        }
    }
}
