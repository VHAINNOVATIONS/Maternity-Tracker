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
    public class Allergy : ClinicalItem
    {
        // TODO: Implement....
        // comment
        // removed
        // severity
        
        [XmlElement("assessment")]
        public ValueElement Assessment { get; set; }

        [XmlArray("drugIngredients")]
        [XmlArrayItem("drugIngredient")]
        public List<NameElement> DrugIngredients { get; set; }

        [XmlArray("drugClasses")]
        [XmlArrayItem("drugClass")]
        public List<NameElement> DrugClasses { get; set; }

        [XmlElement("entered")]
        public VprDateTime Entered { get; set; }

        [XmlElement("localCode")]
        public ValueElement LocalCode { get; set; }

        [XmlElement("mechanism")]
        public ValueElement Mechanism { get; set; }

        [XmlArray("reactions")]
        [XmlArrayItem("reaction")]
        public List<CodeElement> Reactions { get; set; }

        [XmlElement("source")]
        public ValueElement Source { get; set; }

        [XmlElement("type")]
        public CodeElement AllergyType { get; set; }

        [XmlElement("vuid")]
        public ValueElement Vuid { get; set; }

        [XmlElement("verified")]
        public VprDateTime Verified { get; set; }

    }

}
