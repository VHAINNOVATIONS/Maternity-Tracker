using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.UI.Data.Models.Common;

namespace VA.Gov.Artemis.UI.Data.Models.Education
{
    public class EducationItemList
    {
        public List<EducationItem> EducationItems { get; set; }

        public Paging Paging { get; set; }

        public string SelectedItemIen { get; set; }

        public EducationItemSort Sort { get; set; }

        public EducationItemList()
        {
            this.Paging = new Paging();
            this.EducationItems = new List<EducationItem>(); 
        }
    }
}
