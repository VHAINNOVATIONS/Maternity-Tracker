// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Commands.Dsio.Base;
using VA.Gov.Artemis.Commands.Dsio.Pregnancy;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.Commands.Dsio
{
    /// <summary>
    /// A command to save person information 
    /// </summary>
    public class DsioSavePersonCommand: DsioCommand
    {
        /// <summary>
        /// The Ien of the person, either created or updated
        /// </summary>
        public string Ien { get; set; }

        /// <summary>
        /// Creates the command
        /// </summary>
        /// <param name="newBroker">An object which allows communication with VistA and implements IRpcBroker</param>
        public DsioSavePersonCommand(IRpcBroker newBroker): base(newBroker)
        {

        }

        public override string RpcName
        {
            get { return "WEBM SAVE PERSON"; }
        }

        /// <summary>
        /// Add command parameters to be passed into the RPC
        /// Add command parameters prior to calling "Execute"
        /// </summary>
        /// <param name="person"></param>
        public void AddCommandArguments(DsioLinkedPerson person) 
        {
            // *** Telephone numbers ***
            List<string> telParamList = new List<string>(); 

            if (person.TelephoneList != null)
                foreach (DsioTelephone tel in person.TelephoneList)
                telParamList.Add(tel.ToParam());

            //IEN,DFN,NAME,DOB,ADDR,PHONE,EDU,SEX,REL,STATUS,PROB

            // TODO: Implement other fields ? SEX, REL, STATUS, PROB

            this.CommandArgs = new object[]
            {
                person.Ien, 
                person.PatientDfn, 
                person.Name,
                person.DOB, 
                person.Address.ToParameter(), 
                telParamList.ToArray(),
                person.YearsSchool, 
                "M"
            };                

        }

        protected override void ProcessResponse()
        {
            if (this.ProcessSaveResponse())
            {
                string piece1 = Util.Piece(this.Response.Lines[0], Caret, 1);

                this.Ien = piece1;

                this.Response.Status = RpcResponseStatus.Success; 
            }
        }

    }
}
