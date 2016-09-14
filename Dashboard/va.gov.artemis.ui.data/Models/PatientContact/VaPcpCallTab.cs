using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.UI.Data.Models.PatientContact
{
    public class VaPcpCallTab : CallTabBase
    {
        private const string EncourageApptKey = "VAPCP.ENCOURAGEAPPT";
        private const string WithinTwoMonthsKey = "VAPCP.WITHINTWOMONTHS";
        private const string ReasonsForNoPcpApptKey = "VAPCP.REASONSFORNOAPPT";
        private const string NotesKey = "VAPCP.NOTES";

        public bool EncourageAppt { get; set; }
        public Nullable<bool> WithinTwoMonths { get; set; }
        public bool ReasonsForNoPcpAppt { get; set; }

        public string Notes { get; set; }

        public override void AddDataElement(string key, string value)
        {
            bool val;
            key = key.ToUpper();
            switch (key)
            {
                case EncourageApptKey:
                    if (bool.TryParse(value, out val))
                        this.EncourageAppt = val;
                    break;
                case WithinTwoMonthsKey:
                if (!string.IsNullOrWhiteSpace(value))
                        if (bool.TryParse(value, out val))
                            this.WithinTwoMonths = val;
                    break; 
                case ReasonsForNoPcpApptKey:
                    if (bool.TryParse(value, out val))
                        this.ReasonsForNoPcpAppt = val;
                    break;
                case NotesKey:
                    this.Notes = value;
                    break;
            }
        }

        public override Dictionary<string, string> GetTabDataElements()
        {
            Dictionary<string, string> returnDictionary = new Dictionary<string, string>();

            returnDictionary.Add(EncourageApptKey, this.EncourageAppt.ToString());
            returnDictionary.Add(WithinTwoMonthsKey, this.WithinTwoMonths.ToString());
            returnDictionary.Add(ReasonsForNoPcpApptKey, this.ReasonsForNoPcpAppt.ToString());
            returnDictionary.Add(NotesKey, this.Notes);
            return returnDictionary; 
        }

        public override string GetNoteText()
        {
            StringBuilder sb = new StringBuilder();
            if (this.AnyValues())
            {
                sb.AppendLine("VA Primary Care Provider");

                sb.AppendLine("");

            if (this.EncourageAppt)
                sb.AppendLine("Encouraged and assisted patient to make appointment with PCP");
            if (this.WithinTwoMonths.HasValue)
                if (this.WithinTwoMonths.Value)
                    sb.AppendLine("Patient has medical/mental health conditions, within 2 months");
                else
                    sb.AppendLine("Patient does not have medical/mental health condition(s), within 3 months");
            if (this.ReasonsForNoPcpAppt)
                sb.AppendLine("Patient declined to make appointment with PCP, determined reasons");

            sb.AppendLine(Notes);

            sb.AppendLine();
            }

            return sb.ToString();    
        }

        protected override bool AnyValues()
        {
            
            bool returnVal = false;

            if (this.EncourageAppt ||
                this.WithinTwoMonths.HasValue ||
                this.ReasonsForNoPcpAppt)
                returnVal = true;

            return returnVal; 

        }

    }
}
