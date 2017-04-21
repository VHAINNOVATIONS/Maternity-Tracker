// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Commands.Dsio.Orders;
using VA.Gov.Artemis.UI.Data.Brokers.Common;
using VA.Gov.Artemis.UI.Data.Models;
using VA.Gov.Artemis.UI.Data.Models.Orders;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.UI.Data.Brokers.Orders
{
    public class OrdersRepository: RepositoryBase, IOrdersRepository
    {
        public OrdersRepository(IRpcBroker newBroker)
            :base (newBroker)
        {

        }

        public OrderListResult GetList(string patientDfn, int page, int itemsPerPage)
        {
            OrderListResult result = new OrderListResult();

            DsioGetOrderListCommand command = new DsioGetOrderListCommand(this.broker);

            command.AddCommandArguments(patientDfn, page, itemsPerPage);

            RpcResponse response = command.Execute();

            result.Success = response.Status == RpcResponseStatus.Success;
            result.Message = response.InformationalMessage;

            if (result.Success)
            {
                if (command.Orders != null)
                    if (command.Orders.Count > 0)
                        foreach (DsioOrder dsioOrder in command.Orders)
                        {
                            Order tempOrder = GetOrder(dsioOrder);

                            result.OrderList.Add(tempOrder);
                        }

                result.TotalResults = command.TotalResults; 
            }

            return result; 
        }

        public OrderDetailResult GetDetail(string patientDfn, string orderIfn)
        {
            // *** Get order detail from VistA ***

            OrderDetailResult result = new OrderDetailResult();

            // *** Create the command ***
            DsioGetOrderDetailCommand command = new DsioGetOrderDetailCommand(this.broker);

            // *** Add command arguments ***
            command.AddCommandArguments(patientDfn, orderIfn);

            // *** Execute the command ***
            RpcResponse response = command.Execute();

            // *** Add result to return ***
            result.SetResult(response.Status == RpcResponseStatus.Success, response.InformationalMessage);

            // *** Add order detail ***
            if (result.Success)
                result.OrderDetail = command.OrderDetail; 

            return result; 
        }

        private Order GetOrder(DsioOrder dsioOrder)
        {
            Order returnOrder = new Order();

            //returnOrder.Ifn = dsioOrder.Ifn;
            returnOrder.Ifn = Util.Piece(dsioOrder.Ifn, ";", 1);
            returnOrder.Service = Util.Piece(dsioOrder.Grp, ":", 2);

            returnOrder.OrderText = dsioOrder.OrderText ;

            if (dsioOrder.StrtTm == "NOW")
                returnOrder.StartStop = "Start: NOW " + Environment.NewLine;
            else
            {
                DateTime startDate = Util.GetDateTime(dsioOrder.StrtTm);
                if (startDate == DateTime.MinValue)
                    returnOrder.StartStop = "Start: " + Environment.NewLine;
                else
                {
                    string format = "Start: {0:" + VistaDates.UserDateTimeFormat + "} " + Environment.NewLine;
                    returnOrder.StartStop = string.Format(format, startDate);
                }
            }


            DateTime stopDate = Util.GetDateTime(dsioOrder.StopTm);
            if (stopDate != DateTime.MinValue)
            {
                string format = "Stop: {0:" + VistaDates.UserDateTimeFormat + "} ";
                returnOrder.StartStop = string.Format(format, stopDate);
            }
            
            returnOrder.Provider = dsioOrder.PrvNam; 
            returnOrder.Nurse = dsioOrder.Nrs; 
            returnOrder.Clerk = dsioOrder.Clk; 
            returnOrder.Chart = dsioOrder.ChrtRev;
            returnOrder.Status = Util.Piece(dsioOrder.Sts, ":", 2);
            returnOrder.Location = Util.Piece(dsioOrder.Location, ":", 2); 

            return returnOrder;
        }
        
    }
}
