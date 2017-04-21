// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace VA.Gov.Artemis.Commands.Dsio.Base
{
    public class DsioAddress
    {
        public string StreetLine1 { get; set; }
        public string StreetLine2 { get; set; }
        public string StreetLine3 { get; set; }
        public string City { get; set; }
        public string State { get; set; }
        public string ZipCode { get; set; }

        public string[] ToParameter()
        {
            List<string> returnParam = new List<string>(); 

            if (!string.IsNullOrWhiteSpace(this.StreetLine1)) returnParam.Add(string.Format("1^{0}", this.StreetLine1));
            if (!string.IsNullOrWhiteSpace(this.StreetLine2)) returnParam.Add(string.Format("2^{0}", this.StreetLine2));
            if (!string.IsNullOrWhiteSpace(this.StreetLine3)) returnParam.Add(string.Format("3^{0}", this.StreetLine3));
            if (!string.IsNullOrWhiteSpace(this.City)) returnParam.Add(string.Format("city^{0}", this.City));
            if (!string.IsNullOrWhiteSpace(this.State)) returnParam.Add(string.Format("state^{0}", this.State));
            if (!string.IsNullOrWhiteSpace(this.ZipCode)) returnParam.Add(string.Format("zip^{0}", this.ZipCode));

            return returnParam.ToArray(); 
        }
    }
}
