// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.UI.Data.Models.PatientContact
{
    public class BreastfeedingCallTab : CallTabBase
    {
        private const string PatientInterestKey = "BREAST.PATIENTINTEREST";
        private const string OverviewBenefitsKey = "BREAST.OVERVIEWBENEFITS";
        private const string SupportServicesKey = "BREAST.SUPPORTSERVICE";
        private const string SuppliesKey = "BREAST.SUPPLIES";

        private const string PatientInterestInBrestfeedKey = "BREAST.INTERESTINBREASTFEED";
        private const string PatientInterestInMoreInfoKey = "BREAST.INTERESTINMOREINFO";
        private const string PatientInterestInSuppliesKey = "BREAST.INTERESTINSUPPLIES";

        private const string PatientIntendsToBreastfeedKey = "BREAST.INTENDSTOBREASTFEED";

        private const string OfferToOrderSuppliesKey = "BREAST.ORDERSUPPLIES";
        private const string BreastPumpOrderedKey = "BREAST.BREASTPUMPORDERED";
        private const string BreastPumpRecievedKey = "BREAST.PUMPRECIEVED";
        private const string ReOfferBreastPumpKey = "BREAST.REOFFERBREASTPUMP";
        private const string AdviseToCallKey = "BREAST.ADVISETOCALL";
        private const string SuppliesToOrderKey = "BREAST.SUPPLIESTOORDER";
        private const string BreastfeedingCommentKey = "BREAST.COMMENT";
        private const string ConfirmReceiptKey = "BREAST.COMFIRMRECEIPT";
        private const string BreastfeedingAssessmentKey = "BREAST.ASSESSMENT";
        private const string BreastfeedingLactationKey = "BREAST.LACTATION";
        private const string SuppliesUseKey = "BREAST.SUPPLIESUSE";


        public bool PatientInterest { get; set; }
        public bool OverviewBenefits { get; set; }
        public bool SupportServices { get; set; }
        public bool Supplies { get; set; }

        public YesNoMaybe PatientInterestedInBreastfeeding { get; set; }
        public YesNoMaybe PatientInterestedInMoreInformation { get; set; }
        public YesNoMaybe PatientInterestedInSupplies { get; set; }

        public bool PatientIntendsToBreastfeed
        {
            get
            {
                bool returnVal = false;

                //this.PatientInterestedInBreastfeeding != YesNoMaybe.No;
                if ((this.PatientInterestedInBreastfeeding == YesNoMaybe.Yes) || (this.PatientInterestedInBreastfeeding == YesNoMaybe.Maybe))
                    returnVal = true; 

                return returnVal; 
            }
            set
            {
                this.PatientInterestedInBreastfeeding = (value == true) ? YesNoMaybe.Yes : YesNoMaybe.No; 
            }
        }

        public bool OfferToOrderSupplies { get; set; }

        public Nullable<bool> BreastPumpOrdered { get; set; }
        public Nullable<bool> BreastPumpReceived { get; set; }
        public bool ReOfferBreastPump { get; set; }
        public bool AdviseToCall { get; set; }

        public string SuppliesToOrder { get; set; }

        public string BreastfeedingComment { get; set; }

        public bool ConfirmReceipt { get; set; }

        public bool BreastfeedingAssessment { get; set; }

        public YesNoMaybe LactationDifficulty { get; set; }

        public bool SuppliesUse { get; set; }

        public override void AddDataElement(string key, string value)
        {
            bool val;
            key = key.ToUpper();
            YesNoMaybe YesNoMabyVal;

            switch (key)
            {
                case PatientInterestKey:
                    if (bool.TryParse(value, out val))
                        this.PatientInterest = val;
                    break;
                case OverviewBenefitsKey:
                    if (bool.TryParse(value, out val))
                        this.OverviewBenefits = val;
                    break;
                case SupportServicesKey:
                    if (bool.TryParse(value, out val))
                        this.SupportServices = val;
                    break;
                case SuppliesKey:
                    if (bool.TryParse(value, out val))
                        this.Supplies = val;
                    break;
                case PatientInterestInBrestfeedKey:
                    if (YesNoMaybe.TryParse<YesNoMaybe>(value, out YesNoMabyVal))
                        this.PatientInterestedInBreastfeeding = YesNoMabyVal;
                    break;
                case PatientInterestInMoreInfoKey:
                    if (YesNoMaybe.TryParse<YesNoMaybe>(value, out YesNoMabyVal))
                        this.PatientInterestedInMoreInformation = YesNoMabyVal;
                    break;
                case PatientInterestInSuppliesKey:
                    if (YesNoMaybe.TryParse<YesNoMaybe>(value, out YesNoMabyVal))
                        this.PatientInterestedInSupplies = YesNoMabyVal;
                    break;
                //case PatientIntendsToBreastfeedKey:
                //    if (bool.TryParse(value, out val))
                //        this.PatientIntendsToBreastfeed = val;
                    //break;
                case OfferToOrderSuppliesKey:
                    if (bool.TryParse(value, out val))
                        this.OfferToOrderSupplies = val;
                    break;
                case BreastPumpOrderedKey:
                    if (!string.IsNullOrWhiteSpace(value))
                        if (bool.TryParse(value, out val))
                            this.BreastPumpOrdered = val;
                    break;
                case BreastPumpRecievedKey:
                    if (!string.IsNullOrWhiteSpace(value))
                        if (bool.TryParse(value, out val))
                            this.BreastPumpReceived = val;
                    break;
                case ReOfferBreastPumpKey:
                    if (bool.TryParse(value, out val))
                        this.ReOfferBreastPump = val;
                    break;
                case AdviseToCallKey:
                    if (bool.TryParse(value, out val))
                        this.AdviseToCall = val;
                    break;
                case SuppliesToOrderKey:
                    this.SuppliesToOrder = value;
                    break;
                case BreastfeedingCommentKey:
                    this.BreastfeedingComment = value;
                    break;
                case ConfirmReceiptKey:
                    if (bool.TryParse(value, out val))
                        this.ConfirmReceipt = val;
                    break;
                case BreastfeedingAssessmentKey:
                    if (bool.TryParse(value, out val))
                        this.BreastfeedingAssessment = val;
                    break;
                case BreastfeedingLactationKey:
                    if (YesNoMaybe.TryParse<YesNoMaybe>(value, out YesNoMabyVal))
                        this.LactationDifficulty = YesNoMabyVal;
                    break;
                case SuppliesUseKey:
                    if (bool.TryParse(value, out val))
                        this.SuppliesUse = val;
                    break;
            }
        }

        public override Dictionary<string, string> GetTabDataElements()
        {
            Dictionary<string, string> returnDictionary = new Dictionary<string, string>();

            returnDictionary.Add(PatientInterestKey, this.PatientInterest.ToString());
            returnDictionary.Add(OverviewBenefitsKey, this.OverviewBenefits.ToString());
            returnDictionary.Add(SupportServicesKey, this.SupportServices.ToString());
            returnDictionary.Add(SuppliesKey, this.Supplies.ToString());
            returnDictionary.Add(PatientInterestInBrestfeedKey, this.PatientInterestedInBreastfeeding.ToString());
            returnDictionary.Add(PatientInterestInMoreInfoKey, this.PatientInterestedInMoreInformation.ToString());
            returnDictionary.Add(PatientInterestInSuppliesKey, this.PatientInterestedInSupplies.ToString());
            //returnDictionary.Add(PatientIntendsToBreastfeedKey, this.PatientIntendsToBreastfeed.ToString());
            returnDictionary.Add(OfferToOrderSuppliesKey, this.OfferToOrderSupplies.ToString());
            returnDictionary.Add(BreastPumpOrderedKey, this.BreastPumpOrdered.ToString());
            returnDictionary.Add(BreastPumpRecievedKey, this.BreastPumpReceived.ToString());
            returnDictionary.Add(ReOfferBreastPumpKey, this.ReOfferBreastPump.ToString());
            returnDictionary.Add(AdviseToCallKey, this.AdviseToCall.ToString());
            returnDictionary.Add(SuppliesToOrderKey, this.SuppliesToOrder);
            returnDictionary.Add(BreastfeedingCommentKey, this.BreastfeedingComment);
            returnDictionary.Add(ConfirmReceiptKey, this.ConfirmReceipt.ToString());
            returnDictionary.Add(BreastfeedingAssessmentKey, this.BreastfeedingAssessment.ToString());
            returnDictionary.Add(BreastfeedingLactationKey, this.LactationDifficulty.ToString());
            returnDictionary.Add(SuppliesUseKey, this.SuppliesUse.ToString());
            
            return returnDictionary; 
        }

        public override string GetNoteText()
        {
            StringBuilder sb = new StringBuilder();

            if (this.AnyValues())
            {
                sb.AppendLine("Breastfeeding");

                sb.AppendLine("");

                if (this.PatientInterest)
                    sb.AppendLine("Assessed patient interest in breastfeeding, clarified misinformation, Patient interested breastfeeding: " + this.PatientInterestedInBreastfeeding);

                if (this.OverviewBenefits)
                    sb.AppendLine("Provided an overview of breastfeeding and benefits, Patient interested in more information: " + this.PatientInterestedInMoreInformation);

                if (this.SupportServices)
                    sb.AppendLine("Informed patient regarding lactation support services provided by hospitals");

                if (this.Supplies)
                    sb.AppendLine("Provided information on nursing supplies and breast pump, ordered breast pump as needed, Patient is interested in supplies: " + this.PatientInterestedInSupplies);

                if (!string.IsNullOrWhiteSpace(this.SuppliesToOrder))
                {
                    sb.AppendLine("Patient is interested in the following supplies:");
                    sb.AppendLine(SuppliesToOrder);
                }
                if (this.PatientIntendsToBreastfeed)
                    sb.AppendLine("Patient intends to breastfeed");

                if (this.OfferToOrderSupplies)
                    sb.AppendLine("Offered to order nursing supplies (nipple cream, pads, nursing bra)");

                if (this.BreastPumpOrdered.HasValue)
                    if (this.BreastPumpOrdered.Value)
                        sb.AppendLine("Breast pump ordered");
                    else
                        sb.AppendLine("Breast pump not ordered");

                if (this.BreastPumpReceived.HasValue)
                    if (this.BreastPumpReceived.Value)
                        sb.AppendLine("Breast pump received");
                    else
                        sb.AppendLine("Breast pump not received");

                if (this.ReOfferBreastPump)
                    sb.AppendLine("Re-offered to order breast pump");

                if (this.AdviseToCall)
                    sb.AppendLine("Advised patient to call if ordered items not received in expected time period");

                if (!string.IsNullOrWhiteSpace(this.BreastfeedingComment))
                    sb.AppendLine(BreastfeedingComment);

                if (this.ConfirmReceipt)
                    sb.AppendLine("Confirmed breastfeeding supplies and/or pump were delivered. (If not, followed-up )");

                if (this.BreastfeedingAssessment)
                    sb.AppendLine("Assessed for difficulties with breastfeeding, answered questions, referred to pediatrician as needed");

                if (this.LactationDifficulty == YesNoMaybe.Yes)
                {
                    sb.AppendLine("Patient is having difficulty lactating");
                }
                if (this.LactationDifficulty == YesNoMaybe.No)
                {
                    sb.AppendLine("Patient is not having difficulty lactating");
                }
                if (this.LactationDifficulty == YesNoMaybe.Maybe)
                {
                    sb.AppendLine("Patient might be having difficulty lactating");
                }

                if (this.SuppliesUse)
                    sb.AppendLine("If received breast pump/supplies, assessed for difficulties with use, answered questions, and provided support");

                sb.AppendLine();
            }
            return sb.ToString();
        }

        protected override bool AnyValues()
        {
            bool returnVal = false;

            if (this.PatientInterest ||
                this.OverviewBenefits ||
                this.SupportServices ||
                this.Supplies ||
                this.PatientIntendsToBreastfeed ||
                this.OfferToOrderSupplies ||
                this.BreastPumpOrdered.HasValue ||
                this.BreastPumpReceived.HasValue ||
                this.ReOfferBreastPump ||
                this.AdviseToCall ||
                this.ConfirmReceipt ||
                this.BreastfeedingAssessment ||
                this.LactationDifficulty != YesNoMaybe.Unknown ||
                this.SuppliesUse)
                returnVal = true;

            return returnVal;
        }


    }
}
