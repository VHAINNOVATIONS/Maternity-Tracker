// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.UI.Data.Models.Common;
using VA.Gov.Artemis.UI.Data.Models.Patient;

namespace VA.Gov.Artemis.UI.Data.Models.Cda
{
    public class CdaIndex : NotesIndexModelBase
    {       
        public List<CdaDocumentData> DocumentList { get; set; }

        public Paging Paging { get; set; }

        public CdaIndex() : base()
        {
            this.Paging = new Paging(); 
        }
    }
}
