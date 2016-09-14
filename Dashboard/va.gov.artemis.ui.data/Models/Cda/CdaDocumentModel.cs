using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Commands.Dsio;
using VA.Gov.Artemis.UI.Data.Models.Common;
using VA.Gov.Artemis.UI.Data.Models.Patient;

namespace VA.Gov.Artemis.UI.Data.Models.Cda
{
    public class CdaDocumentModel: PatientRelatedModel
    {
        //public BasePatient Patient { get; set; }

        public CdaDocumentData Data { get; set; }

        public string FileName { get; set; }

        public string ESig { get; set; }

        public CdaDocumentModel()
        {
            this.Patient = new BasePatient();

            this.Data = new CdaDocumentData(); 
        }
    }
}
