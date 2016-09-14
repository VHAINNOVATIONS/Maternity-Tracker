using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.UI.Data.Models.Common;

namespace VA.Gov.Artemis.UI.Data.Models.FlaggedPatients
{
    public class FlaggedPatient: BasePatient
    {
        public string FlagSummary { get; set; }

        [Display(Name = "Flagged On")]
        public DateTime FlaggedOn { get; set; }
    }

}
