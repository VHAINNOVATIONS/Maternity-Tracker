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
    public class Consult: ClinicalItem
    {
        // TODO: Implement...
        // document
        // result

        [XmlElement("orderID")]
        public ValueElement OrderId { get; set; }

        [XmlElement("procedure")]
        public ValueElement Procedure { get; set; }

        [XmlElement("requested")]
        public VprDateTime Requested { get; set; }

        [XmlElement("service")]
        public ValueElement Service { get; set; }

        [XmlElement("status")]
        public ValueElement Status { get; set; }

        [XmlElement("type")]
        public ValueElement ConsultType { get; set; }



        
    }
}
