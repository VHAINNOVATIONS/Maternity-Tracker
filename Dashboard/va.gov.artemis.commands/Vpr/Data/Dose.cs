using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace VA.Gov.Artemis.Commands.Vpr.Data
{
    [Serializable]
    public class Dose
    {
        // TODO: From docs...

        // conjunction
        // doseStart
        // doseStop
        // duration
        // noun
        // order
        // units
        // unitsPerDose

        [XmlAttribute("dose")]
        public string DoseValue { get; set; }

        [XmlAttribute("route")]
        public string Route { get; set; }

        [XmlAttribute("schedule")]
        public string Schedule { get; set; }
    }
}
