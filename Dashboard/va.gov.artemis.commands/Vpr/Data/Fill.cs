// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace VA.Gov.Artemis.Commands.Vpr.Data
{
    [Serializable]
    public class Fill
    {
        [XmlAttribute("fillDate")]
        public string FillDate { get; set; }

        [XmlAttribute("fillRouting")]
        public string FillRouting { get; set; }

        [XmlAttribute("fillQuantity")]
        public string FillQuantity { get; set; }

        [XmlAttribute("fillDaysSupply")]
        public string FillDaysSupply { get; set; }
    }

}
