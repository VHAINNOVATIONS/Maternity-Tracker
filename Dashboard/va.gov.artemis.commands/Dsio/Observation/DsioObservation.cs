// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.Commands.Dsio.Observation
{
    /// <summary>
    /// A simple class to hold string data returned from VistA for an observation 
    /// </summary>
    public class DsioObservation
    {
        public const string LoincCodeSystem = "LOINC";
        public const string SnomedCodeSystem = "SNOMED-CT";
        public const string OtherCodeSystem = "OTHER";

        public DsioObservation()
        {
            this.Code = new DsioCode();
            this.ValueCode = new DsioCode(); 
        }

        // *** Unique ID for this item ***
        public string Ien { get; set; }

        // *** Unique ID for patient ***
        public string PatientDfn { get; set; }

        // *** Unique ID for a pregnancy ***
        public string PregnancyIen { get; set; }

        // *** Baby Number (1-9 for each pregnancy) ***
        public string BabyNum { get; set; }

        // *** Unique ID for a baby ***
        public string BabyIen { get; set; }

        // *** Date of observation ***
        public string ExamDate { get; set; }

        // *** Category ***
        public string Category { get; set; }
        
        // *** Code System - Loinc, Snomed or None ***
        //public string CodeSystem { get; set; }

        // *** Code identifying type of observation ***
        //public string Code { get; set; }

        // *** Description of observation ***
        //public string Description { get; set; }

        // *** Value ***
        public string Value { get; set; }

        // *** User ***
        public string EnteredBy { get; set; }

        // *** Relationship ***
        // *** Should be self (or blank) unless observation is for a family member ***
        public string Relationship { get; set; }
        
        // *** Unit ***
        // *** (e.g. "{packs}/wk"
        public string Unit { get; set; }

        // *** If the value of the observation is a narrative use this ***
        public string Narrative { get; set; }

        // *** Note IEN ***
        // *** When observation is derived directly from a note, include note ien here ***
        // *** Blank if not derived from note ***
        public string NoteIen { get; set; }

        public string EffectiveTimeStart { get; set; }
        public string EffectiveTimeEnd { get; set; }
        public string ExchangeDocumentIen { get; set; }

        public DsioCode Code { get; set; }
        public DsioCode ValueCode { get; set; }

        public string ValueType { get; set; }
        public string Negation { get; set; }

        public string EntryDate { get; set; }
        public string Qualifiers { get; set; }
    }
}
