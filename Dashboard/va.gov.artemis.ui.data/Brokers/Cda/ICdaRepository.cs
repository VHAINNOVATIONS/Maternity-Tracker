// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.CDA;
using VA.Gov.Artemis.UI.Data.Models.Cda;
using VA.Gov.Artemis.Commands.Vpr.Data;
using VA.Gov.Artemis.CDA.ValueSets;
using VA.Gov.Artemis.UI.Data.Brokers.Common;

namespace VA.Gov.Artemis.UI.Data.Brokers.Cda
{
    public interface ICdaRepository
    {
        IenResult SaveDocument(CdaDocumentData documentData);

        //CdaDocumentResult Generate(CdaOptions options, VprPatientResult vprResult, CdaDeviceAuthor deviceAuthor, string provOrgPhone);

        CdaDocumentListResult GetExchangeHistory(string patientDfn, int page, int itemsPerPage);

        CdaDocumentResult GetDocumentData(string id);

        CdaValueSetResult GetValueSet(ValueSetType valueSetType); 

    }
}
