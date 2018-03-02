using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.Commands.Dsio.Pregnancy
{
    /// <summary>
    /// A command to get Women's Health details from WVRPCOR namespace in VistA
    /// </summary>
    public class WvrpcorGetWomensHealthDataCommand : DsioCommand
    {
        /// <summary>
        /// Creates the command
        /// </summary>
        /// <param name="newBroker">An object which allows communication with VistA and implements IRpcBroker</param>
        public WvrpcorGetWomensHealthDataCommand(IRpcBroker newBroker) : base(newBroker) { }

        public string Ien { get; set; }
        public string Pregnant { get; set; }
        public string Lactating { get; set; }

        /// <summary>
        /// The name of the RPC
        /// </summary>
        public override string RpcName
        {
            get { return "WVRPCOR COVER"; }
        }

        /// <summary>
        /// Add command arguments to the RPC call. 
        /// Call prior to calling "Execute"
        /// </summary>
        /// <param name="pregnancy"></param>
        public void AddCommandArguments(string patientDfn, string pregnancyIen)
        {
            //Example of RPC call in CPRS to get the Women's Health data
            //WVRPCOR COVER
            //Params------------------------------------------------------------------
            //literal 2
            //literal 1
            //Results---------------------------------------------------------------- -
            //1 ^
            //4; 12,2,^ Pregnant:^ Yes
            //5; 11,2,^ Lactating:^ Yes

            this.CommandArgs = new object[] { patientDfn, pregnancyIen };
        }

        protected override void ProcessResponse()
        {
            if (this.ProcessSaveResponse())
            {
                this.Ien = Util.Piece(this.Response.Lines[0], Caret, 1);
                this.Pregnant = Util.Piece(this.Response.Lines[1], Caret, 3);
                this.Lactating = Util.Piece(this.Response.Lines[2], Caret, 3);
                this.Response.Status = RpcResponseStatus.Success;
            }
        }
    }
}
