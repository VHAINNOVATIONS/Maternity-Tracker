using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Commands.Dsio.Checklist;

namespace VA.Gov.Artemis.UI.Data.Models.Checklist
{
    public class ChecklistItemAddEdit
    {
        public ChecklistItem Item { get; set; }

        public int WeeksGestation { get; set; }
        public int Trimester { get; set; }
        public int WeeksPostPartum { get; set; }

        public Dictionary<string, string> EducationItemSelection { get; set; }

        //public string EducationItemLink { get; set; }

        public ChecklistItemAddEdit()
        {
            this.Item = new ChecklistItem();
        }

        public void GetDueVals()
        {
            // *** Moves values from Item to UI-only val properties ***

            if (this.Item.DueCalculationType == DsioChecklistCalculationType.WeeksGa)
                this.WeeksGestation = this.Item.DueCalculationValue;
            else if (this.Item.DueCalculationType == DsioChecklistCalculationType.TrimesterGa)
                this.Trimester = this.Item.DueCalculationValue;
            else if (this.Item.DueCalculationType == DsioChecklistCalculationType.WeeksPostpartum)
                this.WeeksPostPartum = this.Item.DueCalculationValue;
        }

        public void SetDueVals()
        {
            // *** Moves values from UI-Only properties to Item ***
            if (this.Item.DueCalculationType == DsioChecklistCalculationType.WeeksGa)
                this.Item.DueCalculationValue = this.WeeksGestation;
            else if (this.Item.DueCalculationType == DsioChecklistCalculationType.TrimesterGa)
                this.Item.DueCalculationValue = this.Trimester;
            else if (this.Item.DueCalculationType == DsioChecklistCalculationType.WeeksPostpartum)
                this.Item.DueCalculationValue = this.WeeksPostPartum;

        }



    }
}
