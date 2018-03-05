using System;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.Commands.Dsio.Pregnancy
{
    /// <summary>
    /// A command to get Women's Health details from WVRPCOR namespace in VistA
    /// </summary>
    public class WvrpcorGetPregDetailsCommand : DsioCommand
    {
        /// <summary>
        /// Creates the command
        /// </summary>
        /// <param name="newBroker">An object which allows communication with VistA and implements IRpcBroker</param>
        public WvrpcorGetPregDetailsCommand(IRpcBroker newBroker) : base(newBroker) { }

        public string LMP { get; set; }
        public string EDD { get; set; }
        public DateTime Created { get; set; }
        public string EnteredBy { get; set; }
        private bool pregnant = false;

        /// <summary>
        /// The name of the RPC
        /// </summary>
        public override string RpcName
        {
            get { return "WVRPCOR DETAIL"; }
        }

        /// <summary>
        /// Add command arguments to the RPC call. 
        /// Call prior to calling "Execute"
        /// </summary>
        /// <param name="pregnancy"></param>
        public void AddCommandArguments(string pregnancyData, string secondArgument, string pregnantCPRS)
        {
            //Example of RPC call in CPRS to get the Women's Health data
            //WVRPCOR DETAIL
            //Params------------------------------------------------------------------
            //literal 4;19,2,
            //literal 0
            //Results---------------------------------------------------------------- -
            //               LMP: Oct 10, 2017
            //               EDD: Jul 17, 2018
            //
            //Entered by: FREY,ALINA
            //Entered on: Mar 05, 2018@10:06
            if (pregnantCPRS == "Yes")
            {
                this.pregnant = true;
            }
            this.CommandArgs = new object[] { pregnancyData, secondArgument };
        }

        protected override void ProcessResponse()
        {
            var enteredOn = "";
            if (this.ProcessSaveResponse())
            {
                if (this.pregnant)
                {
                    var lmpDate = Util.Piece(this.Response.Lines[0], "LMP: ", 2);
                    var eddDate = Util.Piece(this.Response.Lines[1], "EDD: ", 2);
                    this.EnteredBy = Util.Piece(this.Response.Lines[3], "Entered by: ", 2);
                    enteredOn = Util.Piece(this.Response.Lines[4], "Entered on: ", 2);
                    this.EDD = VistaDates.StandardizeDateFormat(eddDate);
                    this.LMP = VistaDates.StandardizeDateFormat(lmpDate);
                }
                else
                {
                    this.EnteredBy = Util.Piece(this.Response.Lines[1], "Entered by: ", 2);
                    enteredOn = Util.Piece(this.Response.Lines[2], "Entered on: ", 2);
                }

                this.Created = VistaDates.ParseDateString(enteredOn, VistaDates.VistADateFormatSeven);
                this.Response.Status = RpcResponseStatus.Success;
            }
        }
    }
}
