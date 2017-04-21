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
    [XmlRoot("results")]
    public class VprPatientResult
    {
        [XmlAttribute("version")]
        public string Version { get; set; }

        [XmlAttribute("timeZone")]
        public string TimeZone { get; set; }

        [XmlElement("demographics")]
        public PatientDemographics Demographics { get; set; }

        [XmlElement("reactions")]
        public ReactionList Reactions { get; set; }

        [XmlElement("problems")]
        public ProblemList Problems { get; set; }

        [XmlArray("vitals")]
        [XmlArrayItem("vital")]
        public List<Vital> Vitals { get; set; }

        [XmlArray("labs")]
        [XmlArrayItem("lab")]
        public List<Lab> Labs { get; set; }

        [XmlArray("meds")]
        [XmlArrayItem("med")]
        public List<Medication> Meds { get; set; }

        [XmlElement("author")]
        public Author Author { get; set; }

        [XmlElement("participant")]
        public Family Participant { get; set; }

    }
}
