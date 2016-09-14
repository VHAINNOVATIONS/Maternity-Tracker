using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace VA.Gov.Artemis.UI.Data.Models.Text4Baby
{
    [XmlRoot("response")]
    public class Text4BabyResponse
    {
        [XmlElement(ElementName="error")]
        public Text4BabyError Error { get; set; }

        [XmlElement(ElementName = "result")]
        public Text4BabyResult Result { get; set; }
    }
}
