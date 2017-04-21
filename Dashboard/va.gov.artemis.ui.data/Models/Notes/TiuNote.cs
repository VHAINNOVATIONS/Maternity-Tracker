// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.UI.Data.Models.Notes
{
    public class TiuNote
    {
        public string Ien { get; set; }
        public DateTime DocumentDateTime { get; set; }
        public string Title { get; set; }
        public string Location { get; set; }
        public string Author { get; set; }
        public string PatientDfn { get; set; }
        public TiuNoteSignatureStatus SignatureStatus { get; set; }
        public string ParentIen { get; set; }
        public string Subject { get; set; }
        public string NoteText { get; set; }
        public string PregnancyIen { get; set; }

        public Dictionary<string, string> NoteData { get; set; }

        public List<string> AddendaIens { get; set; }

        public bool IsAddendum
        {
            get
            {
                return (!string.IsNullOrWhiteSpace(this.ParentIen));
            }
        }

        public bool IsDashboardNote
        {
            get
            {
                return (this.Title == TiuNoteTitleInfo.GetTitleText(TiuNoteTitle.MccDashboardNote));
            }
        }

        public bool IsCdaNote
        {
            get
            {
                return (this.Title == TiuNoteTitleInfo.GetTitleText(TiuNoteTitle.DashboardCdaIncoming));
            }
        }

        public string SignatureStatusDisplay
        {
            get
            {
                string[] vals = new string[] { "Unknown", "Unsigned", "Signed" };

                return vals[(int)this.SignatureStatus];
            }
        }

        public string DocumentDateTimeDisplay
        {
            get
            {
                return this.DocumentDateTime.ToString(VistaDates.UserDateTimeFormat);
            }
        }

        public TiuNote()
        {
            this.AddendaIens = new List<string>(); 
        }
    }
}
