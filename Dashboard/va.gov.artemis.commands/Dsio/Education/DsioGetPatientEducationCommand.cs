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
    public class DsioGetPatientEducationCommand: DsioPagableCommand
    {
        public List<DsioPatientEducationItem> Items { get; set; }

        public DsioGetPatientEducationCommand(IRpcBroker newBroker): base(newBroker)
        {

        }

        public override string RpcName
        {
            get { return "DSIO GET PATIENT EDUCATION"; }
        }

        public void AddCommandArguments(string dfn, string ien, string fromDate, string toDate, string itemType, int page, int itemsPerPage)
        {

            //•	PatientDfn – Unique Identifier for patient - Required
            //•	Ien – Unique Identifier for an item - Not Required
            //•	Page Length – numeric – number of items per page – Not required
            //•	Page Number – numeric – the page of data to return – Not required
            //•	FromDate – DateTime – A date representing the oldest item to return – Not Required
            //•	ToDate – DateTime – A date representing the newest item to return – Not Required
            //•	Type – List of types (Discussion, Printed, Link, etc.) – Not Required

            this.CommandArgs = new object[] { dfn, ien, page.ToString(), itemsPerPage.ToString(), fromDate, toDate, itemType };
        }

        protected override void ProcessLine(string line)
        {
            if (this.Items == null)
                this.Items = new List<DsioPatientEducationItem>();

            DsioPatientEducationItem item = new DsioPatientEducationItem();

            // 7^3140904^First Trimester^Smoking Cessation^LINK TO MATERIAL^www.google.com^171055003^SNOMED^10000000052

            item.Ien = Util.Piece(line, Caret, 1);
            item.CompletedOn = Util.Piece(line, Caret, 2);
            item.Category = Util.Piece(line, Caret, 3);
            item.Description = Util.Piece(line, Caret, 4);
            item.ItemType = Util.Piece(line, Caret, 5);
            item.Url = Util.Piece(line, Caret, 6);
            item.Code = Util.Piece(line, Caret, 7);
            item.CodeSystem = Util.Piece(line, Caret, 8);
            item.CompletedBy = Util.Piece(line, Caret, 9); 

            this.Items.Add(item); 
        }
    }
}
