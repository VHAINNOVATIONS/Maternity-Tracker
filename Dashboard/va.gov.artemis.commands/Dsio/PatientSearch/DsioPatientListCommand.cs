using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Vista.Commands;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.Commands.Dsio.PatientSearch
{
    public class DsioPatientListCommand : DsioPagableCommand
    {
        public List<DsioSearchPatient> MatchingPatients { get; set; }

        public DsioPatientListCommand(IRpcBroker newBroker)
            : base(newBroker)
        {
            this.MatchingPatients = new List<DsioSearchPatient>();
        }

        public void AddCommandArguments(string searchCriteria, int page, int itemsPerPage)
        {
            string pagingParam = ""; 
            if ((page > 0) && (itemsPerPage > 0))
                pagingParam = string.Format("{0},{1}", page, itemsPerPage); 

            this.CommandArgs = new object[] 
            {
                searchCriteria.ToUpper(), 
                pagingParam    
            };
        }

        public override string RpcName
        {
            get { return "DSIO PATIENT LIST"; }
        }

        protected override void ProcessLine(string line)
        {
            // DFN^LASTNAME,FIRSTNAME^SSN(LAST 4)^DATE OF BIRTH^VETERAN STATUS^LOCATION(WARD)^ROOM/BED^SERVICE CONNECTED^CURRENTLY TRACKING^SSN^CITY^STATE^ZIP^SENSITIVE STATUS (1,0)

            //;  CURRENTLY TRACKING: 0:NO,1:YES,2:FLAG
            //; IF NOTHING IS FOUND: RET(0)="0^Patient(s) not found."

            string fullName = Util.Piece(line, CommandBase.Caret, 2);
            string lastName = Util.Piece(fullName, ",", 1);
            string firstName = Util.Piece(fullName, ",", 2);

            DsioSearchPatient tempPatient = new DsioSearchPatient()
            {
                Dfn = Util.Piece(line, CommandBase.Caret, 1),
                LastName = lastName,
                FirstName = firstName,
                Last4 = Util.Piece(line, CommandBase.Caret, 3),
                DateOfBirth = Util.Piece(line, CommandBase.Caret, 4),
                Veteran = Util.Piece(line, CommandBase.Caret, 5),
                Location = Util.Piece(line, CommandBase.Caret, 6),
                RoomBed = Util.Piece(line, CommandBase.Caret, 7),
                ServiceConnected = Util.Piece(line, CommandBase.Caret, 8),
                TrackingStatus = Util.Piece(line, CommandBase.Caret, 9),
                SSN = Util.Piece(line, Caret, 10),
                City = Util.Piece(line, Caret, 11),
                State = Util.Piece(line, Caret, 12),
                Zip = Util.Piece(line, Caret, 13),
                Sensitive = Util.Piece(line, Caret, 14)
            };

            this.MatchingPatients.Add(tempPatient);
        }
    }
}
