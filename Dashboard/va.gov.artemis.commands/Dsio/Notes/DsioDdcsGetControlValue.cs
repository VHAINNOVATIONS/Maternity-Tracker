// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.Commands.Dsio.Notes
{
    /// <summary>
    /// Command to interact with MTD DDCS GET CONTROL VALUE RPC
    /// </summary>
    public class DsioDdcsGetControlValue: DsioCommand
    {
        public DsioNoteData NoteData { get; set; }

        public DsioDdcsGetControlValue(IRpcBroker newBroker)
            : base(newBroker)
        {

        }

        public override string RpcName
        {
            get { return "MTD DDCS GET CONTROL VALUE"; }
        }

        public void AddCommandArguments(string noteIen)
        {
            string ienParameter = string.Format("N={0}", noteIen);

            this.CommandArgs = new object[] 
            {
                ienParameter
            };
        }

        protected override void ProcessResponse()
        {
            if (this.ProcessQueryResponse())
            {
                string[] lines = this.Response.Lines;

                this.NoteData = new DsioNoteData();

                foreach (string line in lines)
                {
                    string key = Util.Piece(line, Caret, 2);
                    string val = Util.Piece(line, Caret, 5);

                    if (this.NoteData.ContainsKey(key))
                        this.NoteData[key] = val;
                    else
                        this.NoteData.Add(key, val); 
                }

                this.Response.Status = RpcResponseStatus.Success;
            }
        }
    }
}
