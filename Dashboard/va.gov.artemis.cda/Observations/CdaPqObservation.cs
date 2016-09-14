using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.CDA.Common;

namespace VA.Gov.Artemis.CDA.Observations
{
    /// <summary>
    /// Simple observation where the value is a PQ (amt + unit)
    /// </summary>
    public class CdaPqObservation : CdaSimpleObservation
    {
        public string Value { get; set; }
        public string Unit { get; set; }

        public CdaPqObservation() : base()
        {
            
        }

        public CdaPqObservation(POCD_MT000040Observation pocdObservation) : base(pocdObservation)
        {
            if (pocdObservation != null)
                if (pocdObservation.value != null)
                {
                    ANY[] valArray = pocdObservation.value as ANY[];

                    if (valArray != null)
                        if (valArray.Length > 0)
                        {
                            PQ val = valArray[0] as PQ;

                            if (val != null)
                            {
                                this.Value = val.value;
                                this.Unit = val.unit;
                            }
                        }
                }
        }

        protected override ANY[] BaseValue
        {
            get { return new ANY[]{new PQ(){ value = this.Value, unit = this.Unit }}; }
        }

        public override string DisplayValue
        {
            get
            {
                string returnVal = "";

                if (!string.IsNullOrWhiteSpace(this.Value))
                    returnVal = string.Format("{0} {1}", this.Value, this.Unit);

                return returnVal;
            }
        }

        public string Amount
        {
            get
            {
                // *** Return an amount for use in table ***
                return string.Format("{0} {1}", this.Value, this.Unit);
            }
        } 
                
    }
}
