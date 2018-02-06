// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Commands.Tiu;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.Commands.Dsio.Notes
{
    public class DsioGetTiuNotesCommand: DsioPagableCommand
    {
        /// <summary>
        /// Creates the command
        /// </summary>
        /// <param name="newBroker">An object which allows communication with VistA and implements IRpcBroker</param>
        public DsioGetTiuNotesCommand(IRpcBroker newBroker): base(newBroker)
        {
            this.Notes = new List<TiuDocument>();
        }

        public List<TiuDocument> Notes { get; set; }

        public override string RpcName
        {
            get { return "MTD GET TIU NOTES"; }
        }

        public void AddCommandArguments(string dfn, string[] noteTitles, string fromDate, string toDate, int page, int itemsPerPage, bool newestToOldest, string ien, string pregIen) 
        {
            string sort = (newestToOldest) ? "-1" : "1"; 

            this.CommandArgs = new object[] {
                ien, 
                dfn, 
                noteTitles,
                fromDate,
                toDate,
                sort,
                pregIen, 
                string.Format("{0},{1}", page, itemsPerPage)                
            };
        }

        protected override void ProcessLine(string line)
        {
            TiuDocument doc = new TiuDocument();

            //5195^PHONE CALL #1 (FIRST CONTACT)^^UNSIGNED^08/12/2014@08:55:11^Cprsphysician,One
            //5192^PHONE CALL #1 (FIRST CONTACT)^^UNSIGNED^08/12/2014@08:15:34^Cprsphysician,One
            //5190^PHONE CALL #1 (FIRST CONTACT)^^UNSIGNED^08/12/2014@07:25:02^Cprsphysician,One
            //5181^PHONE CALL #1 (FIRST CONTACT)^^UNSIGNED^08/12/2014@05:39:36^Cprsphysician,One
            //5180^PHONE CALL #2 (12 WEEKS)^^UNSIGNED^08/10/2014@12:33:03^Cprsphysician,One
            //5179^PHONE CALL #1 (FIRST CONTACT)^^UNSIGNED^08/10/2014@12:25:04^Cprsphysician,One

            //5553^MCC DASHBOARD NOTE^test subject^UNSIGNED^10/01/2014@11:56:14^10000000052^Cprsnurse,One^^

            doc.Ien = Util.Piece(line, Caret, 1);
            doc.Title = Util.Piece(line, Caret, 2); 
            doc.Subject = Util.Piece(line, Caret, 3);
            doc.SignatureStatus = Util.Piece(line, Caret, 4);
            doc.DocumentDateTime = Util.Piece(line, Caret, 5);
            doc.Author = Util.Piece(line, Caret, 7);
            doc.ParentIen = Util.Piece(line, Caret, 8);
            doc.AddendaIen = Util.Piece(line, Caret, 9);
            doc.PregnancyIen = Util.Piece(line, Caret, 10);
            
            if (doc.PregnancyIen == "0") doc.PregnancyIen = ""; 

            if (this.Notes == null)
                this.Notes = new List<TiuDocument>();

            this.Notes.Add(doc);

        }

        protected override void ProcessEndData()
        {
            // Nothing here...
        }
    }
}
