using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace VA.Gov.Artemis.Commands.Vpr.Data
{
    [XmlRoot("accession")]
    public class Accession: LabBase
    {        
        [XmlArray("values")]
        [XmlArrayItem("value")]
        public List<AccessionValue> AccessionValues { get; set; }
    }
}
