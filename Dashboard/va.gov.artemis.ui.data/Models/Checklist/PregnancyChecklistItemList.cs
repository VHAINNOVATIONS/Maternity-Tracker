// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.UI.Data.Models.Checklist
{
    public class PregnancyChecklistItemList : List<PregnancyChecklistItem>
    {
        public void AddPregnancyDates(DateTime edd, DateTime pregnancyEndDate)
        {
            // *** Add dates to existing items ***

            // *** NOTE: MUST COME AFTER ITEMS EXIST ***

            foreach (PregnancyChecklistItem item in this)
            {
                item.PregnancyEndDate = pregnancyEndDate;
                item.Edd = edd;
            }
        }

        public void SortByDueDate()
        {
            this.Sort(delegate(PregnancyChecklistItem x, PregnancyChecklistItem y)
            {
                return x.DueDate.CompareTo(y.DueDate);
            });
        }
    }
}
