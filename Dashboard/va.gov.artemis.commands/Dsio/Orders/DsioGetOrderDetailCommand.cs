using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Vista.Broker;

namespace VA.Gov.Artemis.Commands.Dsio.Orders
{
    public class DsioGetOrderDetailCommand: DsioCommand
    {
        public DsioGetOrderDetailCommand(IRpcBroker newBroker)
            : base(newBroker)
        {}

        public string OrderDetail { get; set; }

        public void AddCommandArguments(string patientDfn, string orderIen)
        {
            this.CommandArgs = new object[] { orderIen, patientDfn };
        }

        public override string RpcName
        {
            get { return "DSIO GET ORDER DETAIL"; }
        }

        protected override void ProcessResponse()
        {
            if (this.ProcessQueryResponse())
                this.OrderDetail = this.Response.Data; 
        }
    }
}
