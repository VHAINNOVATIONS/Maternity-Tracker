// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.CDA.ValueSets;
using VA.Gov.Artemis.Commands.Dsio.Observation;
using VA.Gov.Artemis.Commands.Vpr.Data;
using VA.Gov.Artemis.UI.Data.Models.Cda;
using VA.Gov.Artemis.UI.Data.Models.Common;
using VA.Gov.Artemis.UI.Data.Models.Education;
using VA.Gov.Artemis.UI.Data.Models.Patient;
using VA.Gov.Artemis.UI.Data.Models.Pregnancy;

namespace VA.Gov.Artemis.UI.Data.Models.Cda
{
    /// <summary>
    /// Source data consolidated for creation of the CDA document
    /// </summary>
    public class CdaSource
    {
        // *** Basic Patient Information ***
        public BasePatient Patient { get; set; }

        // *** Any Document Options Here ***
        public CdaOptions Options { get; set; }

        // *** The primary document id, unique ***
        public string DocumentId { get; set; }

        // *** VPR Data ***
        public VprPatientResult VprData { get; set; }

        // *** Some header data ***
        public string ManufacturerModelName { get; set; }
        public string SoftwareName { get; set; }
        public string ProviderOrganizationPhone { get; set; }

        // *** The pregnancy history ***
        //public PregnancyHistory PregnancyHistory { get; set; }

        // *** Observations are source for some sections ***
        public List<Observations.Observation> Observations { get; set; }

        // *** Pregnancies ***
        public List<PregnancyDetails> Pregnancies { get; set; }

        // *** Value Sets ***
        public Dictionary<ValueSetType, ValueSet> ValueSets { get; set; }

        public List<PatientEducationItem> EducationItems { get; set; }

        public CdaSource()
        {
            this.Observations = new List<Observations.Observation>();
            this.ValueSets = new Dictionary<ValueSetType, ValueSet>();
            this.EducationItems = new List<PatientEducationItem>(); 
        }

        public string ImageReportText { get; set; }
    }
}
