using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Commands.Dsio.Alerts;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.UI.Data.Brokers.Common; 

namespace VA.Gov.Artemis.UI.Data.Brokers.Alerts
{
    public class AlertsRepository: RepositoryBase, IAlertsRepository
    {
        public AlertsRepository(IRpcBroker rpcBroker) : base(rpcBroker)
        {

        }

        public AlertListResult GetAlerts(int page, int itemsPerPage)
        {
            AlertListResult result = new AlertListResult();

            DsioGetAlertsCommand command = new DsioGetAlertsCommand(this.broker);

            command.AddCommandArguments(page, itemsPerPage);

            RpcResponse response = command.Execute();

            result.Success = response.Status == RpcResponseStatus.Success;
            result.Message = response.InformationalMessage;

            if (result.Success)
            {
                result.Alerts = command.Alerts;
                result.TotalResults = command.TotalResults; 
            }
            return result; 
        }

        public AlertResult GetAlertDetail(string ien)
        {
            throw new NotImplementedException();
        }
    }
}
