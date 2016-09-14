using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.UI.Data.Models.PatientContact;
using VA.Gov.Artemis.UI.Data.Models.Patient;
using VA.Gov.Artemis.UI.Data.Models.Checklist;
using VA.Gov.Artemis.UI.Data.Models.Common;

namespace VA.Gov.Artemis.UI.Data.Models.PatientContact
{
    public class PatientContactIndex : NotesIndexModelBase
    {
        //public string PregnancyIen { get; set; }

        public PregnancyChecklistItemList Checklist { get; set; }

        //public Dictionary<string, string> PregnancyFilter { get; set; }

        public PatientContactIndex()
        {
            this.Checklist = new PregnancyChecklistItemList();
            //this.PregnancyFilter = new Dictionary<string, string>(); 
        }
    }
}
