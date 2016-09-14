using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Commands.Dsio;
using VA.Gov.Artemis.Core;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Vista.Commands;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.Commands.Dsio.Tracking
{
    public class DsioGetTrackingCommand: DsioCommand
    {
        /// <summary>
        /// Creates the command
        /// </summary>
        /// <param name="newBroker">An object which allows communication with VistA and implements IRpcBroker</param>
        public DsioGetTrackingCommand(IRpcBroker newBroker): base(newBroker) {}        

        public DsioGetTrackingOperation operation { get; set; }

        public override string RpcName
        {
            get { return "DSIO GET TRACKING"; }
        }

        // *** Various lists that can be returned by rpc ***
        public List<DsioTrackingItem> TrackingItems { get; set; }
        public DsioFlaggedPatientResult FlaggedPatientResult { get; set; }
        public List<DsioTrackedPatient> TrackedPatients { get; set; }

        // *** Count of unpaged results ***
        public int TotalResults { get; set; }

        //public void AddGetAllParameters()
        //{
        //    this.operation = DsioGetTrackingOperation.All;
        //}

        public void AddGetAllParameters(int page, int itemsPerPage)
        {
            this.operation = DsioGetTrackingOperation.All;

            this.CommandArgs = new object[] { 
                "", 
                string.Format("{0},{1}", page, itemsPerPage)
            };
           
        }

        public void AddGetFlaggedPatientsParameters(int page, int itemsPerPage)
        {
            this.CommandArgs = new object[] 
            { 
                "F", 
                string.Format("{0},{1}", page, itemsPerPage)
            };

            this.operation = DsioGetTrackingOperation.Flagged; 
        }

        public void AddPatientLogsParameter(string dfn)
        {

            this.CommandArgs = new object[] 
            { 
                string.Format("{0}", dfn) 
            };

            this.operation = DsioGetTrackingOperation.PatientFlags;
        }

        public void AddPatientLogsParameter(string dfn, int page, int itemsPerPage)
        {
            this.CommandArgs = new object[] 
            { 
                string.Format("{0}", dfn), 
                string.Format("{0},{1}", page, itemsPerPage) 
            };

            this.operation = DsioGetTrackingOperation.PatientFlags;
        }

        public void AddGetTrackedPatientsParameters(int page, int itemsPerPage)
        {
            string pageParam = (page > 0) ? page.ToString() : "";
            string pageSizeParam = (itemsPerPage > 0) ? itemsPerPage.ToString() : ""; 

            string sortParam = "";

            if ((page > 0) || (itemsPerPage > 0))
                sortParam = string.Format("{0},{1}", page, itemsPerPage);

            this.CommandArgs = new object[] 
            { 
                "T", 
                sortParam
            };

            this.operation = DsioGetTrackingOperation.Tracked;
        }

//-1^ERROR MESSAGE

//ID^DT OF TRACKING^DFN^LASTNAME,FIRSTNAME^USER^TRACKING TYPE^SOURCE^REASON|REASON
//ID^COMMENT

        protected override void ProcessResponse()
        {

            // *** Make sure we have something to work with ***
            if (string.IsNullOrWhiteSpace(this.Response.Data))
            {
                // *** Set response info ***
                this.Response.Status = RpcResponseStatus.Fail;
                this.Response.InformationalMessage = "No data returned";
            }
            else
            {
                // *** Check first piece for success/failure ***
                string first = Util.Piece(this.Response.Lines[0], Caret, 1);

                char[] chars = first.ToCharArray();

                if ((int)chars[0] == 24)
                {
                    this.Response.Status = RpcResponseStatus.Fail;
                    this.Response.InformationalMessage = "An internal error has occurred";
                    ErrorLogger.Log(string.Format("M Error Calling RPC '{0}': {1}", this.RpcName, this.Response.Data)); 
                }
                else if (first == "-1")
                {
                    // *** -1 is fail ***
                    this.Response.Status = RpcResponseStatus.Fail;
                    this.Response.InformationalMessage = Util.Piece(this.Response.Lines[0], "^", 2);

                    // *** Ok if no matches ***
                    if (this.Response.InformationalMessage.ToUpper().StartsWith("NO ENTRIES"))
                    {
                        this.Response.Status = RpcResponseStatus.Success;
                        this.TrackingItems = new List<DsioTrackingItem>();
                    }
                }
                else if (first == "0")
                {
                    this.Response.Status = RpcResponseStatus.Success;
                    this.TrackingItems = new List<DsioTrackingItem>();
                    this.Response.InformationalMessage = "Nothing Found";
                    this.TotalResults = 0;
                }
                else
                {
                    switch (this.operation)
                    {
                        case DsioGetTrackingOperation.All:
                        case DsioGetTrackingOperation.PatientFlags:
                            ProcessAll();
                            break;
                        case DsioGetTrackingOperation.Flagged:
                            ProcessFlagged();
                            break;
                        case DsioGetTrackingOperation.Tracked:
                            ProcessTracked();
                            break;
                    }

                }
            }
        }

        private void ProcessAll()
        {
            // *** Non -1 is success ***
            string entryId = "";
            string prevEntryId = "";
            DsioTrackingItem item = null;
            
            // *** Use flag to indicate if first line is count ***
            //bool first = (this.operation == DsioGetTrackingOperation.All) ? true : false; 
            bool first = true; 

            // *** Loop through all lines ***
            foreach (string line in this.Response.Lines)
            {
                if (first)
                {
                    int count;
                    if (int.TryParse(line, out count))
                        this.TotalResults = count;
                    first = false;
                }
                else
                {
                    // *** Get type first ***
                    string lineType = Util.Piece(line, Caret, 1);

                    switch (lineType)
                    {
                        case "L":
                            // *** Add the previous item before creating a new one ***
                            AddTrackedItem(item);

                            // *** New tracking item ***
                            item = GetNewTrackingItem(line);

                            // *** Keep track of what the previous entry was ***
                            prevEntryId = entryId;

                            break;
                        case "P":
                            break;
                        case "C":
                            // *** Comment for previous tracking item ***
                            if (item != null)
                                item.Comment += Util.Piece(line, Caret, 3) + Environment.NewLine;

                            break;
                    }
                }
            }

            // *** Add the last (or only) item ***
            AddTrackedItem(item);
        }

        private void ProcessFlagged()
        {
            string currentPatient="";
            string currentTrackingItem = "";

            this.FlaggedPatientResult = new DsioFlaggedPatientResult();

            bool first = true; 

            // *** Loop through all lines ***
            foreach (string line in this.Response.Lines)
            {
                if (first)
                {
                    int count;
                    if (int.TryParse(line, out count))
                        this.TotalResults = count;
                    first = false;
                }
                else
                {

                    string lineType = Util.Piece(line, Caret, 1);

                    switch (lineType)
                    {
                        case "P":
                            // Patient line 
                            DsioFlaggedPatient flaggedPatient = new DsioFlaggedPatient();

                            flaggedPatient.Dfn = Util.Piece(line, Caret, 2);
                            string fullName = Util.Piece(line, CommandBase.Caret, 3);
                            flaggedPatient.LastName = Util.Piece(fullName, ",", 1);
                            flaggedPatient.FirstName = Util.Piece(fullName, ",", 2);
                            flaggedPatient.Last4 = Util.Piece(line, Caret, 4);
                            flaggedPatient.DateOfBirth = Util.Piece(line, Caret, 5);

                            this.FlaggedPatientResult.FlaggedPatients.Add(flaggedPatient.Dfn, flaggedPatient);

                            currentPatient = flaggedPatient.Dfn;
                            break;

                        case "C":
                            // Comment line 
                            string comment = Util.Piece(line, Caret, 3);

                            if (this.FlaggedPatientResult.FlaggedPatients.ContainsKey(currentPatient))
                                if (this.FlaggedPatientResult.FlaggedPatients[currentPatient].TrackingItems.ContainsKey(currentTrackingItem))
                                    this.FlaggedPatientResult.FlaggedPatients[currentPatient].TrackingItems[currentTrackingItem].Comment += string.Format("{0}{1}", comment, Environment.NewLine);

                            break;

                        case "L":

                            // Entry line
                            DsioTrackingItem trackingItem = GetFlaggedTrackingItemFromLine(line);

                            if (this.FlaggedPatientResult.FlaggedPatients.ContainsKey(currentPatient))
                                this.FlaggedPatientResult.FlaggedPatients[currentPatient].TrackingItems.Add(trackingItem.Id, trackingItem);

                            currentTrackingItem = trackingItem.Id;
                            break;

                    }
                }
            }
        }
        
        private DsioTrackingItem GetFlaggedTrackingItemFromLine(string line)
        {
            // *** New tracking item ***
            DsioTrackingItem item = new DsioTrackingItem();

            // *** Add the values ***
            item.Id = Util.Piece(line, Caret, 2).Substring(1);
            item.TrackingItemDateTime = Util.Piece(line, Caret, 3);
            item.Dfn = Util.Piece(line, Caret, 4);
            item.PatientName = Util.Piece(line, Caret, 5);
            item.User = Util.Piece(line, Caret, 6);
            item.TrackingType = Util.Piece(line, Caret, 7);
            item.Source = Util.Piece(line, Caret, 8);

            // TODO: Support list of reasons...
            item.Reason = Util.Piece(line, Caret, 9);

            return item;
        }

        private void AddTrackedItem(DsioTrackingItem item)
        {
            // *** Check if we already have an item ***
            if (item != null)
            {
                // *** Create the list if necessary ***
                if (this.TrackingItems == null)
                    this.TrackingItems = new List<DsioTrackingItem>();

                // *** Add our previous item before we move on to next ***
                this.TrackingItems.Add(item);
            }
        }

        private DsioTrackingItem GetNewTrackingItem(string line)
        {
            // *** New tracking item ***
            DsioTrackingItem item = new DsioTrackingItem();

            // *** Add the values ***
            string piece1 = Util.Piece(line, Caret, 1);
            item.Id = Util.Piece(line, Caret, 2);
            item.TrackingItemDateTime = Util.Piece(line, Caret, 3);
            item.Dfn = Util.Piece(line, Caret, 4);
            item.PatientName = Util.Piece(line, Caret, 5);
            item.User = Util.Piece(line, Caret, 6);
            item.TrackingType = Util.Piece(line, Caret, 7);
            item.Source = Util.Piece(line, Caret, 8);

            // TODO: Support list of reasons...
            item.Reason = Util.Piece(line, Caret, 9);

            return item;
        }

        private void ProcessTracked()
        {
            // *** Create tracked patient objects from response lines ***

            this.TrackedPatients = new List<DsioTrackedPatient>();

            bool first = true; 

            // *** Loop through all lines ***
            foreach (string line in this.Response.Lines)
            {
                if (first)
                {
                    int count = -1;
                    if (int.TryParse(line, out count))
                        this.TotalResults = count;
                    first = false;
                }
                else
                {
                    DsioTrackedPatient patient = new DsioTrackedPatient();

                    //P^715^Drmpatient,Ten^0010^08/30/1954^5185551212^01/10/2015^Wednesday Test Obgyn^Smallish Hospital^YES^^SEP 28, 2014^SEP 08, 2014^SEP 23, 2014
                    // P^766^Bldaalufhxy,Shuhtl^2050^01/01/1948^^^^^YES^^01/01/2014^09/24/2014^01/01/2014

                    patient.Dfn = Util.Piece(line, Caret, 2);
                    string fullName = Util.Piece(line, Caret, 3);
                    patient.LastName = Util.Piece(fullName, ",", 1);
                    patient.FirstName = Util.Piece(fullName, ",", 2);
                    patient.Last4 = Util.Piece(line, Caret, 4);
                    patient.DateOfBirth = Util.Piece(line, Caret, 5);
                    patient.HomePhone = Util.Piece(line, Caret, 6);
                    patient.EDD = Util.Piece(line, Caret, 7);
                    patient.Obstetrician = Util.Piece(line, Caret, 8);
                    patient.LDFacility = Util.Piece(line, Caret, 9);
                    patient.Pregnant = Util.Piece(line, Caret, 10);
                    patient.Lactating = Util.Piece(line, Caret, 11);
                    patient.LastContactDate = Util.Piece(line, Caret, 12);
                    patient.NextContactDue = Util.Piece(line, Caret, 13);                    
                    patient.NextChecklistDue = Util.Piece(line, Caret, 14);
                    patient.CurrentPregnancyHighRisk = Util.Piece(line, Caret, 15);
                    patient.HighRiskDetails = Util.Piece(line, Caret, 16);
                    patient.Text4BabyStatus = Util.Piece(line, Caret, 17); 
                    
                    this.TrackedPatients.Add(patient);
                }
            }
        }
    }
}
