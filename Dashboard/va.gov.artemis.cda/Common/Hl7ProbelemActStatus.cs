using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.CDA.Common
{
    /// <summary>
    /// Problem Act Status Value Set (Subset of Act Status)
    /// Code System = 2.16.840.1.113883.11.20.9.19
    /// </summary>
    public enum Hl7ProblemActStatus
    {
        unknown = Hl7ActStatus.unknown,
        active = Hl7ActStatus.active,
        suspended = Hl7ActStatus.suspended,
        aborted = Hl7ActStatus.aborted,
        completed = Hl7ActStatus.completed
    }
}
