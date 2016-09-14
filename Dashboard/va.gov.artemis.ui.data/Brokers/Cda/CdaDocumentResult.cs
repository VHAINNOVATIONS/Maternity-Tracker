using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.UI.Data.Models.Cda;
using VA.Gov.Artemis.UI.Data.Brokers.Common; 

namespace VA.Gov.Artemis.UI.Data.Brokers.Cda
{
    public class CdaDocumentResult: BrokerOperationResult
    {
        public CdaDocumentData DocumentData { get; set; }

        public CdaDocumentResult()
        {
            this.DocumentData = new CdaDocumentData(); 
        }
    }
}
