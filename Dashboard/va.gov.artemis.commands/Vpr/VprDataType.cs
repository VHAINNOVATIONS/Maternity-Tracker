// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.Commands.Vpr
{
    public enum VprDataType
    {
        All, Accessions, Reactions, Appointments, ClinicalProcedures, Consults, Demographics, 
        Documents, HealthFactors, Flags, Immunizations, SkinTests, Exams, EducationTopics, 
        InsurancePolicies, Labs, Panels, Meds, Observations, Orders, Problems, AllProcedures, 
        Surgeries, Visits, Vitals, RadiologyExams, Patients, Family
    }; 
}
