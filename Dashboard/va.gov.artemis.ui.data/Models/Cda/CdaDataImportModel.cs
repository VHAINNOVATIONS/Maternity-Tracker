using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.CDA;
using VA.Gov.Artemis.UI.Data.Models.Patient;

namespace VA.Gov.Artemis.UI.Data.Models.Cda
{
    public class CdaDataImportModel: PatientRelatedModel
    {
        public List<CdaObservationModel> Observations { get; set; }

        // TODO: Can use for future observations that need a pregnancy association
        //public string PregnancyIen { get; set; }
        //public Dictionary<string, string> Pregnancies { get; set; }

        public string ESig { get; set; }
        public IheDocumentType DocumentType { get; set; }

        public CdaDataImportModel()
        {
            this.Observations = new List<CdaObservationModel>(); 
        }                
    }
}
