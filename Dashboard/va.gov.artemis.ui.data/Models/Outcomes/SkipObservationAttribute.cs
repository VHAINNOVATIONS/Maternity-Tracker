using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.UI.Data.Models.Outcomes
{
    [System.AttributeUsage(AttributeTargets.Property, AllowMultiple=false)]
    public class SkipObservationAttribute : System.Attribute 
    {
    }
}
