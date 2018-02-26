// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.Commands.Dsio.Pregnancy
{
    /// <summary>
    /// Details about a pregnancy, both current and historical 
    /// </summary>
    public class DsioPregnancy
    {
        public const string SpouseFOF = "SPOUSE";
        public const string CurrentPregnancyType = "CURRENT";
        public const string HistoricalPregnancyType = "HISTORICAL"; 

        public string PatientDfn { get; set; }
        public string Ien { get; set; }
        public string RecordType { get; set; } // Current or Historical
        public string FatherOfFetus { get; set; } // Unspecified, Spouse, or IEN of MTD PERSON
        public string FatherOfFetusIen { get; set; }
        public string EDD { get; set; }
        public string StartDate { get; set; }
        public string EndDate { get; set; }
        public string Obstetrician { get; set; }
        public string ObstetricianIen { get; set; }
        public string LDFacility { get; set; }
        public string LDFacilityIen { get; set; }

        public string HighRisk { get; set; }
        public string HighRiskDetails { get; set; }

        // TODO: Add to repository/UI if needed...
        public string Comment { get; set; }        
        public List<DsioBaby> Babies { get; set; }

        public DsioPregnancy()
        {
            this.Babies = new List<DsioBaby>(); 
        }

        public string Created { get; set; }

        public string GestationalAgeAtDelivery { get; set; }
        public string LengthOfLabor { get; set; }
        public string TypeOfDelivery { get; set; }
        public string Anesthesia { get; set; }
        public string PretermDelivery { get; set; }
        public string Outcome { get; set; }
        public string Lmp { get; set; }
    }
}
