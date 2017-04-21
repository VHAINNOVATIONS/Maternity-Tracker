// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.UI.Data.Models.Common;

namespace VA.Gov.Artemis.UI.Data.Models.Checklist
{
    public class ChecklistIndex
    {
        public List<ChecklistItem> Items { get; set; }

        public Paging Paging { get; set; }

        public string SelectedItemIen { get; set; }

        public ChecklistIndexOperation PostOperation { get; set; }

        public ChecklistIndex()
        {
            this.Paging = new Paging();
            this.Items = new List<ChecklistItem>(); 
        }
    }
}
