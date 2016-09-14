using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace VA.Gov.Artemis.Commands.Vpr.Data
{
    [Serializable]
    public class Appointment: ClinicalItem
    {
        // TODO: From docs...

        // provider

        [XmlElement("apptStatus")]
        public ValueElement AppointmentStatus { get; set; }

        [XmlElement("clinicStop")]
        public CodeElement ClinicStop { get; set; }

        [XmlElement("dateTime")]
        public VprDateTime AppointmentDateTime { get; set; }

        [XmlElement("patientClass")]
        public ValueElement PatientClass { get; set; }

        [XmlElement("service")]
        public ValueElement Service { get; set; }

        [XmlElement("serviceCategory")]
        public CodeElement ServiceCategory { get; set; }

        [XmlElement("type")]
        public CodeElement AppointmentType { get; set; }

        [XmlElement("visitString")]
        public ValueElement VisitString { get; set; }

    }
}
