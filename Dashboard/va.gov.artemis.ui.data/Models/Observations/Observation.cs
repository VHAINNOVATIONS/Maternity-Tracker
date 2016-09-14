using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.CDA.Common;
using VA.Gov.Artemis.CDA.ValueSets;
using VA.Gov.Artemis.Commands.Dsio.Observation;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.UI.Data.Models.Observations
{
    public class Observation//: DsioObservation
    {
        // *** Unique ID for this item ***
        public string Ien { get; set; }

        // *** Unique ID for patient ***
        public string PatientDfn { get; set; }

        // *** Unique ID for a pregnancy ***
        public string PregnancyIen { get; set; }

        // *** Baby Number (1-9 for each pregnancy) ***
        //public string BabyNum { get; set; }

        // *** Unique ID for a baby ***
        public string BabyIen { get; set; }
        public string BabyNumber { get; set; }

        // *** Date of observation ***
        //public virtual string Date { get; set; }

        // *** Category ***
        public string Category { get; set; }

        // *** Code System - Loinc, Snomed or None ***
        //public string CodeSystem { get; set; }

        // *** Code identifying type of observation ***
        public string Code { get; set; }

        // *** Description of observation ***
        public string Description { get; set; }

        // *** Value ***
        public string Value { get; set; }

        // *** User ***
        public string EnteredBy { get; set; }

        public CodingSystem CodeSystem { get; set; }

        public DateTime EntryDate { get; set; }

        public string Narrative { get; set; }

        public Hl7FamilyMember Relationship { get; set; }
        public string Unit { get; set; }
        public string NoteIen { get; set; }

        public bool Negation { get; set; }

        public string ExchangeDocumentIen { get; set; }

        public DateTime ExamDate { get; set; }
    }
}
