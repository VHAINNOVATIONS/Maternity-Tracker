// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.Commands.Dsio.Pregnancy
{
    /// <summary>
    /// A command to save pregnancy details to a different namespace in VistA
    /// </summary>
    public class DsioSavePregDetailsToOtherNamespaceCommand: DsioCommand 
    {
        /// <summary>
        /// Creates the command
        /// </summary>
        /// <param name="newBroker">An object which allows communication with VistA and implements IRpcBroker</param>
        public DsioSavePregDetailsToOtherNamespaceCommand(IRpcBroker newBroker): base(newBroker){}

        /// <summary>
        /// The Ien of the person, either created or updated
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
        /// Add command arguments to the RPC call. 
        /// Call prior to calling "Execute"
        /// </summary>
        /// <param name="pregnancy"></param>
        public void AddCommandArguments(DsioPregnancy pregnancy, string patientDfn, bool isPatientPregnant)
        {
            //(1) = PATIENT = 3
            //(2) = ABLE TO CONCEIVE = Yes
            //(3) = PREGNANCY STATUS = Yes
            //(4) = LAST MENSTRUAL PERIOD DATE = 3171101
            //(5) = EXPECTED DUE DATE = 3180808
            //(6) = LACTATION STATUS = Yes

            var patient = "PATIENT=";
            var ableToConceive = "ABLE TO CONCEIVE=";
            var pregnant = "PREGNANCY STATUS=";
            //var lactating = "LACTATION STATUS=";
            //var lactatingValue = "Yes";

            var ableToConceiveValue = "Yes";            
            var pregnancyValue = isPatientPregnant ? "Yes" : "No";

            List<string> termsList = new List<string>();
            patient = patient + patientDfn;
            ableToConceive = ableToConceive + ableToConceiveValue;
            pregnant = pregnant + pregnancyValue;
            termsList.Add(patient);
            termsList.Add(ableToConceive);
            termsList.Add(pregnant);
            if (isPatientPregnant)
            {
                string LMPvalue = pregnancy.Lmp;      
                var LMP = "LAST MENSTRUAL PERIOD DATE=" + VistaDates.CenturyDateFormat(LMPvalue);
                termsList.Add(LMP);

                string EDDvalue = pregnancy.EDD;
                var EDD = "EXPECTED DUE DATE=" + VistaDates.CenturyDateFormat(EDDvalue);
                termsList.Add(EDD);
            }

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
