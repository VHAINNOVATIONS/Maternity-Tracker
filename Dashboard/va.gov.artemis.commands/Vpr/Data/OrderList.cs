using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace VA.Gov.Artemis.Commands.Vpr.Data
{
    [Serializable]
    public class OrderList
    {
        // *** Use actual total from list? ***
        [XmlAttribute("total")]
        public int Total { get; set; }

        [XmlElement("order")]
        public List<Order> Orders { get; set; }
    }
}
