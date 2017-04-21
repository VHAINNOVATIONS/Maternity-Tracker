// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.UI.Data.Models.Pregnancy;

namespace VA.Gov.Artemis.UI.Data.Models.PatientList
{
    public class Outcomes
    {
        public List<PregnancyOutcome> PregnancyOutcomes { get; set; }

        public bool AllDates { get; set; }
        public string FromDate { get; set; }
        public string ToDate { get; set; }

        // Unknown, FullTermDelivery, PretermDelivery, SpontaneousAbortion, StillBirth, PregnancyTermination, Ectopic
        public int Unknown
        {
            get
            {
                return this.PregnancyOutcomes.Count(po => po.OutcomeType == PregnancyOutcomeType.Unknown);                
            }
        }

        public int FullTermDelivery
        {
            get
            {
                return this.PregnancyOutcomes.Count(po => po.OutcomeType == PregnancyOutcomeType.FullTermDelivery);
            }
        }

        public int PretermDelivery
        {
            get
            {
                return this.PregnancyOutcomes.Count(po => po.OutcomeType == PregnancyOutcomeType.PretermDelivery);
            }
        }

        public int SpontaneousAbortion
        {
            get
            {
                return this.PregnancyOutcomes.Count(po => po.OutcomeType == PregnancyOutcomeType.SpontaneousAbortion);
            }
        }

        public int StillBirth
        {
            get
            {
                return this.PregnancyOutcomes.Count(po => po.OutcomeType == PregnancyOutcomeType.StillBirth);
            }
        }

        public int PregnancyTermination
        {
            get
            {
                return this.PregnancyOutcomes.Count(po => po.OutcomeType == PregnancyOutcomeType.PregnancyTermination);
            }
        }

        public int Ectopic
        {
            get
            {
                return this.PregnancyOutcomes.Count(po => po.OutcomeType == PregnancyOutcomeType.Ectopic);
            }
        }

        public Outcomes()
        {
            this.PregnancyOutcomes = new List<PregnancyOutcome>();
            this.AllDates = true; 
        }

        public string DatesLabel
        {
            get
            {
                string returnVal = "";

                if (this.AllDates)
                    returnVal = "All Dates";
                else
                    returnVal = string.Format("{0} - {1}", this.FromDate, this.ToDate); 

                return returnVal;
            }
        }
    }
}
