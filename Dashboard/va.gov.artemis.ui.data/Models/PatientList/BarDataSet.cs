// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.UI.Data.Models.PatientList
{
    public class BarDataSet
    {
        public string Label { get; set; }

        public List<int> Data { get; set; }

        public BarDataSet()
        {
            this.Data = new List<int>();
        }
    }
}
