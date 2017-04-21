// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.Commands.Dsio.Alerts
{
    public class DsioGetAlertsCommand: DsioPagableCommand
    {
        public List<DsioAlert> Alerts { get; set; }

        public DsioGetAlertsCommand(IRpcBroker newBroker)
            : base(newBroker)
        {

        }

        public void AddCommandArguments(int page, int itemsPerPage)
        {
            this.CommandArgs = new object[] { 
                string.Format("{0},{1}", page, itemsPerPage)
             };
        }

        protected override void ProcessLine(string line)
        {
            // ^ACMPATIEN (A6789)^^Moderate^07/09/2014@06:14^UNSIGNED ADMISSION ASSESSMENT TWO Dated 01/13/14 OVERDUE for ^^TIU4830;10000000152;3140709.061414^^

            DsioAlert alert = new DsioAlert();

            alert.Info = Util.Piece(line, Caret, 1);
            alert.Patient = Util.Piece(line, Caret, 2);
            alert.Location = Util.Piece(line, Caret, 3);
            alert.Urgency = Util.Piece(line, Caret, 4);
            alert.AlertDateTime = Util.Piece(line, Caret, 5);
            alert.Message = Util.Piece(line, Caret, 6);

            string piece7 = Util.Piece(line, Caret, 7); 

            alert.Identifier = Util.Piece(piece7, ";", 1);
            alert.ForwardIen = Util.Piece(piece7, ";", 2);
            alert.When = Util.Piece(piece7, ";", 3);

            if (this.Alerts == null)
                this.Alerts = new List<DsioAlert>();

            this.Alerts.Add(alert);
        }

        protected override void ProcessEndData()
        {
            // Nothing needed here...
        }

        public override string RpcName
        {
            get { return "DSIO GET NOTIFICATIONS/ALERTS"; }
        }
    }
}
