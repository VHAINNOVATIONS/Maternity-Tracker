// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

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
