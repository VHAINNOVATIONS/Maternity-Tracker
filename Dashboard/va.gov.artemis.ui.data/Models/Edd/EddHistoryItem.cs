using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.UI.Data.Models.Edd
{
    public class EddHistoryItem
    {
        public string Ien { get; set; }

        [Display(Name="Entered")]
        public string EnteredOn { get; set; }

        [Display(Name="User")]
        public string EnteredBy { get; set; }

        public string Criteria { get; set; }
        //public string Value { get; set; }
        public string EventDate { get; set; }
        public string GestationalAge { get; set; }
        public string Edd { get; set; }

        [Display(Name="Is Final")]
        public bool IsFinal { get; set; }

        public bool Imported { get; set; }
    }
}
