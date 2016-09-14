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
