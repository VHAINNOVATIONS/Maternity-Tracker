// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.Commands.Dsio.Pregnancy
{
    public class DsioGetPregHistoryRangeCommand: DsioPagableCommand
    {
        public List<DsioPregnancyOutcome> HistoricalPregnancies { get; set; }

        public DsioGetPregHistoryRangeCommand(IRpcBroker newBroker): base(newBroker) 
        {
            this.HistoricalPregnancies = new List<DsioPregnancyOutcome>(); 
        }

        public void AddCommandArguments(DateTime from, DateTime to, int page, int itemsPerPage)        
        {
            if (from == DateTime.MinValue)
                from = new DateTime(1900, 1, 1); 

            this.CommandArgs = new object[]
            {
                from.ToString("MM/dd/yyyy"),
                to.ToString("MM/dd/yyyy"),
                string.Format("{0},{1}", page, itemsPerPage) 
            };
        }

        protected override void ProcessLine(string line)
        {
            //        L^IEN^DATE RECORDED^EDC^DFN|PATIENT^STATUS^FOF|(IEN OR IDENTIFIER)^
            //EDD^PREGNANCY END^OB IEN|OB^FACILITY IEN|FACILITY^
            //UPDATED BY IEN|UPDATED BY^GESTATIONAL AGE AT DELIVERY^LENGTH OF DELIVERY^
            //TYPE OF DELIVERY^EPIDERAL/SPINAL^PRETERM LABOR^BIRTH TYPE^
            //IEN;BABY#|IEN;BABY#^COMPLICATION(E,AI,AS)^HIGH RISK FLAG(0,1)
            
            DsioPregnancyOutcome historicalPregnancy = new DsioPregnancyOutcome();

            historicalPregnancy.EndDate = Util.Piece(line, Caret, 9);
            historicalPregnancy.OutcomeType = Util.Piece(line, Caret, 20);

            this.HistoricalPregnancies.Add(historicalPregnancy); 
        }


        public override string RpcName
        {
            get { return "MTD GET PREG HISTORY RANGE"; }
        }
    }
}
