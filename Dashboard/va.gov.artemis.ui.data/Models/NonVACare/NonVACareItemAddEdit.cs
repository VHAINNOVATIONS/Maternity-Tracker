// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.UI.Data.Models.NonVACare
{
    public class NonVACareItemAddEdit
    {
        public NonVACareItem Item { get; set; }

        public string CurrentPatientDfn { get; set; }

        public string CurrentPregnancyIen { get; set; }

        public string CurrentItemType { get; set; }

        public string ReturnUrl { get; set; }

        public NonVACareItemAddEdit()
        {
            this.Item = new NonVACareItem(); 
        }
    }
}
