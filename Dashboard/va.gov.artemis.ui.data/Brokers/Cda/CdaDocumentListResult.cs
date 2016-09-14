using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.UI.Data.Models.Cda;
using VA.Gov.Artemis.UI.Data.Brokers.Common; 

namespace VA.Gov.Artemis.UI.Data.Brokers.Cda
{
    public class CdaDocumentListResult: BrokerOperationResult
    {
        public int TotalResults { get; set; }

        public List<CdaDocumentData> DocumentList { get; set; }

        public CdaDocumentListResult()
        {
            this.DocumentList = new List<CdaDocumentData>(); 
        }
    }
}
