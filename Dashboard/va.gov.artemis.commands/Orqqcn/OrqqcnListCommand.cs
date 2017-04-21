// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Commands.Dsio;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Vista.Commands;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.Commands.Orqqcn
{
    public class OrqqcnListCommand: DsioCommand 
    {
        public List<OrqqcnConsult> ConsultList { get; set; }

        public OrqqcnListCommand(IRpcBroker newBroker): base(newBroker)
        {

        }
        public override string RpcName
        {
            get { return "ORQQCN LIST"; }
        }

        public void AddCommandArguments(string dfn)
        {
            this.CommandArgs = new object[] { dfn };
        }

        protected override void ProcessResponse()
        {
            //554^3011030.14592^p^HEMATOLOGY NEW NAME^BONE MARROW BIOPSY^^BONE MARROW BIOPSY HEMATOLOGY NEW NAME Proc^18578^P
            //544^3010918.104817^p^SHERI'S NEW SERVICE^Consult^^SHERI'S NEW SERVICE Cons^18342^C
            //538^3010917.11141^p^SHERI'S NEW SERVICE^Consult^^SHERI'S NEW SERVICE Cons^18331^C
            //529^3010917.094826^p^SHERI'S NEW SERVICE^Consult^^SHERI'S NEW SERVICE Cons^18322^C
            //501^3010725.154945^c^CARDIOLOGY^ELECTROCARDIOGRAM^^ELECTROCARDIOGRAM CARDIOLOGY Proc^18011^P
            //279^3000608.131446^c^BONE MARROW^Consult^^BONE MARROW Cons^13078^C
            //222^2990518.143914^c^INFECTIOUS DISEASE^SPUTUM INDUCTION X3 FOR AFB^^SPUTUM INDUCTION x3 FOR AFB INFECTIOUS DISEASE Proc^9910^P

            if (this.ProcessQueryResponse())
            {
                string[] lines = this.Response.Lines;

                if (lines[0] != "< PATIENT DOES NOT HAVE ANY CONSULTS/REQUESTS  ON FILE. >")
                {
                    foreach (string line in lines)
                    {
                        OrqqcnConsult consult = new OrqqcnConsult();

                        consult.Ien = Util.Piece(line, Caret, 1);
                        consult.ConsultDate = Util.Piece(line, Caret, 2);
                        consult.Status = Util.Piece(line, Caret, 3);
                        consult.Service = Util.Piece(line, Caret, 4);
                        consult.Category = Util.Piece(line, Caret, 5);
                        consult.Piece6 = Util.Piece(line, Caret, 6);
                        consult.Description = Util.Piece(line, Caret, 7);
                        consult.Piece8 = Util.Piece(line, Caret, 8);
                        consult.Piece9 = Util.Piece(line, Caret, 9);

                        if (this.ConsultList == null)
                            this.ConsultList = new List<OrqqcnConsult>();

                        this.ConsultList.Add(consult);
                    }
                }

                this.Response.Status = Vista.Broker.RpcResponseStatus.Success;
            }
        }
    }
}
