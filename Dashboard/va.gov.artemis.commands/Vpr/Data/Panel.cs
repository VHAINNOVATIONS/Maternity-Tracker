using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace VA.Gov.Artemis.Commands.Vpr.Data
{
    [Serializable]
    [XmlRoot("panel")]
    public class Panel: LabBase
    {
        [XmlElement("order")]
        public CodeElement Order { get; set; }

        [XmlArray("values")]
        [XmlArrayItem("value")]
        public List<AccessionValue> PanelValues { get; set; }

    }
}
