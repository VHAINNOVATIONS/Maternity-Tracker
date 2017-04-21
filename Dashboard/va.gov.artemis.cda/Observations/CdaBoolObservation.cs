// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.CDA.Common;

namespace VA.Gov.Artemis.CDA.Observations
{
    /// <summary>
    /// Simple observation where the value is a boolean 
    /// </summary>
    public class CdaBoolObservation : CdaSimpleObservation
    {
        public bool Value { get; set; }

        protected override ANY[] BaseValue
        {
            get { return new ANY[]{new BL(){ value = this.Value, valueSpecified=true}}; }
        }

        public override string DisplayValue
        {
            get { return this.Value.ToString(); }
        }
    }
}
