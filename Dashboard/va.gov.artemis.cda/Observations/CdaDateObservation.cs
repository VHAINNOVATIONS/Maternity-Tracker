using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.CDA.Common;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.CDA.Observations
{
    /// <summary>
    /// Simple observation where the value is a date 
    /// </summary>
    public class CdaDateObservation: CdaSimpleObservation 
    {
        public DateTime Value { get; set; }

        public CdaDateObservation() : base()
        {
        }

        public CdaDateObservation(POCD_MT000040Observation pocdObs) : base(pocdObs)
        {
            if (pocdObs.value != null) 
                if (pocdObs.value.Length > 0) 
                    if (pocdObs.value[0] is TS) 
                    {
                        TS temp = (TS) pocdObs.value[0];
                        DateTime val = VistaDates.ParseDateString(temp.value, RawCdaDocument.CdaDateFormat);
                        if (val != DateTime.MinValue)
                            this.Value = val;
                    }                        
        }

        protected override ANY[] BaseValue
        {
            get
            {
                return new ANY[]{new TS() { value = this.Value.ToString(RawCdaDocument.CdaDateFormat) }};
            }
        }

        public override string DisplayValue
        {
            get { return this.Value.ToString(VistaDates.UserDateFormat); }
        }
    }
}
