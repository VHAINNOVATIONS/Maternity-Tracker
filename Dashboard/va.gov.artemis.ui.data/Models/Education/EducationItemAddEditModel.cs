// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.CDA.Common;
using VA.Gov.Artemis.UI.Data.Models.Common;

namespace VA.Gov.Artemis.UI.Data.Models.Education
{
    public class EducationItemAddEditModel
    {
        public EducationItem Item { get; set; }

        public Dictionary<EducationItemType, string> ItemTypeSelection { get; set; }

        public List<string> CategorySelection {get; set;}

        [Display(Name = "Category")]
        public string SelectedCategory { get; set; }

        public EducationItemAddEditModel()
        {
            this.Item = new EducationItem(); 
        }

    
    }
}
