using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.CDA.Common
{
    /// <summary>
    /// Act Status
    /// Code System = 2.16.840.1.113883.5.14
    /// </summary>
    public enum Hl7ActStatus
    {
        unknown, normal, aborted, active, cancelled, completed, held, newStatus, suspended
    }
}
