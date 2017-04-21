// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Vista.Broker;

namespace VA.Gov.Artemis.Commands.Dsio.Checklist
{
    public class DsioDeleteMccChecklistCommand: DsioCommand
    {
        public DsioDeleteMccChecklistCommand(IRpcBroker newBroker) : base(newBroker)
        {

        }

        public void AddCommandArguments(string ien)
        {
            this.CommandArgs = new object[] { ien };
        }

        public override string RpcName
        {
            get { return "DSIO DELETE MCC CHECKLIST"; }
        }

        protected override void ProcessResponse()
        {
            this.ProcessSaveResponse();

            //-1^MCC CHECKLIST CIEN: 58 DELETED

            if (this.CommandArgs != null)
            {
                if (this.CommandArgs.Length == 1)
                {

                    string successfulResponse = string.Format("-1^MCC CHECKLIST CIEN: {0} DELETED", this.CommandArgs[0]);

                    if (!string.IsNullOrWhiteSpace(this.Response.Data))
                        if (this.Response.Lines[0] == successfulResponse)
                            this.Response.Status = RpcResponseStatus.Success;
                }
            }
        }
    }
}
