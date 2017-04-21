// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.Commands.Dsio.Orders
{
    /// <summary>
    /// Order information from VistA
    /// </summary>
    public class DsioOrder
    {
        public string Ifn { get; set; }
        public string Grp { get; set; }
        public string ActTm { get; set; }
        public string StrtTm { get; set; }
        public string StopTm { get; set; }
        public string Sts { get; set; }
        public string Sig { get; set; }
        public string Nrs { get; set; }
        public string Clk { get; set; }
        public string PrvId { get; set; }
        public string PrvNam { get; set; }
        public string ActDA { get; set; }
        public string Flag { get; set; }
        public string DCType { get; set; }
        public string ChrtRev { get; set; }
        public string DEA { get; set; }
        public string Schedule { get; set; }
        public string Location { get; set; }
        public string OrderText { get; set; }
    }
}
