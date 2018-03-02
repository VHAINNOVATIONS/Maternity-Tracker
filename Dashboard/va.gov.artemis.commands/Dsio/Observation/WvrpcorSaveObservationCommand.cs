using System.Collections.Generic;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.Commands.Dsio.Observation
{
    /// <summary>
    /// A command used to save an observation to VistA using an RPC  
    /// </summary>
    public class WvrpcorSaveObservationCommand : DsioCommand
    {
        /// <summary>
        /// Creates the command
        /// </summary>
        /// <param name="newBroker">A broker which allows communication with VistA and implements the IRpcBroker interface</param>
        public WvrpcorSaveObservationCommand(IRpcBroker newBroker) : base(newBroker) { }

        /// <summary>
        /// The IEN of the observation
        /// </summary>
        public string Ien { get; set; }

        /// <summary>
        /// The name of the RPC 
        /// </summary>
        public override string RpcName
        {
            get { return "WVRPCOR SAVEDATA"; }
        }

        /// <summary>
        /// Add command arguments that are passed into the RPC 
        /// </summary>
        /// <param name="patientDfn">Patient DFN</param>
        /// <param name="isLactating">Boolean shoing if the patient is lactating</param>
        public void AddCommandArguments(string patientDfn, bool isLactating)
        {
            //Example of RPC call in CPRS
            //(1) = PATIENT = 3
            //(2) = LACTATION STATUS = Yes

            var patient = "PATIENT=";
            var lactating = "LACTATION STATUS=";

            List<string> termsList = new List<string>();
            patient = patient + patientDfn;
            lactating = lactating + (isLactating ? "Yes" : "No");
            termsList.Add(patient);
            termsList.Add(lactating);

            string[] arguments = termsList.ToArray();
            this.CommandArgs = new object[] { arguments };
        }

        protected override void ProcessResponse()
        {
            if (this.ProcessSaveResponse())
            {
                this.Ien = Util.Piece(this.Response.Lines[0], Caret, 1);
                this.Response.Status = RpcResponseStatus.Success;
            }
        }
    }
}
