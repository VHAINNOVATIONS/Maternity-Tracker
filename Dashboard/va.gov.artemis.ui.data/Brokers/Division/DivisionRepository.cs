// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Commands.Xus;
using VA.Gov.Artemis.Vista.Common;
using VA.Gov.Artemis.UI.Data.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using VA.Gov.Artemis.UI.Data.Brokers.Common;

namespace VA.Gov.Artemis.UI.Data.Brokers.Division
{
    public class DivisionRepository: RepositoryBase, IDivisionRepository 
    {
        public DivisionRepository(IRpcBroker newBroker): base(newBroker) {}

        public DivisionResult GetList()
        {
            DivisionResult returnResult = new DivisionResult(); 

            if (this.broker != null)
            {
                XusDivisionGetCommand divisionCommand = new XusDivisionGetCommand(this.broker);
                divisionCommand.Execute();

                bool success = (divisionCommand.Response.Status == RpcResponseStatus.Success);

                returnResult.SetResult(success, divisionCommand.Response.InformationalMessage);

                if (success)
                    returnResult.Divisions = divisionCommand.Divisions;

            }

            return returnResult;
        }

        public BrokerOperationResult Select(string stationNumber)
        {
            BrokerOperationResult returnVal = new BrokerOperationResult(); 

            if (this.broker != null)
            {
                XusDivisionSetCommand command = new XusDivisionSetCommand(this.broker, stationNumber);
                command.Execute();

                returnVal.SetResult((command.Response.Status == RpcResponseStatus.Success), "") ;
            }

            return returnVal;
        }
    }


}