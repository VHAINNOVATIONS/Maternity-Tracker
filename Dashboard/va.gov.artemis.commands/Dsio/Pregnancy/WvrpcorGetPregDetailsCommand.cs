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
            string lmpText = "LMP: ";
            string eddText = "EDD: ";
            string enteredByText = "Entered by: ";
            string enteredOnText = "Entered on: ";

            if (this.ProcessSaveResponse())
            {
                //----------------------------------------------------------------
                //Returned message when the Pregnancy status is "Yes"
                //               LMP: Oct 10, 2017
                //               EDD: Jul 17, 2018
                //
                //Entered by: FREY,ALINA
                //Entered on: Mar 05, 2018@10:06

                //----------------------------------------------------------------
                //Returned message when the Pregnancy status is "No"
                //<empty line>
                //Entered by: FREY,ALINA (Physician)
                //Entered on: Mar 08, 2018@15:17

                //----------------------------------------------------------------
                //Returned messages when the the pregnancy status is "Not Applicable"
                //Case 1: "The patient's age is outside of the age range 10 to 52 years old."
                //Case 2: "No data on file." - That seems to be the case when the patient was never pregnant
                //Case 3: The case when the patient is not able to conceive: The returned message is a string containing
                //any combination of the following: Hysterectomy, menopause, permanent female sterilization and 
                //other comments, then the Entered by and Entered on lines.
                if (this.Response.Lines != null)
                {
                    foreach (string line in this.Response.Lines)
                    {
                        if (!string.IsNullOrWhiteSpace(line))
                        {
                            if (line.IndexOf(lmpText) > -1)
                            {
                                string lmpDate = Util.Piece(line, lmpText, 2);
                                this.LMP = VistaDates.StandardizeDateFormat(lmpDate);
                            }
                            if (line.IndexOf(eddText) > -1)
                            {
                                string eddDate = Util.Piece(line, eddText, 2);
                                this.EDD = VistaDates.StandardizeDateFormat(eddDate);
                            }
                            if (line.IndexOf(enteredByText) > -1)
                            {
                                this.EnteredBy = Util.Piece(line, enteredByText, 2);
                            }
                            if (line.IndexOf(enteredOnText) > -1)
                            {
                                string enteredOn = Util.Piece(line, enteredOnText, 2);
                                this.Created = VistaDates.ParseDateString(enteredOn, VistaDates.VistADateFormatSeven);
                            }
                        }
                    }
                }

                this.Response.Status = RpcResponseStatus.Success;
            }
        }
    }
}
