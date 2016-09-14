using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Commands.Dsio.Checklist;
using VA.Gov.Artemis.UI.Data.Models.Common;
using VA.Gov.Artemis.UI.Data.Models.Patient;
using VA.Gov.Artemis.UI.Data.Models.Pregnancy;

namespace VA.Gov.Artemis.UI.Data.Models.Checklist
{
    public class PregnancyChecklistIndex: PatientRelatedModel
    {
        public PregnancyChecklistItemList Items { get; set; }

        public PregnancyDetails Pregnancy { get; set; }

        public bool NoPregnancies { get; set; }

        public Paging Paging { get; set; }

        public string SelectedItemIen { get; set; }
        //public DsioChecklistCompletionStatus SelectedItemNewStatus { get; set; }

        //public bool SelectedItemInProgress { get; set; }
        // *** This view shows items for a single pregnancy ***
        //public string PregnancyIen { get; set; }

        public PregnancyChecklistOperation PostOperation { get; set; }

        public PregnancyChecklistIndex()
        {
            this.Items = new PregnancyChecklistItemList();
            this.Paging = new Paging(); 
        }

        //public void AddPregnancyDates(DateTime edd, DateTime pregnancyEndDate)
        //{
        //    // *** Add dates to existing items ***

        //    // *** NOTE: MUST COME AFTER ITEMS EXIST ***

        //    if (this.Items != null)
        //        foreach (PregnancyChecklistItem item in this.Items)
        //        {
        //            item.PregnancyEndDate = pregnancyEndDate;
        //            item.Edd = edd;
        //        }
        //}




        public bool NoPregnancyDate { get; set; }
    }
}
