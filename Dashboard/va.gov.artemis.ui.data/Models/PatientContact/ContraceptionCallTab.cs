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
    public class ContraceptionCallTab : CallTabBase
    {
        private const string DiscussedWithObKey = "CONTRA.DISCUSSEDWITHOB";
        private const string ClarifyMisconceptionsKey = "CONTRA.CLARIFYMISCONCEPTION";
        private const string NotesKey = "CONTRA.NOTES";
        private const string VerifyContraceptionKey = "CONTRA.VARIFYCONTRA";

        public bool DiscussedWithOb { get; set; }
        public bool ClarifyMisconceptions { get; set; }
        public string Notes { get; set; }

        public bool VerifyContraception { get; set; }

        public override void AddDataElement(string key, string value)
        {
            bool val;
            key = key.ToUpper();
            switch (key)
            {
                case DiscussedWithObKey:
                    if (bool.TryParse(value, out val))
                        this.DiscussedWithOb = val;
                    break;
                case ClarifyMisconceptionsKey:
                    if (bool.TryParse(value, out val))
                        this.ClarifyMisconceptions = val;
                    break;
                case NotesKey:
                    this.Notes = value;
                    break;
                case VerifyContraceptionKey:
                    if (bool.TryParse(value, out val))
                        this.VerifyContraception = val;
                    break;

            }
        }

        public override Dictionary<string, string> GetTabDataElements()
        {
            Dictionary<string, string> returnDictionary = new Dictionary<string, string>();

            returnDictionary.Add(DiscussedWithObKey, this.DiscussedWithOb.ToString());
            returnDictionary.Add(ClarifyMisconceptionsKey, this.ClarifyMisconceptions.ToString());
            returnDictionary.Add(NotesKey, this.Notes);
            returnDictionary.Add(VerifyContraceptionKey, this.VerifyContraception.ToString());
            return returnDictionary; 
            
        }

        public override string GetNoteText()
        {
            StringBuilder sb = new StringBuilder();

            if (this.AnyValues())
            {
                sb.AppendLine("Contraception");

                sb.AppendLine("");

                if (this.DiscussedWithOb)
                    sb.AppendLine("Assessed if patient has discussed family planning with OB. If not, encouraged patient to discuss with OB.");

                if (this.ClarifyMisconceptions)
                    sb.AppendLine("Clarified misconceptions: When resuming sexual relations after having a baby, you can get pregnant - No safe period - breastfeeding does not prevent pregnancy");

                if (this.VerifyContraception)
                    sb.AppendLine("If patient previously verbalized contraceptive plan, verify patient obtained contraception. Troubleshooted as needed");

                sb.AppendLine(Notes);

                sb.AppendLine();

            }
            return sb.ToString();
        }

        protected override bool AnyValues()
        {
            bool returnVal = false;

            if (this.DiscussedWithOb ||
                this.ClarifyMisconceptions ||
                this.VerifyContraception)
                returnVal = true;

            return returnVal;
        }

    }
}
