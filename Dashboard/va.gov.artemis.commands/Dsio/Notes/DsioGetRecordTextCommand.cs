using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.Commands.Dsio.Notes
{
    public class DsioGetRecordTextCommand: DsioCommand
    {
        /// <summary>
        /// Creates the command
        /// </summary>
        /// <param name="newBroker">An object which allows communication with VistA and implements IRpcBroker</param>
        public DsioGetRecordTextCommand(IRpcBroker newBroker): base(newBroker)
        {

        }

        public string RecordText { get; set; }

        public override string RpcName
        {
            get { return "DSIO GET RECORD TEXT"; }
        }

        public void AddCommandArgument(string ien, DsioGetRecordTextMode mode)
        {
            string[] args = new string[] { "", "H", "B" };

            this.CommandArgs = new object[] { ien, args[(int)mode] };
        }

        //protected override void ProcessResponse()
        //{
        //    // *** Make sure we have something to work with ***
        //    if (string.IsNullOrWhiteSpace(this.Response.Data))
        //    {
        //        // *** Set response info ***
        //        this.Response.Status = RpcResponseStatus.Fail;
        //        this.Response.InformationalMessage = "No data returned";
        //    }
        //    else
        //    {
        //        // *** Check first piece for success/failure ***
        //        string first = Util.Piece(this.Response.Lines[0], Caret, 1);

        //        if (first == "0")
        //        {
        //            // *** 0 is fail ***
        //            this.Response.Status = RpcResponseStatus.Fail;
        //            this.Response.InformationalMessage = Util.Piece(this.Response.Lines[0], Caret, 2);
        //        }
        //        else
        //        {
        //            this.RecordText = this.Response.Data;
        //            this.Response.Status = RpcResponseStatus.Success;
        //        }
        //    }            
        //}

        protected override void ProcessResponse()
        {
            // *** Not really a save operation, but response is same ***
            if (this.ProcessSaveResponse())
            {
                this.RecordText = this.Response.Data;
                this.Response.Status = RpcResponseStatus.Success;
            }
        }
    }
}
