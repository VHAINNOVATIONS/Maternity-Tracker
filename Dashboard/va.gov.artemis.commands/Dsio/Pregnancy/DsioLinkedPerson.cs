using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Commands.Dsio.Base;

namespace VA.Gov.Artemis.Commands.Dsio.Pregnancy
{
    /// <summary>
    /// A class containing information about a person linked to a patient 
    /// </summary>
    public class DsioLinkedPerson: DsioPerson
    {
        public string PatientDfn { get; set; }
        public string DOB { get; set; }
        public string YearsSchool { get; set; }

    }
}
