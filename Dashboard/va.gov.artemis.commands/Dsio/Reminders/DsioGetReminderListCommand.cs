// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.Commands.Dsio.Reminders
{
    public class DsioGetReminderListCommand: DsioPagableCommand
    {
        public List<DsioReminder> Reminders { get; set; }

        public DsioGetReminderListCommand(IRpcBroker newBroker)
            : base(newBroker)
        {

        }

        public override string RpcName
        {
            get { return "DSIO GET REMINDER LIST"; }
        }


        public void AddCommandArguments(string patientDfn, int page, int itemsPerPage)
        {
            this.CommandArgs = new object[] { 
                patientDfn,
                string.Format("{0},{1}", page, itemsPerPage)
             };
        }
        
        protected override void ProcessLine(string line)
        {
            if (this.Reminders == null)
                this.Reminders = new List<DsioReminder>();

            DsioReminder tempReminder = new DsioReminder();
            tempReminder.Ien = Util.Piece(line, Caret, 1);
            tempReminder.Text = Util.Piece(line, Caret, 2);
            tempReminder.ReminderDate = Util.Piece(line, Caret, 3);

            this.Reminders.Add(tempReminder); 
        }

        protected override void ProcessEndData()
        {
            // Nothing needed...
        }
    }
}
