// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.UI.Data.Models.History
{
    public class HistoryItem
    {
        public int Id { get; set; }
        public string Tab { get; set; }
        public string Description { get; set; }
        public string Code { get; set; }
        public string CodeSystem { get; set; }
    }
}
