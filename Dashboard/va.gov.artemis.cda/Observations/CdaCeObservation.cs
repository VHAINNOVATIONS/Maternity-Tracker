using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.CDA.Common;

namespace VA.Gov.Artemis.CDA.Observations
{
    public class CdaCeObservation: CdaSimpleObservation
    {
        public CdaCode Value { get; set; }

        protected override ANY[] BaseValue
        {
            get { return new ANY[]{this.Value.ToCE()}; }
        }

        public override string DisplayValue
        {
            get { return this.Value.DisplayName; }
        }
    }
}
