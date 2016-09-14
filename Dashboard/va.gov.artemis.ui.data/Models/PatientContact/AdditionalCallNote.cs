using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.UI.Data.Models.Notes;
using VA.Gov.Artemis.UI.Data.Models.Patient;

namespace VA.Gov.Artemis.UI.Data.Models.PatientContact
{
    public class AdditionalCallNote: PatientRelatedModel
    {
        public TiuNote Note { get; set; }

        public string PregnancyIen { get; set; }

        public Dictionary<string, string> Pregnancies { get; set; }

        public AdditionalCallNote()
        {
            this.Note = new TiuNote();
            this.Note.Title = TiuNoteTitleInfo.GetTitleText(TiuNoteTitle.PhoneCallAdditional);
        }
    }
}
