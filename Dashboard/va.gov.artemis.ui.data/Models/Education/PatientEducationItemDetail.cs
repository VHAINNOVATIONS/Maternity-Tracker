using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.UI.Data.Models.Patient;

namespace VA.Gov.Artemis.UI.Data.Models.Education
{
    public class PatientEducationItemDetail: PatientRelatedModel
    {
        public PatientEducationItem Item { get; set; }
    }
}
