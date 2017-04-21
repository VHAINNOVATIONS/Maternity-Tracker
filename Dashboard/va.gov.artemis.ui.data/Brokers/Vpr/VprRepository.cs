// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Commands.Dsio.Vpr;
using VA.Gov.Artemis.Commands.Vpr;
using VA.Gov.Artemis.Commands.Vpr.Data;
using VA.Gov.Artemis.UI.Data.Brokers.Common;
using VA.Gov.Artemis.UI.Data.Models.Cda;
using VA.Gov.Artemis.Vista.Broker;

namespace VA.Gov.Artemis.UI.Data.Brokers.Vpr
{
    public class VprRepository: RepositoryBase, IVprRepository
    {
        public VprRepository(IRpcBroker newBroker): base(newBroker){}

        public VprOperationResult GetVprData(CdaOptions options)
        {
            VprOperationResult returnResult = new VprOperationResult(); 

            //VprPatientResult returnVal = null;

            if (this.broker != null)
            {
                //VprGetPatientDataCommand command = new VprGetPatientDataCommand(this.broker);
                DsioVprGetPatientDataCommand command = new DsioVprGetPatientDataCommand(this.broker); 

                command.AddCommandArguments(options.Patient.Dfn, VprDataType.All, options.FromDate, options.ToDate);
               
                RpcResponse response = command.Execute();

                returnResult.Success = (response.Status == RpcResponseStatus.Success);
                returnResult.Message = response.InformationalMessage; 

                if (returnResult.Success)
                    returnResult.VprData = command.PatientResult;
            }

            return returnResult;
        }

    }
}
