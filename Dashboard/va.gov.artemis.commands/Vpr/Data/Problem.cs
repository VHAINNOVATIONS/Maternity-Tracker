// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.Commands.Vpr.Data
{
    [Serializable]
    public class Problem : ClinicalItem
    {
        // TODO: Implement following elements...
        // comment
        // exposure
        // history
        // problemType
        // resolved
        // service        

        [XmlElement("acuity")]
        public CodeElement Acuity { get; set; }

        [XmlElement("entered")]
        public VprDateTime Entered { get; set; }

        [XmlElement("icd")]
        public ValueElement Icd { get; set; }

        [XmlElement("onset")]
        public VprDateTime Onset { get; set; }

        [XmlElement("provider")]
        public CodeElement Provider { get; set; }

        [XmlElement("removed")]
        public ValueElement Removed { get; set; }

        [XmlElement("sc")]
        public ValueElement Sc { get; set; }

        [XmlElement("status")]
        public CodeElement Status { get; set; }

        [XmlElement("unverified")]
        public ValueElement Unverified { get; set; }

        [XmlElement("updated")]
        public VprDateTime Updated { get; set; }
    }

}
