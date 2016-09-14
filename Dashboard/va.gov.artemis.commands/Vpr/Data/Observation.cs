using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace VA.Gov.Artemis.Commands.Vpr.Data
{
    [Serializable]
    [XmlRoot("Observation")]
    public class VprObservation: ClinicalItem 
    {
        // TODO: From docs...

        // bodySite
        // comment
        // entered
        // method
        // observed
        // position
        // product
        // quality
        // range
        // status
        // units
        // value 
        // vuid
        
    }
}
