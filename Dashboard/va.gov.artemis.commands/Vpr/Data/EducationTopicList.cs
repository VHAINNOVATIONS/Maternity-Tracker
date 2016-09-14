using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace VA.Gov.Artemis.Commands.Vpr.Data
{
    [Serializable]
    public class EducationTopicList: ListWithTotal 
    {
        [XmlElement("educationTopic")]
        public List<EducationTopic> List { get; set; }
    }
}
