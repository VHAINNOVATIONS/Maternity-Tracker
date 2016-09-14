using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace VA.Gov.Artemis.Commands.Vpr.Data
{
    [Serializable]
    public class LabList: ListWithTotal
    {
        [XmlElement("lab")]
        public List<Lab> List { get; set; }
    }
}
