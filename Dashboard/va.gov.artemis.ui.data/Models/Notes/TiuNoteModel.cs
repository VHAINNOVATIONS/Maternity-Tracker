using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.UI.Data.Models.Patient;

namespace VA.Gov.Artemis.UI.Data.Models.Notes
{
    public class TiuNoteModel: PatientRelatedModel
    {
        public TiuNote Note { get; set; }

        public string ReturnUrl { get; set; }

        public Dictionary<string, string> DiscreteData { get; set; }

        public Dictionary<string, string> Pregnancies { get; set; }

        public string PregnancyDescription { get; set; }

        public TiuNoteModel()
        {
            this.Note = new TiuNote();
            this.Pregnancies = new Dictionary<string, string>();
        }
    }
}
