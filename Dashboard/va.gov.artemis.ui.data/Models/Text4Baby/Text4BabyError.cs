using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace VA.Gov.Artemis.UI.Data.Models.Text4Baby
{
    public class Text4BabyError
    {
        [XmlAttribute(AttributeName="code")]
        public string Code { get; set; }

        [XmlText]
        public string Text { get; set; }
    }
}
