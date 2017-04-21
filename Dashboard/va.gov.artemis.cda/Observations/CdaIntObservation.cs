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
    /// Simple observation where the value is an integer
    /// </summary>
    public class CdaIntObservation : CdaSimpleObservation
    {
        public int Value { get; set; }

        public CdaIntObservation() {}

        public CdaIntObservation(POCD_MT000040Observation pocdObs) : base(pocdObs)
        {
            if (pocdObs.value != null)
                if (pocdObs.value.Length > 0)
                    if (pocdObs.value[0] is INT)
                    {
                        INT temp = (INT)pocdObs.value[0];
                        int val = -1;
                        if (int.TryParse(temp.value, out val))
                            this.Value = val;
                    }
        }

        protected override ANY[] BaseValue
        {
            get { return new ANY[] { new INT { value = this.Value.ToString() }}; }
        }

        public override string DisplayValue
        {
            get { return this.Value.ToString(); }
        }
    }
}
