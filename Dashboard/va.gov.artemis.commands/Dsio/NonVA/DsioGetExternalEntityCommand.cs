using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Commands.Dsio.Base;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.Commands.Dsio.NonVA
{
    //public class DsioReturnEntityCommand: DsioPagableCommand 
    public class DsioGetExternalEntityCommand : DsioPagableCommand 
    {
        public List<DsioNonVAItem> NonVAEntities { get; set; }

        //public int TotalResults { get; set; }

        //private bool FirstLineIsCount { get; set; }

        /// <summary>
        /// Creates the command
        /// </summary>
        /// <param name="newBroker">An object which allows communication with VistA and implements IRpcBroker</param>
        public DsioGetExternalEntityCommand(IRpcBroker newBroker): base(newBroker)
        {
            //this.NonVAEntities = new List<DsioNonVAItem>(); 
        }

        public override string RpcName
        {
            get { return "DSIO GET EXTERNAL ENTITY"; }
        }

        public void AddCommandArguments(string entityType, int page, int itemsPerPage)
        {
            this.CommandArgs = new object[] { 
                entityType,
                string.Format("{0},{1}", page, itemsPerPage)
            };

            //int temp = -1;
            //int.TryParse(entityType, out temp);

            //FirstLineIsCount = (temp > 0) ? false : true;             
        }


        //protected override void ProcessResponse()
        //{
        //    if (!string.IsNullOrWhiteSpace(this.Response.Data))
        //    {
        //        string piece1 = Util.Piece(this.Response.Lines[0], "^", 1);

        //        if (piece1 == "-1")
        //        {
        //            this.Response.InformationalMessage = Util.Piece(this.Response.Lines[0], Caret, 2);
        //            this.Response.Status = RpcResponseStatus.Fail;
        //        }
        //        else if (piece1 == "0")
        //        {
        //            this.Response.Status = RpcResponseStatus.Success;
        //            this.TotalResults = 0;
        //            this.Response.InformationalMessage = "Nothing Found";
        //        }
        //        else
        //        {
        //            string[] lines = this.Response.Lines;

        //            bool first = this.FirstLineIsCount;

        //            foreach (string line in lines)
        //            {
        //                // *** First line is total result ***
        //                if (first)
        //                {
        //                    int total = -1;
        //                    if (int.TryParse(line, out total))
        //                        this.TotalResults = total;
        //                    first = false;
        //                }
        //                else
        //                {
        //                    DsioNonVAItem entity = new DsioNonVAItem();

        //                    entity.Ien = Util.Piece(line, Caret, 1);
        //                    entity.EntityName = Util.Piece(line, Caret, 2);
        //                    entity.EntityType = Util.Piece(line, Caret, 3);
        //                    entity.Inactive = Util.Piece(line, Caret, 4);
        //                    entity.PrimaryContact = Util.Piece(line, Caret, 5);
        //                    entity.Address.StreetLine1 = Util.Piece(line, Caret, 6);
        //                    entity.Address.StreetLine2 = Util.Piece(line, Caret, 7);
        //                    entity.Address.City = Util.Piece(line, Caret, 9);
        //                    entity.Address.State = Util.Piece(line, Caret, 10);
        //                    entity.Address.ZipCode = Util.Piece(line, Caret, 11);

        //                    // 07/08/2014 : Pieces Re-ordered...

        //                    string tel = Util.Piece(line, Caret, 14);

        //                    if (!string.IsNullOrWhiteSpace(tel))
        //                        entity.TelephoneList.Add(new DsioTelephone() { Usage = DsioTelephone.WorkPhoneUsage, Number = tel });

        //                    string fax = Util.Piece(line, Caret, 15);

        //                    if (!string.IsNullOrWhiteSpace(fax))
        //                        entity.TelephoneList.Add(new DsioTelephone() { Usage = DsioTelephone.FaxUsage, Number = fax });


        //                    this.NonVAEntities.Add(entity);

        //                    if (!this.FirstLineIsCount)
        //                        this.TotalResults += 1; 
        //                }
        //            }

        //            this.Response.Status = RpcResponseStatus.Success;
        //        }
        //    }
        //}

        protected override void ProcessLine(string line)
        {
            DsioNonVAItem entity = new DsioNonVAItem();

            entity.Ien = Util.Piece(line, Caret, 1);
            entity.EntityName = Util.Piece(line, Caret, 2);
            entity.EntityType = Util.Piece(line, Caret, 3);
            entity.Inactive = Util.Piece(line, Caret, 4);
            entity.PrimaryContact = Util.Piece(line, Caret, 5);
            entity.Address.StreetLine1 = Util.Piece(line, Caret, 6);
            entity.Address.StreetLine2 = Util.Piece(line, Caret, 7);
            entity.Address.City = Util.Piece(line, Caret, 9);
            entity.Address.State = Util.Piece(line, Caret, 10);
            entity.Address.ZipCode = Util.Piece(line, Caret, 11);

            // 07/08/2014 : Pieces Re-ordered...

            string tel = Util.Piece(line, Caret, 13);

            if (!string.IsNullOrWhiteSpace(tel))
                entity.TelephoneList.Add(new DsioTelephone() { Usage = DsioTelephone.WorkPhoneUsage, Number = tel });

            string fax = Util.Piece(line, Caret, 15);

            if (!string.IsNullOrWhiteSpace(fax))
                entity.TelephoneList.Add(new DsioTelephone() { Usage = DsioTelephone.FaxUsage, Number = fax });

            if (this.NonVAEntities == null)
                this.NonVAEntities = new List<DsioNonVAItem>(); 

            this.NonVAEntities.Add(entity);
        }
    }
}
