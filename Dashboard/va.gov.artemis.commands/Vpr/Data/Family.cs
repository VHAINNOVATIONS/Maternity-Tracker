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
    public class Family
    {
        [XmlAttribute("total")]
        public int Total { get; set; }

        [XmlElement("patient_family")]
        public PatientFamily PatientFamily { get; set; }
    }
}
