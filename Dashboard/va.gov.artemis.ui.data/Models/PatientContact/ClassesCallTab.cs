using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.UI.Data.Models.PatientContact
{
    public class ClassesCallTab : CallTabBase
    {
        private const string RefreshBenefitsKey = "CLASSES.REFRESHBENEFITS";
        private const string RefresherKey = "CLASSES.REFRESHER";
        private const string AssessNotInterestedKey = "CLASSES.ASSESSNOTINTERESTED";
        private const string DescribePaymentKey = "CLASSES.DESCRIBEPAYMENT";
        private const string NotesKey = "CLASSES.NOTES";
        
        public bool RefreshBenefits { get; set; }
        public bool Refresher { get; set; }
        public bool AssessNotInterested { get; set; }
        public bool DescribePayment { get; set; }
        public string Notes { get; set; }

        public override void AddDataElement(string key, string value)
        {
            bool val;
            key = key.ToUpper();
            switch (key)
            {
                case RefreshBenefitsKey:
                    if (bool.TryParse(value, out val))
                        this.RefreshBenefits = val;
                    break;
                case RefresherKey:
                    if (bool.TryParse(value, out val))
                        this.Refresher = val;
                    break;
                case AssessNotInterestedKey:
                    if (bool.TryParse(value, out val))
                        this.AssessNotInterested = val;
                    break;
                case DescribePaymentKey:
                    if (bool.TryParse(value, out val))
                        this.DescribePayment = val;
                    break;
                case NotesKey:
                    this.Notes = value;
                    break;

            }
                
        }

        public override Dictionary<string, string> GetTabDataElements()
        {
            Dictionary<string, string> returnDictionary = new Dictionary<string, string>();

            returnDictionary.Add(RefreshBenefitsKey, this.RefreshBenefits.ToString());
            returnDictionary.Add(RefresherKey, this.Refresher.ToString());
            returnDictionary.Add(AssessNotInterestedKey, this.AssessNotInterested.ToString());
            returnDictionary.Add(DescribePaymentKey, this.DescribePayment.ToString());
            returnDictionary.Add(NotesKey, this.Notes);
            return returnDictionary; 
        }

        public override string GetNoteText()
        {
            StringBuilder sb = new StringBuilder();

            if (this.AnyValues())
            {
                sb.AppendLine("Classes");

                sb.AppendLine("");

                if (this.RefreshBenefits)
                    sb.AppendLine("Refreshed patient memory about childbirth preparation class benefits and assessed interest");

                if (this.Refresher)
                    sb.AppendLine("Mentioned a refresher course in childbirth preparation");

                if (this.AssessNotInterested)
                    sb.AppendLine("Patient was not interested, assessed reasons and answered questions as appropriate");

                if (this.DescribePayment)
                    sb.AppendLine("Described the mechanism for VA payment for these classes");

                sb.AppendLine(Notes);

                sb.AppendLine();
            }

            return sb.ToString();
        }


        protected override bool AnyValues()
        {

            bool returnVal = false;

            if (this.RefreshBenefits || 
                this.Refresher || 
                this.AssessNotInterested || 
                this.DescribePayment)
                returnVal = true;

            return returnVal;
        }
    }

}
