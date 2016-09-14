using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.CDA.Observations
{
    public class CdaTextObservation: CdaSimpleObservation
    {
        public string Value { get; set; }

        protected override ANY[] BaseValue
        {
            get { return new ANY[] { new ST() { Text = new string[] { this.Value } } }; }
        }

        public CdaTextObservation(): base() {}

        public CdaTextObservation(POCD_MT000040Observation pocdObs): base(pocdObs)
        {
            if (pocdObs.value != null)
                if (pocdObs.value.Length > 0)
                    if (pocdObs.value[0] is ST)
                    {
                        ST st = pocdObs.value[0] as ST;
                        if (st.Text != null)
                            if (st.Text.Length > 0)
                                this.Value = st.Text[0];
                    } 
        }

        public override string DisplayValue
        {
            get { return this.Value; }
        }
    }
}
