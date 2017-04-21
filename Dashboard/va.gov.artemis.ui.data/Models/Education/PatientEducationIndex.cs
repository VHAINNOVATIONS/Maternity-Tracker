// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.UI.Data.Models.Checklist;
using VA.Gov.Artemis.UI.Data.Models.Common;
using VA.Gov.Artemis.UI.Data.Models.Patient;

namespace VA.Gov.Artemis.UI.Data.Models.Education
{
    public class PatientEducationIndex: PatientRelatedModel
    {
        public PatientEducationList ItemList { get; set; }
        
        public Paging Paging { get; set; }

        //public string SelectedItemIen { get; set; }
        public string SelectedChecklistIen { get; set; }
        public string SelectedEducationIen { get; set; }
        public string SelectedPatEdIen { get; set; }

        public PatientEducationIndex()
        {
            this.Paging = new Paging();
            this.ItemList = new PatientEducationList(); 
        }
    }
}
