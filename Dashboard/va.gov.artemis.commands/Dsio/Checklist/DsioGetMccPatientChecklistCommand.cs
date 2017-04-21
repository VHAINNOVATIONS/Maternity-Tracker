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
    public class DsioGetMccPatientChecklistCommand: DsioPagableCommand
    {
        public List<DsioPatientChecklistItem> PatientItems { get; set; }

        public DsioGetMccPatientChecklistCommand(IRpcBroker newBroker) :base(newBroker)
        {

        }

        public override string RpcName
        {
            get { return "DSIO GET MCC PATIENT CHECKLIST"; }
        }

        public void AddCommandArguments(string patientDfn, string ien, string pregIen, DsioChecklistCompletionStatus complete)
        {
            string arg4 = (complete == DsioChecklistCompletionStatus.Unknown) ? "" : ((int)complete).ToString();

            this.CommandArgs = new object[] {patientDfn, ien, pregIen, arg4};
        }

        protected override void ProcessResponse()
        {
            base.ProcessResponse();

            if (this.Response.Status == RpcResponseStatus.Fail)
                if (!string.IsNullOrWhiteSpace(this.Response.Data))
                {
                    string line = this.Response.Lines[0];

                    if (line == "-1^Pregnancy History IEN not found.")
                        this.Response.Status = RpcResponseStatus.Success;
                    else if (line == "-1^No entries found for this Completion Status.")
                        this.Response.Status = RpcResponseStatus.Success;
                    else if (line == "-1^CompletionStatus no entries found.")
                        this.Response.Status = RpcResponseStatus.Success;
                }                    
        }

        protected override void ProcessLine(string line)
        {
            // 766:BLDAALUFHXY,SHUHTL^12:Phone Call #1 (First Contact)^22:SEP 04, 2014@10:04:23^1:MCC Call^2:WEEKS GA^0^MCC/Patient Phone Calls^PhoneCall_1^10000000052:CPRSNURSE,ONE^SEP 07, 2014@08:54:23^^0:NO:^2:Complete^10000000052:CPRSNURSE,ONE^SEP 07, 2014@08:54:23^5414^test
            
            // 1 - 715:DRMPATIENT,TEN^
            // 2 - 6:Friday Tests^
            // 3 - 5:AUG 25, 2014@15:43:43^
            // 4 - 3:Lab^
            // 5 - 5:NONE^
            // 6 - 0^
            // 7 - First Trimester Requirements^
            // 8 - 12345^
            // 9 - 10000000052:CPRSNURSE,ONE^
            // 10 - SEP 16, 2014@06:52:02^
            // 11 - SEP 01, 2014^
            // 12 - 0:NO:^
            // 13 - 2:Complete^
            // 14 - 10000000052:CPRSNURSE,ONE^
            // 15 - SEP 16, 2014@06:52:02^
            // 16 - 54321^
            // 17 - Checklist Item Note Text

            if (line != "-1^CheckListType no entries found.")
            {
                DsioPatientChecklistItem item = new DsioPatientChecklistItem();

                string tempPiece = Util.Piece(line, Caret, 1);

                item.PatientDfn = Util.Piece(tempPiece, ":", 1);

                tempPiece = Util.Piece(line, Caret, 2);

                item.Ien = Util.Piece(tempPiece, ":", 1);
                item.Description = Util.Piece(tempPiece, ":", 2);

                string piece3 = Util.Piece(line, Caret, 3);
                item.PregnancyIen = Util.Piece(piece3, ":", 1);

                string piece4 = Util.Piece(line, Caret, 4);
                string typeId = Util.Piece(piece4, ":", 1);
                int typeVal = -1;
                if (int.TryParse(typeId, out typeVal))
                    item.ItemType = (DsioChecklistItemType)typeVal;

                string piece5 = Util.Piece(line, Caret, 5);
                string calcType = Util.Piece(piece5, ":", 1);
                int calcVal;
                if (int.TryParse(calcType, out calcVal))
                    item.DueCalculationType = (DsioChecklistCalculationType)calcVal;

                item.DueCalculationValue = Util.Piece(line, Caret, 6);

                item.Category = Util.Piece(line, Caret, 7);

                item.Link = Util.Piece(line, Caret, 8);

                tempPiece = Util.Piece(line, Caret, 9);
                item.User = Util.Piece(tempPiece, ":", 2);

                item.ItemDate = Util.Piece(line, Caret, 10);

                item.SpecificDueDate = Util.Piece(line, Caret, 11);

                tempPiece = Util.Piece(line, Caret, 12);
                item.InProgress = Util.Piece(tempPiece, ":", 1);

                tempPiece = Util.Piece(line, Caret, 13); 
                string stat = Util.Piece(tempPiece, ":", 1);
                int statVal;
                if (int.TryParse(stat, out statVal))
                    item.CompletionStatus = (DsioChecklistCompletionStatus)statVal;

                tempPiece = Util.Piece(line, Caret, 14);
                tempPiece = Util.Piece(tempPiece, ":", 2);
                item.CompletedBy = tempPiece;

                item.CompleteDate = Util.Piece(line, Caret, 15);

                item.CompletionLink = Util.Piece(line, Caret, 16);

                item.Note = Util.Piece(line, Caret, 17);

                tempPiece = Util.Piece(line, Caret, 18);
                tempPiece = Util.Piece(tempPiece, ":", 1);
                item.EducationIen = tempPiece; 

                if (this.PatientItems == null)
                    this.PatientItems = new List<DsioPatientChecklistItem>();

                this.PatientItems.Add(item);
            }
        }
    }
}
