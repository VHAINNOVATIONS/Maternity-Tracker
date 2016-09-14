using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Serialization;

namespace VA.Gov.Artemis.Commands.Vpr.Data
{
    [Serializable]
    public class ObservationList: ListWithTotal
    {
        [XmlElement("observation")]
        public List<VprObservation> List { get; set; }
    }
}
