using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.UI.Data.Models.PatientContact
{
    public class PostpartumVisitCallTab : CallTabBase
    {
        private const string ScheduledPostpartumVisitKey = "POSTPARTUM.SCHEDULEDPOSTPARTUM";
        private const string OfferedVAPcpVisitKey = "POSTPARTUM.OFFEREDVAPCPVISIT";
        private const string ImpotanceOfPPVisitKey = "POSTPARTUM.IMPOTANCEOFPPVISIT";
        private const string NotesKey = "POSTPARTUM.NOTES";

        public bool ScheduledPostpartumVisit { get; set; }
        public bool OfferedVAPcpVisit { get; set; }
        public bool ImportanceOfPPVisit { get; set; }

        public string Notes { get; set; }

        public override void AddDataElement(string key, string value)
        {
            bool val;
            key = key.ToUpper();
            switch (key)
            {
                case ScheduledPostpartumVisitKey:
                    if (bool.TryParse(value, out val))
                        this.ScheduledPostpartumVisit = val;
                    break;
                case OfferedVAPcpVisitKey:
                    if (bool.TryParse(value, out val))
                        this.OfferedVAPcpVisit = val;
                    break;
                case ImpotanceOfPPVisitKey:
                    if (bool.TryParse(value, out val))
                        this.ImportanceOfPPVisit = val;
                    break;
                case NotesKey:
                    this.Notes = value;
                    break;

            }
        }

        public override Dictionary<string, string> GetTabDataElements()
        {
            Dictionary<string, string> returnDictionary = new Dictionary<string, string>();

            returnDictionary.Add(ScheduledPostpartumVisitKey, this.ScheduledPostpartumVisit.ToString());
            returnDictionary.Add(OfferedVAPcpVisitKey, this.OfferedVAPcpVisit.ToString());
            returnDictionary.Add(ImpotanceOfPPVisitKey, this.ImportanceOfPPVisit.ToString());
            returnDictionary.Add(NotesKey, this.Notes);
            return returnDictionary; 
        }

        public override string GetNoteText()
        {
            StringBuilder sb = new StringBuilder();

            if (this.AnyValues())
            {
                sb.AppendLine("Postpartum Visit Call");

                sb.AppendLine("");

                if (this.ScheduledPostpartumVisit)
                    sb.AppendLine("Assessed if patient has scheduled post-partum visit. If not, encouraged patient to do so.");

                if (this.OfferedVAPcpVisit)
                    sb.AppendLine("Offered VA PCP visit if patient not planning to return to OB for this visit");

                if (this.ImportanceOfPPVisit)
                    sb.AppendLine("Reviewed importance and purpose of post-partum visit");

                sb.AppendLine(Notes);

                sb.AppendLine();
            }

            return sb.ToString(); 
        }

        protected override bool AnyValues()
        {
            bool returnVal = false;

            if (this.ScheduledPostpartumVisit ||
                this.OfferedVAPcpVisit ||
                this.ImportanceOfPPVisit)
                returnVal = true;

            return returnVal;
        }

    }

}
