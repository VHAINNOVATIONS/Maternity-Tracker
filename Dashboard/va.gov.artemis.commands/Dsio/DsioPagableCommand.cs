using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.Commands.Dsio
{
    public abstract class DsioPagableCommand: DsioCommand 
    {
        public DsioPagableCommand(IRpcBroker newBroker)
            :base(newBroker) {}

        public int TotalResults { get; set; }

        // *** Processes the response data ***
        protected override void ProcessResponse()
        {
            // *** First do standard processing ***
            if (this.ProcessQueryResponse())
            {
                // *** Process pageable data ***
                this.ProcessPage();

                this.Response.Status = RpcResponseStatus.Success;
            }
            else
            {
                if (this.Response.Status == RpcResponseStatus.Success)
                    this.TotalResults = 0; 
            }
        }

        protected void ProcessPage()
        {
            string[] lines = this.Response.Lines;

            bool first = true;

            ProcessStartData(); 

            foreach (string line in lines)
            {
                if (first)
                {
                    string piece1 = Util.Piece(line, Caret, 1);

                    int returnCode = -1;

                    int.TryParse(piece1, out returnCode);

                    this.TotalResults = returnCode;

                    first = false;
                }
                else
                {
                    ProcessLine(line);
                }
            }

            ProcessEndData(); 
        }

        protected abstract void ProcessLine(string line);

        protected virtual void ProcessEndData() 
        { 
            // Nothing by default...
        }

        protected virtual void ProcessStartData()
        {
            // Nothing by default...
        }

    }
}
