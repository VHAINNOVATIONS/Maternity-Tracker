// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.UI.Data.Models.PatientList
{
    public class BarData
    {
        public List<string> Labels { get; set; }
        public List<BarDataSet> Datasets { get; set; }

        public BarData()
        {
            this.Labels = new List<string>();
            this.Datasets = new List<BarDataSet>();
        }
    }
}
