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
    public class Facility
    {
        [XmlAttribute("code")]
        public string Code { get; set; }

        [XmlAttribute("name")]
        public string Name { get; set; }

        [XmlAttribute("domain")]
        public string Domain { get; set; }

        // TODO: Figure out how to deserialize VprDateTime as attribute...
        //public VprDateTime LatestDate { get; set; }
        [XmlAttribute("latestDate")]
        public string LatestDate { get; set; }

        [XmlElement("address")]
        public Address Address { get; set; }

        [XmlAttribute("npi")]
        public string Npi { get; set; }
    }
}
