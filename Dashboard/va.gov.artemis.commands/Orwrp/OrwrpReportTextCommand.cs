using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Commands.Dsio;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.Commands.Orwrp
{
    public class OrwrpReportTextCommand: DsioCommand
    {
        public List<OrwrpReport> ReportList { get; set; } 

        public OrwrpReportTextCommand(IRpcBroker newBroker) : base(newBroker)
        {

        }

        public void AddCommandArguments(string dfn)
        {
            this.CommandArgs = new object[] { dfn, "OR_RP:REPORT~RR;ORDV03;35;101", "", "50000" };
        }

        public override string RpcName
        {
            get { return "ORWRP REPORT TEXT"; }
        }

        protected override void ProcessResponse()
        {
            if (this.ProcessQueryResponse())
            {
                string[] lines = this.Response.Lines;

                OrwrpReport rpt = null;

                foreach (string line in lines)
                {
                    string piece1 = Util.Piece(line, Caret, 1);
                    string piece2 = Util.Piece(line, Caret, 2);

                    switch (piece1)
                    {
                        case "1":
                            if (rpt != null)
                            {
                                if (this.ReportList == null)
                                    this.ReportList = new List<OrwrpReport>();

                                this.ReportList.Add(rpt);
                            }

                            rpt = new OrwrpReport();
                            rpt.Location = Util.Piece(piece2, ";", 1);
                            break;
                        case "2":
                            rpt.ExamDateTime = piece2;
                            break;
                        case "3":
                            rpt.Procedure = piece2;
                            break;
                        case "4":
                            rpt.ReportStatus = piece2;
                            break;
                        case "5":
                            rpt.CptCode = piece2;
                            break;
                        case "6":
                            rpt.ReasonForStudy = piece2;
                            break;
                        case "7":
                            rpt.ClinicalHistory = piece2;
                            break;
                        case "8":
                            rpt.Impression = piece2;
                            break;
                        case "9":
                            if (string.IsNullOrWhiteSpace(rpt.ReportText))
                                rpt.ReportText = string.Format("{0}{1}", piece2, Environment.NewLine);
                            else
                                rpt.ReportText += string.Format("{0}{1}", piece2, Environment.NewLine);
                            break;
                        case "10":
                            rpt.Piece10 = piece2;
                            break;
                    }
                }

                if (rpt != null)
                {
                    if (this.ReportList == null)
                        this.ReportList = new List<OrwrpReport>();

                    this.ReportList.Add(rpt);
                }

                this.Response.Status = RpcResponseStatus.Success;
            }
            else if (string.IsNullOrWhiteSpace(this.Response.Data))
            {
                // *** This will occur if (1) no rpc gui context or (2) no reports are found ***
                this.Response.Status = RpcResponseStatus.Success;
            }
        } 
    }
}
