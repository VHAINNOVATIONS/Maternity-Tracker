using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Commands.Orqqcn;
using VA.Gov.Artemis.UI.Data.Brokers.Common;
using VA.Gov.Artemis.UI.Data.Models.Consults;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.UI.Data.Brokers.Consults
{
    public class ConsultsRepository: RepositoryBase, IConsultsRepository
    {
        public ConsultsRepository(IRpcBroker newBroker): base(newBroker)
        {

        }

        public ConsultListResult GetList(string dfn)
        {
            ConsultListResult result =new ConsultListResult();

            if (this.broker != null)
            {
                OrqqcnListCommand command = new OrqqcnListCommand(this.broker);

                command.AddCommandArguments(dfn);

                RpcResponse response = command.Execute();

                result.SetResult(response.Status == RpcResponseStatus.Success, response.InformationalMessage);

                if (result.Success)
                {
                    if (command.ConsultList != null) 
                        if (command.ConsultList.Count > 0)
                            foreach (OrqqcnConsult orqqcnConsult in command.ConsultList)
                            {
                                Consult consult = GetConsult(orqqcnConsult);

                                result.Consults.Add(consult); 

                            }
                }
            }

            return result; 
        }

        public ConsultDetailResult GetDetail(string ien)
        {
            ConsultDetailResult result = new ConsultDetailResult(); 

            if (this.broker != null)
            {
                OrqqcnDetailCommand command = new OrqqcnDetailCommand(this.broker);

                command.AddCommandArguments(ien);

                RpcResponse response = command.Execute();

                result.SetResult(response.Status == RpcResponseStatus.Success, response.InformationalMessage);

                if (result.Success)
                    result.ConsultDetail = command.ConsultDetail; 
            }

            return result; 
        }

        private Consult GetConsult(OrqqcnConsult orqqcnConsult)
        {
            Consult returnVal = new Consult()
            {
                Ien = orqqcnConsult.Ien,
                Category = orqqcnConsult.Category,
                Description = orqqcnConsult.Description,
                Service = orqqcnConsult.Service,
                Status = orqqcnConsult.Status
            };

            returnVal.ConsultDate = Util.GetDateTime(orqqcnConsult.ConsultDate);

            return returnVal; 
        }



    }
}
