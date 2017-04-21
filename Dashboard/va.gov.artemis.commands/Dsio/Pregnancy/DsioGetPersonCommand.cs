// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Commands.Dsio.Base;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.Commands.Dsio.Pregnancy
{
    /// <summary>
    /// A command to get people associated with a patient for maternity tracking purposes 
    /// (e.g. Father of Fetus)
    /// </summary>
    public class DsioGetPersonCommand: DsioPagableCommand
    {
        /// <summary>
        /// The list of persons returned by RPC
        /// </summary>
        public List<DsioLinkedPerson> PersonList { get; set; }

        /// <summary>
        /// Creates the command
        /// </summary>
        /// <param name="newBroker">An object which allows communication with VistA and implements IRpcBroker</param>
        public DsioGetPersonCommand(IRpcBroker newBroker): base(newBroker)
        {

        }

        /// <summary>
        /// Add command parameters to be passed to RPC
        /// </summary>
        /// <param name="patientDfn"></param>
        /// <param name="personIen"></param>
        public void AddCommandArguments(string patientDfn, string personIen)
        {
            this.CommandArgs = new object[]{patientDfn, personIen};
        }

        /// <summary>
        /// The name of the RPC
        /// </summary>
        public override string RpcName
        {
            get { return "DSIO GET PERSON"; }
        }

        protected override void ProcessResponse()
        {
            base.ProcessResponse();

            // *** Override response ***
            if (this.Response.Status == RpcResponseStatus.Fail)
                if (string.IsNullOrWhiteSpace(this.Response.Data))
                    this.Response.Status = RpcResponseStatus.Success; 
                else if (Util.Piece(this.Response.Lines[0], "^", 1) == "-1")
                        if (Util.Piece(this.Response.Lines[0], "^", 2) == "PERSON(s) not found.")
                            this.Response.Status = RpcResponseStatus.Success; 

        }


        protected override void ProcessLine(string line)
        {
            if (this.PersonList == null)
                this.PersonList = new List<DsioLinkedPerson>();

            DsioLinkedPerson newPerson = new DsioLinkedPerson();

            // IEN^NAME^SEX^DOB^EDUCATION^STREET1^STREET2^STREET3^CITY^STATE^ZIP^PHONE HOME^PHONE WORK^PHONE CELL^PHONE FAX^PATIENT^DFN

            newPerson.Ien = Util.Piece(line, Caret, 1);
            newPerson.Name = Util.Piece(line, Caret, 2);
            newPerson.DOB = Util.Piece(line, Caret, 4);
            newPerson.YearsSchool = Util.Piece(line, Caret, 5);

            newPerson.Address = new DsioAddress();
            newPerson.Address.StreetLine1 = Util.Piece(line, Caret, 6);
            newPerson.Address.StreetLine2 = Util.Piece(line, Caret, 7);
            newPerson.Address.StreetLine3 = Util.Piece(line, Caret, 8);
            newPerson.Address.City = Util.Piece(line, Caret, 9);
            newPerson.Address.State = Util.Piece(line, Caret, 10);
            newPerson.Address.ZipCode = Util.Piece(line, Caret, 11);

            string tel = Util.Piece(line, Caret, 12);
            if (!string.IsNullOrWhiteSpace(tel))
                newPerson.TelephoneList.Add(new DsioTelephone() { Usage = DsioTelephone.HomePhoneUsage, Number = tel });

            tel = Util.Piece(line, Caret, 13);
            if (!string.IsNullOrWhiteSpace(tel))
                newPerson.TelephoneList.Add(new DsioTelephone() { Usage = DsioTelephone.MobilePhoneUsage, Number = tel });

            tel = Util.Piece(line, Caret, 14);
            if (!string.IsNullOrWhiteSpace(tel))
                newPerson.TelephoneList.Add(new DsioTelephone() { Usage = DsioTelephone.WorkPhoneUsage, Number = tel });

            newPerson.PatientDfn = Util.Piece(line, Caret, 17); 

            this.PersonList.Add(newPerson);

        }

        protected override void ProcessEndData()
        {
            // Don't need anything...
        }
    }
}
