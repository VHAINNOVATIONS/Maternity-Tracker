// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.UI.Data.Models.Pregnancy;

namespace VA.Gov.Artemis.UI.Data.Models.Outcomes
{
    public class OutcomeDetails
    {
        public PregnancyOutcomeType OutcomeType { get; set; }
        public string OutcomeDate { get; set; }

        public DeliveryDetails DeliveryDetails { get; set; }
        public EctopicOutcome EctopicDetails { get; set; }
        public PregnancyTerminationOutcome TerminationDetails { get; set; }
        public SpontaneousAbortionOutcome SpontaneousAbortionDetails { get; set; }
        public StillbirthOutcome StillbirthDetails { get; set; }

        public List<BabyDetails> Babies { get; set; }

        public OutcomeDetails()
        {
            this.Babies = new List<BabyDetails>();
            this.DeliveryDetails = new DeliveryDetails();
            this.EctopicDetails = new EctopicOutcome();
            this.TerminationDetails = new PregnancyTerminationOutcome();
            this.SpontaneousAbortionDetails = new SpontaneousAbortionOutcome();
            this.StillbirthDetails = new StillbirthOutcome(); 
        }
                
        public ObservationConstructable SelectedDetails
        {
            get
            {
                ObservationConstructable returnVal = null;

                switch (this.OutcomeType)
                {
                    case PregnancyOutcomeType.Ectopic:
                        returnVal = this.EctopicDetails;
                        break;

                    case PregnancyOutcomeType.FullTermDelivery:
                    case PregnancyOutcomeType.PretermDelivery:
                        returnVal = this.DeliveryDetails;
                        break;

                    case PregnancyOutcomeType.PregnancyTermination:
                        returnVal = this.TerminationDetails;
                        break;

                    case PregnancyOutcomeType.SpontaneousAbortion:
                        returnVal = this.SpontaneousAbortionDetails;
                        break;

                    case PregnancyOutcomeType.StillBirth:
                        returnVal = this.StillbirthDetails;
                        break;

                }

                return returnVal;
            }
        }

        public string PregnancyNotes
        {
            get
            {
                string returnVal = "";

                switch (this.OutcomeType)
                {
                    case PregnancyOutcomeType.FullTermDelivery:
                    case PregnancyOutcomeType.PretermDelivery:
                        returnVal = this.DeliveryDetails.Notes;
                        break; 
                    case PregnancyOutcomeType.Ectopic:
                        returnVal = this.EctopicDetails.Notes;
                        break; 
                    case PregnancyOutcomeType.PregnancyTermination:
                        returnVal = this.TerminationDetails.Notes;
                        break; 
                    case PregnancyOutcomeType.SpontaneousAbortion:
                        returnVal = this.SpontaneousAbortionDetails.Notes;
                        break; 
                    case PregnancyOutcomeType.StillBirth:
                        returnVal = this.StillbirthDetails.Notes;
                        break; 
                }

                return returnVal;
            }
        }

        public bool LiveDelivery
        {
            get
            {
                return ((this.OutcomeType == PregnancyOutcomeType.FullTermDelivery) || (this.OutcomeType == PregnancyOutcomeType.PretermDelivery));
            }
        }
    }
}
