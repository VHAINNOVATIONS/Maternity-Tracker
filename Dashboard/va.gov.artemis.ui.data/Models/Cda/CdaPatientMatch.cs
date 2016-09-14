using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.UI.Data.Models.Common;
using VA.Gov.Artemis.UI.Data.Models.Patient;

namespace VA.Gov.Artemis.UI.Data.Models.Cda
{
    public class CdaPatientMatch: PatientRelatedModel
    {
        //public string CurrentPatientDfn { get; set; }

        // *** The patient found in the document ***
        public BasePatient DocumentPatient { get; set; }

        // *** List of patients to choose ***
        public List<CdaMatchedPatient> MatchingPatients { get; set; }

        public Paging Paging { get; set; }

        public string MatchingMessage { get; set; }

        public CdaPatientMatch()
        {
            this.MatchingPatients = new List<CdaMatchedPatient>();
            this.Paging = new Paging(); 
        }
    }

    public class CdaMatchedPatient
    {
        public BasePatient Patient { get; set; }
        public MatchType MatchType { get; set; }

    }

    public enum MatchType { None, Exact, Partial }

    //public class CdaPatientMatch
    //{
        
    //    

    //    // *** Current selected patient in dashboard ***
    //    public BasePatient CurrentPatient { get; set; }

    //    // *** The patient found in the document ***
    //    public BasePatient DocumentPatient { get; set; }

    //    // *** Other patients that may match ***
    //    public List<SearchPatient> SearchPatients { get; set; }


    //}
}
