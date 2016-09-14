using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.UI.Data.Models.Common;
using VA.Gov.Artemis.UI.Data.Models.Notes;
using VA.Gov.Artemis.UI.Data.Models.Patient;
using VA.Gov.Artemis.UI.Data.Models.Track;

namespace VA.Gov.Artemis.UI.Data.Models.FlaggedPatients
{
    public class FlaggedPatientDetail: NoteListModel
    {
        public List<TrackingEntry> TrackingEntries { get; set; }

        public FlaggedPatientDetail()
        {
            this.TrackingEntries = new List<TrackingEntry>();
            this.Patient = new BasePatient();
            this.ProgressNotes = new List<TiuNote>();
            this.ProgressNotePaging = new Paging(); 
        }

        public string ReturnUrl { get; set; }
    }
}
