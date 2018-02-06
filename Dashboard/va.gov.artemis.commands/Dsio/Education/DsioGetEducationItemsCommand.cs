// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.Commands.Dsio.Education
{
    public class DsioGetEducationItemsCommand: DsioPagableCommand
    {
        public List<DsioEducationItem> EducationItems { get; set; }

        public DsioGetEducationItemsCommand(IRpcBroker newBroker) : base(newBroker)
        {

        }

        public void AddCommandArguments(string ien, string category, string type, int page, int pageSize, int sort)
        {
            string size = (pageSize > 0) ? pageSize.ToString() : "";
            string pg = (page > 0) ? page.ToString() : ""; 
            
            this.CommandArgs = new object[] { pg, size, category, type, ien, sort.ToString() };            
        }

        protected override void ProcessStartData()
        {
            if (this.EducationItems != null)
                this.EducationItems.Clear(); 
        }

        protected override void ProcessResponse()
        {
            base.ProcessResponse();

            // *** Allow empty result ***
            if (this.Response.Status == RpcResponseStatus.Fail)
                if (string.IsNullOrWhiteSpace(this.Response.Data))
                    this.Response.Status = RpcResponseStatus.Success; 

        }

        protected override void ProcessLine(string line)
        {
            DsioEducationItem item = new DsioEducationItem();

            // 1^TESTING DESCRIPTION^INITIAL MATERIALS^PRINTED MATERIAL^^^NONE^
            // 2^SECOND DESCRIPTION^INITIAL LINKS^LINK TO MATERIAL^HTTP://WWW.MEDLINEPLUS.COM/MORE/ID/HELLO^^NONE^
            // 143^-----Purple Book^-----Initial Materials^^^LOINC^

            item.Ien = Util.Piece(line, Caret, 1);
            item.Description = Util.Piece(line, Caret, 2);
            item.Category = Util.Piece(line, Caret, 3);
            item.ItemType = Util.Piece(line, Caret, 4);
            item.Url = Util.Piece(line, Caret, 5);
            item.Code = Util.Piece(line, Caret, 6);            
            item.CodeSystem = Util.Piece(line, Caret, 7);             

            if (this.EducationItems == null)
                this.EducationItems = new List<DsioEducationItem>();

            this.EducationItems.Add(item); 
        }

        protected override void ProcessEndData()
        {
            // Nothing needed
        }

        

        public override string RpcName
        {
            get { return "MTD GET EDUCATION ITEMS"; }
        }
    }
}
