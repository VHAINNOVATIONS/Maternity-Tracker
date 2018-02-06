// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.Commands.Dsio.Checklist
{
    public class DsioGetMccChecklistCommand: DsioPagableCommand
    {
        public List<DsioChecklistItem> ChecklistItems { get; set; }

        public DsioGetMccChecklistCommand(IRpcBroker newBroker): base(newBroker)
        {

        }        

        public override string RpcName
        {
            get { return "MTD GET MCC CHECKLIST"; }
        }

        public void AddCommandArguments(string ien, int page, int itemsPerPage)
        {
            this.CommandArgs = new object[]
            { 
                ien, 
                string.Format("{0},{1}", page, itemsPerPage)
            };

        }

        protected override void ProcessStartData()
        {
            base.ProcessStartData();

            if (this.ChecklistItems != null)
                this.ChecklistItems = new List<DsioChecklistItem>(); 
        }
        protected override void ProcessLine(string line)
        {
            DsioChecklistItem item = new DsioChecklistItem();

            //1:TEST^1:MCC Call^2:WEEKS GA^12^1:REQUIRED CALLS^
            //2:CONFIRM PREGNANCY^2:Education Item^2:WEEKS GA^10^:^MCC TEST
            //3:Testing Name^3:Lab^1:INITIAL^0^3:CRITICAL LABS^Test Link
            //53:-this^2:Education Item^1:INITIAL^0^0:-Delte this^20:Abnormal Lab Values^

            string piece1 = Util.Piece(line, Caret, 1);
            item.Ien = Util.Piece(piece1, ":", 1);
            item.Description = Util.Piece(piece1, ":", 2);

            string piece2 = Util.Piece(line, Caret, 2); 
            string piece2_1 = Util.Piece(piece2, ":", 1);
            int val = -1;
            if (int.TryParse(piece2_1, out val))
                item.ItemType = (DsioChecklistItemType)val; 

            string piece3 = Util.Piece(line, Caret, 3);
            string piece3_1 = Util.Piece(piece3, ":", 1);
            if (int.TryParse(piece3_1, out val))
                item.DueCalculationType = (DsioChecklistCalculationType)val; 
                        
            item.DueCalculationValue = Util.Piece(line, Caret, 4);

            string piece5 = Util.Piece(line, Caret, 5);
            item.Category = Util.Piece(piece5, ":", 2);

            string piece6 = Util.Piece(line, Caret, 6);
            item.EducationIen = Util.Piece(piece6, ":", 1);

            item.Link = Util.Piece(line, Caret, 7); 

            if (this.ChecklistItems == null)
                this.ChecklistItems = new List<DsioChecklistItem>();

            this.ChecklistItems.Add(item); 
        }


    }
}
