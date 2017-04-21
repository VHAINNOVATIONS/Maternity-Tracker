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
    public class Product : CodeElement
    {
        // TODO: From docs...

        // concentration
        // order

        [XmlAttribute("role")]
        public string Role { get; set; }

        [XmlElement("class")]
        public ProductElement ProductClass { get; set; }

        [XmlElement("vaGeneric")]
        public ProductElement VaGeneric { get; set; }

        [XmlElement("vaProduct")]
        public ProductElement VaProduct { get; set; }

    }

}
