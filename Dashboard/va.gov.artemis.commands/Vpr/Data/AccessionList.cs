using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace VA.Gov.Artemis.Commands.Vpr.Data
{
    [Serializable]
    public class AccessionList: ListWithTotal 
    {
        [XmlElement("accession")]
        public List<Accession> Accessions { get; set; }
    }
    
}
