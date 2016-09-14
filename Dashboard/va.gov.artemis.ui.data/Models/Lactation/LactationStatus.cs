using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.UI.Data.Models.Patient;

namespace VA.Gov.Artemis.UI.Data.Models.Lactation
{
    public class LactationStatus: PatientRelatedModel
    {
        public string CurrentStatus { get; set; }

        public Nullable<bool> NewStatus { get; set; }

        public Dictionary<string, Nullable<bool>> NewStatusSelection { get; set; }

        public LactationStatus()
        {
            this.NewStatusSelection = new Dictionary<string, bool?>();

            this.NewStatusSelection.Add("(Select)", null);
            this.NewStatusSelection.Add("Lactating", true);
            this.NewStatusSelection.Add("Not Lactating", false); 
        }

    }
}
