// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.UI.Data.Models.Patient;

namespace VA.Gov.Artemis.UI.Data.Models.Common
{
    public abstract class NotesIndexModelBase: PatientRelatedModel
    {
        // *** Filter Handling ***
        public Dictionary<string, string> PregnancyFilters { get; set; }
        public string CurrentPregnancyFilter { get; set; }

        // *** Paging ***
        // TODO: Move paging to here from derived...
        //public Paging Paging { get; set; }

        public NotesIndexModelBase()
        {
            this.PregnancyFilters = new Dictionary<string, string>();
            //this.Paging = new Paging(); 
        }

    }
}
