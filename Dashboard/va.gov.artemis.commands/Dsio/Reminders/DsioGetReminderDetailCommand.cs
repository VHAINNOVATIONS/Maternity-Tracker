// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Vista.Broker;

namespace VA.Gov.Artemis.Commands.Dsio.Reminders
{
    public class DsioGetReminderDetailCommand: DsioCommand
    {
        public DsioGetReminderDetailCommand(IRpcBroker newBroker)
            : base(newBroker)
        {}

        public string ReminderDetail { get; set; }

        public void AddCommandArguments(string patientDfn, string ReminderIen)
        {
            this.CommandArgs = new object[] { patientDfn, ReminderIen };
        }

        public override string RpcName
        {
            get { return "DSIO GET REMINDER DETAIL"; }
        }

        protected override void ProcessResponse()
        {
            if (this.ProcessQueryResponse())
                this.ReminderDetail = this.Response.Data; 
        }
    }
}
