// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Commands.Dsio.Notes;
using VA.Gov.Artemis.UI.Data.Models.Notes;
using VA.Gov.Artemis.UI.Data.Brokers.Common; 

namespace VA.Gov.Artemis.UI.Data.Brokers.Notes
{
    public interface INoteRepository
    {
        //TiuNoteResult GetLatestProgressNote(string dfn);

        //HasProgressNoteResult HasProgressNote(string dfn);

        //TiuNoteResult GetProgressNote(string ien);

        NoteListResult GetList(string dfn);

        IenResult CreateNote(TiuNoteTitle noteTitle, string dfn, string noteText, string noteSubject, Dictionary<string, string> noteData, string pregIen);

        NoteListResult GetNotesByTitle(List<TiuNoteTitle> noteTitles, string dfn, int page, int itemsPerPage, string pregIen);

        BrokerOperationResult UpdateNote(string ien, string noteText, string subject, Dictionary<string, string> noteData, string pregIen);

        BrokerOperationResult CreateAddendum(string ien, string noteText, string subject, Dictionary<string, string> noteData);

        BrokerOperationResult DeleteNote(string ien, string justification);

        BrokerOperationResult SignNote(string ien, string sig);

        TiuNoteResult GetNote(string ien);

        TiuNoteResult GetNoteBody(string ien);

        TiuNoteResult GetNoteWithData(string ien);

        TiuNoteResult GetNoteHeader(string dfn, string noteIen);

        NoteListResult GetCallNotes(string dfn, string pregIen);
    }
}
