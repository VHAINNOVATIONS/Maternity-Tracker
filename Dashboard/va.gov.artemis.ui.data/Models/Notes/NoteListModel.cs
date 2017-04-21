// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.UI.Data.Models.Common;
using VA.Gov.Artemis.UI.Data.Models.Notes;
using VA.Gov.Artemis.UI.Data.Models.Patient;

namespace VA.Gov.Artemis.UI.Data.Models.Notes
{
    public class NoteListModel: NotesIndexModelBase
    {
        public List<TiuNote> ProgressNotes {get; set;}
        public Paging ProgressNotePaging { get; set; }

        // *** Filter Handling ***
        //public Dictionary<string, string> PregnancyFilters { get; set; }
        //public string CurrentPregnancyFilter { get; set; }

        public string DetailAction { get; set; }

        public NoteListModel () : base()
        {
            this.Patient = new BasePatient();
            this.ProgressNotes = new List<TiuNote>();
            this.ProgressNotePaging = new Paging(); 
        }
    }
}