using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Commands.Dsio;
using VA.Gov.Artemis.Commands.Dsio.Tracking;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.UI.Data.Brokers.Common; 

namespace VA.Gov.Artemis.UI.Data.Brokers.SelectList
{
    public class SelectListRepository: RepositoryBase, ISelectListRepository
    {
        private const string SourceListIdentifier = "S"; 
        private const string ReasonListIdentifier = "R"; 

        public SelectListRepository(IRpcBroker newBroker): base(newBroker) {}

        public SelectListResult GetReasonList()
        {
            return GetAnyList(ReasonListIdentifier); 
        }

        public SelectListResult GetSourceList()
        {
            return GetAnyList(SourceListIdentifier);
        }

        private SelectListResult GetAnyList(string listIdentifier)
        {
            SelectListResult returnResult = new SelectListResult();

            if (this.broker != null)
            {
                DsioSelectListCommand command = new DsioSelectListCommand(this.broker);

                command.AddCommandArguments(listIdentifier);

                RpcResponse response = command.Execute();

                if (response.Status == RpcResponseStatus.Success)
                {
                    returnResult.Success = true;

                    returnResult.SelectList = command.SelectList;
                }
            }

            return returnResult; 

        }

        public BrokerOperationResult AddReason(string newReason)
        {
            return AddAny(ReasonListIdentifier, newReason);    
        }

        public BrokerOperationResult AddSource(string newSource)
        {
            return AddAny(SourceListIdentifier, newSource);
        }

        public BrokerOperationResult AddAny(string listIdentifier, string addValue)
        {
            BrokerOperationResult returnResult = new BrokerOperationResult();

            if (this.broker != null)
            {
                DsioSelectListCommand command = new DsioSelectListCommand(this.broker);

                command.AddCommandArguments(listIdentifier, addValue, DsioSelectListCommand.SelectListOperation.Add);

                RpcResponse response = command.Execute();

                if (response.Status == RpcResponseStatus.Success)
                    returnResult.Success = true;

            }

            return returnResult; 
        }
    }
}
