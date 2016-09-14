using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.UI.Data.Models.Patient;

namespace VA.Gov.Artemis.UI.Data.Models.Notes
{
    public class AddendaModel: PatientRelatedModel
    {
        public TiuNote OriginalNote { get; set; }
        public List<TiuNote> Addenda { get; set; }

        public AddendaModel()
        {
            this.Addenda = new List<TiuNote>(); 
        }
    }
}
