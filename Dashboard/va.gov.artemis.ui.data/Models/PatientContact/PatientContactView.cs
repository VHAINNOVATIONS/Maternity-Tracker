// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.UI.Data.Models.Notes;

namespace VA.Gov.Artemis.UI.Data.Models.PatientContact
{
    public class PatientContactView: TiuNoteModel
    {
        public string ChecklistIen { get; set; }

        public string PregnancyIen { get; set; }

        public string Esig { get; set; }

        public string GestationalAgeMessage { get; set; }

        public PatientContactView()
        {
            this.Note = new TiuNote(); 
        }

    }
}
