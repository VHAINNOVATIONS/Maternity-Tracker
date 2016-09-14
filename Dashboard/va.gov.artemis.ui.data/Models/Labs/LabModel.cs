using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.UI.Data.Models.Common;
using VA.Gov.Artemis.UI.Data.Models.Patient;

namespace VA.Gov.Artemis.UI.Data.Models.Labs
{
    public class LabModel: PatientRelatedModel
    {
        public List<LabItem> Items { get; set; }

        public Paging Paging { get; set; }

        //public string CurrentPregnancyIen { get; set; }

        //public bool CurrentPregnancyFilter { get; set; }

        //public string FilterPregnancyIen { get; set; }
        public string PregnancyFilterDescription { get; set; }
        public bool FilteredByPregnancy { get; set; }

        public string LabTypeFilter { get; set; }

        public LabModel()
        {
            this.Paging = new Paging(); 
        }


        public bool CanFilterByPregnancy { get; set; }
    }
}
