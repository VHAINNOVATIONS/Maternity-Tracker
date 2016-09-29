using System.Collections.Generic;
using VA.Gov.Artemis.Commands.Dsio.Notes;
using VA.Gov.Artemis.Commands.Tiu;
using VA.Gov.Artemis.UI.Data.Models.Notes;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Vista.Utility;
using VA.Gov.Artemis.UI.Data.Brokers.Common;
using System; 

namespace VA.Gov.Artemis.UI.Data.Brokers.Notes
{
    public class NoteRepository: RepositoryBase, INoteRepository
    {
        // Descriptions based on TiuNoteTitle enum
        //private string[] TiuNoteTitleText = new string[] { 
        //    "MCC DASHBOARD NOTE", 
        //    "DASHBOARD CDA INCOMING", 
        //    "OB H&P Initial",
        //    "MCC Phone Call #1 (Initial Contact)",
        //    "MCC Phone Call #2 (12 Weeks)",
        //    "MCC Phone Call #3 (20 Weeks)",
        //    "MCC Phone Call #4 (28 Weeks)",
        //    "MCC Phone Call #5 (36 Weeks)",
        //    "MCC Phone Call #6a (41 Weeks, Not Delivered)",
        //    "MCC Phone Call #6b (41 Weeks, Delivered)",
        //    "MCC Phone Call #7 (6 Weeks Post-Partum)",
        //    "MCC Phone Call – Additional"};

        public NoteRepository(IRpcBroker newBroker): base(newBroker)
        {

        }

        //public TiuNoteResult GetLatestProgressNote(string dfn)
        //{
        //    // *** Get latest progress note ***

        //    TiuNoteResult result = new TiuNoteResult(); 

        //    // *** Check broker ***
        //    if (this.broker != null)
        //    {
        //        // *** Create command to get documents ***
        //        TiuDocumentsByContextCommand command = new TiuDocumentsByContextCommand(this.broker);

        //        // *** Add parameter ***
        //        command.AddCommandArgument(dfn);

        //        // *** Execute command ***
        //        RpcResponse response = command.Execute();

        //        // *** Set return vals ***
        //        result.Success = (response.Status == RpcResponseStatus.Success);
        //        result.Message = response.InformationalMessage;

        //        // *** Check for success ***
        //        if (result.Success)
        //        {                    
        //            TiuNote latestNote = null;

        //            // *** Check if we have any and loop ***
        //            if (command.Documents != null)
        //                foreach (TiuDocument doc in command.Documents)
        //                {
        //                    // *** Set latest if needed ***
        //                    if (latestNote == null)
        //                        latestNote = GetTiuNote(doc);
        //                    else
        //                    {
        //                        TiuNote tempNote = GetTiuNote(doc);

        //                        // *** Check if newer ***
        //                        if (tempNote.DocumentDateTime > latestNote.DocumentDateTime)
        //                            latestNote = tempNote; 
        //                    }
        //                }

        //            // *** Check if we have one after loop ***
        //            if (latestNote != null)
        //            {                     
        //                // *** Set return ***
        //                result.Note = latestNote;

        //                // *** Create command to get note text ***
        //                TiuGetRecordTextCommand textCommand = new TiuGetRecordTextCommand(this.broker);

        //                // *** Add parameter ***
        //                textCommand.AddCommandArgument(latestNote.Ien);

        //                // *** Execute command ***
        //                response = textCommand.Execute();

        //                // *** Set return value ***
        //                result.Success = (response.Status == RpcResponseStatus.Success);
        //                result.Message = response.InformationalMessage;

        //                if (result.Success)
        //                    result.Note.NoteText = textCommand.RecordText; 
        //            }                    
        //        }        
        //    }

        //    return result; 
        //}

        //private TiuNote GetTiuNote(TiuDocument document)
        //{
        //    // *** Create tiu note from tiu document ***

        //    TiuNote returnVal = new TiuNote();

        //    returnVal.Ien = document.Ien;
        //    returnVal.DocumentDateTime = Util.GetDateTime(document.DocumentDateTime);
        //    returnVal.Title = document.Title; 
            
        //    return returnVal; 
        //}

        //public HasProgressNoteResult HasProgressNote(string dfn)
        //{
        //    // *** Determine if patient has a progress note ***

        //    HasProgressNoteResult result = new HasProgressNoteResult();

        //    // *** Make sure we have broker ***
        //    if (this.broker != null)
        //    {
        //        // *** Create documents command ***
        //        TiuDocumentsByContextCommand command = new TiuDocumentsByContextCommand(this.broker);

        //        // *** Add parameter ***
        //        command.AddCommandArgument(dfn);

        //        // *** Execute command ***
        //        RpcResponse response = command.Execute();

        //        // *** Set return values ***
        //        result.Success = (response.Status == RpcResponseStatus.Success);
        //        result.Message = response.InformationalMessage;

        //        // *** Check result/command for prog notes ***
        //        if (result.Success)
        //            if (command.Documents != null)
        //                if (command.Documents.Count > 0)
        //                    result.HasProgressNote = true;
        //    }
            
        //    return result; 
        //}

        //public TiuNoteResult GetProgressNote(string ien)
        //{
        //    TiuNoteResult result = new TiuNoteResult();

        //    // *** Set return ***
        //    //result.Note = latestNote;

        //    // *** Create command to get note text ***
        //    TiuGetRecordTextCommand textCommand = new TiuGetRecordTextCommand(this.broker);

        //    // *** Add parameter ***
        //    textCommand.AddCommandArgument(ien);

        //    // *** Execute command ***
        //    RpcResponse response = textCommand.Execute();

        //    // *** Set return value ***
        //    result.Success = (response.Status == RpcResponseStatus.Success);
        //    result.Message = response.InformationalMessage;

        //    result.Note = new TiuNote();

        //    if (result.Success)
        //        result.Note.NoteText = textCommand.RecordText;

        //    return result;
        //}

        public NoteListResult GetList(string dfn)
        {
            // *** Get list of progress notes ***

            NoteListResult result = new NoteListResult();

            // *** Check broker ***
            if (this.broker != null)
            {
                // *** Create command to get documents ***
                TiuDocumentsByContextCommand command = new TiuDocumentsByContextCommand(this.broker);

                // *** Add parameter ***
                command.AddCommandArgument(dfn);

                // *** Execute command ***
                RpcResponse response = command.Execute();

                // *** Set return vals ***
                result.Success = (response.Status == RpcResponseStatus.Success);
                result.Message = response.InformationalMessage;

                // *** Check for success ***
                if (result.Success)
                {
                    // *** Check if we have any and loop ***
                    if (command.Documents != null)
                        foreach (TiuDocument doc in command.Documents)
                        {
                            TiuNote note = GetTiuNote(doc);

                            note.PatientDfn = dfn;

                            result.Notes.Add(note);
                        }
                }
            }

            return result;
        }

        public IenResult CreateNote(TiuNoteTitle noteTitle, string dfn, string noteText, string noteSubject, Dictionary<string, string> noteData, string pregIen)
        {
            IenResult returnResult = new IenResult();

            if (this.broker != null)
            {
                DsioCreateANoteCommand command = new DsioCreateANoteCommand(broker);

                //string noteTitleText = "MCC DASHBOARD NOTE"; 
                string noteTitleText = TiuNoteTitleInfo.TiuNoteTitleText[(int)noteTitle];
                command.AddCommandArguments(dfn, noteTitleText, noteText, noteSubject, noteData, pregIen);

                RpcResponse response = command.Execute();

                returnResult.Success = (response.Status == RpcResponseStatus.Success);
                returnResult.Message = response.InformationalMessage;

                if (response.InformationalMessage.Equals("Unable to assemble XWB broker message: Attempted to L-Pack a string longer than 999 characters.", StringComparison.CurrentCultureIgnoreCase))
                    returnResult.Message = "Individual lines within a note must be less than 1000 characters.";

                if (returnResult.Success)
                    returnResult.Ien = command.Ien; 
            }

            return returnResult; 
        }

        //public BrokerOperationResult CreateCdaNote(string dfn, string noteText)
        //{
        //    // *** Creates a CDA progress note ***

        //    BrokerOperationResult returnResult = new BrokerOperationResult();

        //    if (this.broker != null)
        //    {
        //        // *** Create the command ***
        //        DsioCreateANoteCommand command = new DsioCreateANoteCommand(broker);

        //        // *** Add command arguments ***
        //        string noteTitle = TiuNoteTitleText[(int)TiuNoteTitle.DashboardCdaIncoming]; 
        //        command.AddCommandArguments(dfn, noteTitle, noteText, "", "");

        //        // *** Execute the command ***
        //        RpcResponse response = command.Execute();

        //        // *** Add results to return ***
        //        returnResult.Success = (response.Status == RpcResponseStatus.Success);
        //        returnResult.Message = response.InformationalMessage;

        //    }

        //    return returnResult;
        //}

        public NoteListResult GetNotesByTitle(List<TiuNoteTitle> noteTitles, string dfn, int page, int itemsPerPage, string pregIen)
        {
            // *** Get a page of dashboard notes for a patient ***

            NoteListResult returnResult = new NoteListResult();

            if (this.broker != null)
            {
                DsioGetTiuNotesCommand command = new DsioGetTiuNotesCommand(broker);

                List<string> titles = new List<string>(); 
                foreach (TiuNoteTitle noteTitle in noteTitles)
                    titles.Add(TiuNoteTitleInfo.TiuNoteTitleText[(int)noteTitle]);

                command.AddCommandArguments(dfn, titles.ToArray(),"","", page, itemsPerPage, true,"", pregIen);

                RpcResponse response = command.Execute();

                returnResult.Success = (response.Status == RpcResponseStatus.Success);

                returnResult.Message = response.InformationalMessage;

                if (returnResult.Success)
                {
                    returnResult.TotalResults = command.TotalResults; 

                    foreach (TiuDocument doc in command.Notes)
                    {
                        TiuNote note = GetDashboardNote(doc);

                        note.PatientDfn = dfn;

                        returnResult.Notes.Add(note); 
                    }
                }

            }

            return returnResult; 
        }

        public TiuNoteResult GetNoteHeader(string dfn, string noteIen)
        {
            TiuNoteResult result = new TiuNoteResult();

            List<string> titles = new List<string>();
            foreach (object val in Enum.GetValues(typeof(TiuNoteTitle)))
            {
                string title = TiuNoteTitleInfo.TiuNoteTitleText[(int)val];

                if (!string.IsNullOrWhiteSpace(title))
                    titles.Add(title);
            }

            DsioGetTiuNotesCommand command = new DsioGetTiuNotesCommand(this.broker);

            command.AddCommandArguments(dfn, titles.ToArray(), "", "", 1, 1000, false, noteIen, "");

            RpcResponse response = command.Execute();

            result.SetResult(response.Status == RpcResponseStatus.Success, response.InformationalMessage);

            if (result.Success)
            {
                if (command.Notes != null)
                    if (command.Notes.Count > 0)
                        result.Note = this.GetDashboardNote(command.Notes[0]);
            }

            return result; 
        }

        public BrokerOperationResult UpdateNote(string ien, string noteText, string subject, Dictionary<string, string> noteData, string pregIen )
        {
            BrokerOperationResult result = new BrokerOperationResult();

            if (this.broker != null)
            {
                DsioUpdateANoteCommand command = new DsioUpdateANoteCommand(broker);

                command.AddCommandArguments(ien, noteText, subject, noteData, pregIen);

                RpcResponse response = command.Execute();

                result.Success = (response.Status == RpcResponseStatus.Success);
                result.Message = response.InformationalMessage;

                if (response.InformationalMessage.Equals("Unable to assemble XWB broker message: Attempted to L-Pack a string longer than 999 characters.", StringComparison.CurrentCultureIgnoreCase))
                    result.Message = "Individual lines within a note must be less than 1000 characters.";
            }

            return result; 
        }

        public BrokerOperationResult CreateAddendum(string ien, string noteText, string subject, Dictionary<string, string> noteData)
        {
            BrokerOperationResult returnResult = new BrokerOperationResult();

            if (this.broker != null)
            {
                DsioMakeAddendumCommand command = new DsioMakeAddendumCommand(broker);

                command.AddCommandArguments(ien, noteText, subject, noteData);

                RpcResponse response = command.Execute();

                returnResult.Success = (response.Status == RpcResponseStatus.Success);
                returnResult.Message = response.InformationalMessage;

                if (response.InformationalMessage.Equals("Unable to assemble XWB broker message: Attempted to L-Pack a string longer than 999 characters.", StringComparison.CurrentCultureIgnoreCase))
                    returnResult.Message = "Individual lines within a note must be less than 1000 characters.";
            }

            return returnResult;             
        }

        public BrokerOperationResult DeleteNote(string ien, string justification)
        {
            BrokerOperationResult result = new BrokerOperationResult(); 

            if (this.broker  != null) 
            {
                DsioDeleteANoteCommand command = new DsioDeleteANoteCommand(this.broker); 

                command.AddCommandArguments(ien, justification); 

                RpcResponse response = command.Execute(); 

                result.Success = (response.Status == RpcResponseStatus.Success); 
                result.Message = response.InformationalMessage; 
            }

            return result;
        }

        public BrokerOperationResult SignNote(string ien, string sig)
        {
            BrokerOperationResult result = new BrokerOperationResult();

            if (this.broker != null)
            {
                DsioSignANoteCommand command = new DsioSignANoteCommand(this.broker); 

                command.AddCommandArguments(ien, sig);

                RpcResponse response = command.Execute();

                result.Success = (response.Status == RpcResponseStatus.Success);
                result.Message = response.InformationalMessage;
            }

            return result;
            
        }

        public TiuNoteResult GetNote(string ien)
        {
            return GetDashboardNote(ien, DsioGetRecordTextMode.HeaderAndBody);
        }

        public TiuNoteResult GetNoteBody(string ien)
        {
            return GetDashboardNote(ien, DsioGetRecordTextMode.BodyOnly);
        }

        public TiuNoteResult GetNoteWithData(string ien)
        {
            TiuNoteResult result = new TiuNoteResult();

            result = GetNote(ien);

            if (result.Success)
            {
                //DsioGetNoteElementCommand command = new DsioGetNoteElementCommand(this.broker);
                DsioDdcsGetControlValue command = new DsioDdcsGetControlValue(this.broker);

                command.AddCommandArguments(ien);

                RpcResponse response = command.Execute();

                result.Success = (response.Status == RpcResponseStatus.Success);
                result.Message = response.InformationalMessage;

                if (result.Success)
                    result.Note.NoteData = command.NoteData; 

            }

            return result; 
        }

        public NoteListResult GetCallNotes(string dfn, string pregIen)
        {
            NoteListResult returnResult;

            List<TiuNoteTitle> titlesToInclude = new List<TiuNoteTitle>() 
            { 
                TiuNoteTitle.PhoneCall1, 
                TiuNoteTitle.PhoneCall2,
                TiuNoteTitle.PhoneCall3, 
                TiuNoteTitle.PhoneCall4, 
                TiuNoteTitle.PhoneCall5, 
                TiuNoteTitle.PhoneCall6a, 
                TiuNoteTitle.PhoneCall6b, 
                TiuNoteTitle.PhoneCall7, 
                TiuNoteTitle.PhoneCallAdditional 
            };

            returnResult = this.GetNotesByTitle(titlesToInclude, dfn, 1, 1000, pregIen); 

            return returnResult; 
        }

        private TiuNoteResult GetDashboardNote(string ien, DsioGetRecordTextMode mode) 
        {
            // TODO: Get header information also...

            TiuNoteResult result = new TiuNoteResult();

            if (this.broker != null)
            {
                                
                DsioGetRecordTextCommand command = new DsioGetRecordTextCommand(this.broker);

                command.AddCommandArgument(ien, mode);

                RpcResponse response = command.Execute();

                result.Success = (response.Status == RpcResponseStatus.Success);
                result.Message = response.InformationalMessage;

                if (result.Success)
                    result.Note = new TiuNote() { NoteText = command.RecordText, Ien = ien }; 
            }

            return result;
        }

        private TiuNote GetTiuNote(TiuDocument doc)
        {
            TiuNote returnVal = new TiuNote();

            returnVal.Ien = doc.Ien;
            returnVal.Author = Util.Piece(doc.Author, ";", 3);
            returnVal.DocumentDateTime = Util.GetDateTime(doc.DocumentDateTime);
            returnVal.Location = doc.Location;
            returnVal.Title = doc.Title;
            returnVal.Subject = doc.Subject;
            
            return returnVal;
        }

        private TiuNote GetDashboardNote(TiuDocument doc)
        {
            TiuNote returnVal = new TiuNote();

            returnVal.Ien = doc.Ien;

            switch (doc.SignatureStatus)
            {
                case "UNSIGNED":
                    returnVal.SignatureStatus = TiuNoteSignatureStatus.Unsigned;
                    break;
                case "COMPLETED":
                    returnVal.SignatureStatus = TiuNoteSignatureStatus.Completed;
                    break;
                default:
                    returnVal.SignatureStatus = TiuNoteSignatureStatus.Unknown;
                    break;
            }

            returnVal.Author = doc.Author;

            //CultureInfo enUS = new CultureInfo("en-US");
            //DateTime tempDateTime = DateTime.MinValue;
            //if (DateTime.TryParseExact(doc.DocumentDateTime, RepositoryDates.VistADateFormatOne, enUS, DateTimeStyles.None, out tempDateTime))
            //    returnVal.DocumentDateTime = tempDateTime;

            returnVal.DocumentDateTime = VistaDates.ParseDateString(doc.DocumentDateTime, VistaDates.VistADateFormatFour);

            if (returnVal.DocumentDateTime == DateTime.MinValue)
                returnVal.DocumentDateTime = VistaDates.ParseDateString(doc.DocumentDateTime, VistaDates.VistADateFormatEight); 

            returnVal.Location = doc.Location;

            returnVal.ParentIen = doc.ParentIen;
            returnVal.Subject = doc.Subject;

            returnVal.Title = doc.Title;

            // *** Split list of addenda iens ***
            if (!string.IsNullOrWhiteSpace(doc.AddendaIen))
                if (doc.AddendaIen.Contains("|"))
                    returnVal.AddendaIens.AddRange(doc.AddendaIen.Split("|".ToCharArray()));
                else
                    returnVal.AddendaIens.Add(doc.AddendaIen);

            returnVal.PregnancyIen = doc.PregnancyIen; 

            return returnVal;
        }
    }
}
