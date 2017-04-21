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
