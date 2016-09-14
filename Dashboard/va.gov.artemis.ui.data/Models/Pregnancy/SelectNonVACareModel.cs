using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.UI.Data.Models.Common;
using VA.Gov.Artemis.UI.Data.Models.NonVACare;
using VA.Gov.Artemis.UI.Data.Models.Patient;

namespace VA.Gov.Artemis.UI.Data.Models.Pregnancy
{
    public class SelectNonVACareModel: PatientRelatedModel
    {
        public SelectNonVACareModel()
        {
            this.Paging = new Paging(); 
        }

        //public BasePatient Patient { get; set; }

        public Paging Paging { get; set; }

        public List<NonVACareItem> Items { get; set; }

        public string PregnancyIen { get; set; }

        public string CurrentSelectionIen { get; set; }

        public NonVACareItemType ItemType { get; set; }

        public int UIItemType
        {
            get
            {
                return (int)this.ItemType;
            }
            set
            {
                this.ItemType = (NonVACareItemType)value;
            }
        }
    }
}
