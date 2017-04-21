// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Runtime.Serialization;
using System.Xml.Serialization;

namespace VA.Gov.Artemis.Commands.Vpr.Data
{
    [Serializable]
    [XmlRoot("results")]
    public class PatientResult
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
        
        [XmlElement("vitals")]
        public VitalList Vitals { get; set; }

        [XmlElement("labs")]
        public LabList Labs { get; set; }

        [XmlElement("meds")]
        public MedicationList Medications { get; set; }

        [XmlElement("immunizations")]
        public ImmunizationList Immunizations { get; set; }

        [XmlElement("procedures")]
        public ProcedureList Procedures { get; set; }

        [XmlElement("radiologyExams")]
        public RadiologyExamList RadiologyExams { get; set; }

        [XmlElement("documents")]
        public DocumentList Documents { get; set; }

        [XmlElement("visits")]
        public VisitList Visits { get; set; }

        [XmlElement("consults")]
        public ConsultList Consults { get; set; }

        [XmlElement("accessions")]
        public AccessionList Accessions { get; set; }

        [XmlElement("panels")]
        public PanelList Panels { get; set; }

        [XmlElement("orders")]
        public OrderList Orders { get; set; }

        [XmlElement("appointments")]
        public AppointmentList Appointments { get; set; }

        [XmlElement("educationTopics")]
        public EducationTopicList EducationTopics { get; set; }

        [XmlElement("exams")]
        public ExamList Exams { get; set; }

        [XmlElement("flags")]
        public FlagList Flags { get; set; }

        [XmlElement("healthFactors")]
        public HealthFactorList HealthFactors { get; set; }

        [XmlElement("insurancePolicies")]
        public InsurancePolicyList InsurancePolicies { get; set; }

        [XmlElement("observations")]
        public ObservationList Observations { get; set; }

        [XmlElement("skinTests")]
        public SkinTestList SkinTests { get; set; }

        [XmlElement("surgeries")]
        public SurgeryList Surgeries { get; set; }


        // TODO: Add additional elements...

        // Flags
        // Insurance Policies
        // Observations
        // health factors
        // skin tests (encounter item)
        // appointments
        // surgeries

    }   

}

