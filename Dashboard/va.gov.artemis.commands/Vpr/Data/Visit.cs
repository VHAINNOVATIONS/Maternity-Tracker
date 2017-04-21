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
    public class Visit: ClinicalItem 
    {
        // TODO: From docs

        // creditStopCode
        // stopCode

        // **** Admissions Only ***
        // departureDateTime

        [XmlElement("dateTime")]
        public VprDateTime VisitDateTime { get; set; }

        [XmlElement("patientClass")]
        public ValueElement PatientClass { get; set; }

        [XmlArray("providers")]
        [XmlArrayItem("provider")]
        public List<Provider> Providers {get; set; }

        [XmlElement("reason")]
        public Reason Reason { get; set; }

        [XmlElement("service")]
        public ValueElement Service { get; set; }

        [XmlElement("serviceCategory")]
        public CodeElement ServiceCategory { get; set; }

        [XmlElement("type")]
        public CodeElement VisitType { get; set; }

        [XmlElement("visitString")]
        public ValueElement VisitString { get; set; }

        [XmlElement("arrivalDateTime")]
        public VprDateTime ArrivalDateTime { get; set; }

        [XmlElement("specialty")]
        public ValueElement Specialty { get; set; }

        [XmlArray("documents")]
        [XmlArrayItem("document")]
        public List<Document> Documents { get; set; }

        [XmlElement("roomBed")]
        public ValueElement RoomBed { get; set; }

    }
}
