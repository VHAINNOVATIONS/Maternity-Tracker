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
    public class EndCallTab : CallTabBase
    {
        private const string CheckedForQuestionsKey = "END.ANYQUESTIONS";
        private const string PatientQuestionsKey = "END.PATQUESTIONS";
        private const string SummarizedCallKey = "END.SUMMARIZECALL";
        private const string CallSummaryKey = "END.SUMMARY";
        private const string NextCallKey = "END.NEXTCALL";
        private const string ContactInfoKey = "END.CONTACTINFO";
        private const string CallObKey = "END.CALLOB";
        private const string FinalCommentsKey = "END.COMMENT";
       
        public bool CheckedForQuestions { get; set; }
        public string PatientQuestions { get; set; }
        public bool SummarizedCall { get; set; }
        public string CallSummary { get; set; }

        // TODO: Pre-populate and make read-only?  Or write to next call?
        public string NextCall { get; set; }

        public string FinalComments { get; set; }
        public bool ContactInfo { get; set; }
        public bool CallOb { get; set; }
        

        public override void AddDataElement(string key, string value)
        {
            bool val;
            key = key.ToUpper();
            switch (key)
            {
                case CheckedForQuestionsKey:
                    if (bool.TryParse(value, out val))
                        this.CheckedForQuestions = val;
                    break;

                case PatientQuestionsKey:
                    this.PatientQuestions = value;
                    break; 
                    
                case SummarizedCallKey:
                    if (bool.TryParse(value, out val))
                        this.SummarizedCall = val;
                    break;

                case CallSummaryKey:
                    this.CallSummary = value;
                    break; 

                case FinalCommentsKey:
                    this.FinalComments = value;
                    break;

                case ContactInfoKey:
                    if (bool.TryParse(value, out val))
                        this.ContactInfo = val;
                    break;

                case CallObKey:
                    if (bool.TryParse(value, out val))
                        this.CallOb = val;
                    break;
                    
                case NextCallKey:
                    this.NextCall = value;
                    break; 
               
            }
        }

        public override Dictionary<string, string> GetTabDataElements()
        {
            Dictionary<string, string> returnDictionary = new Dictionary<string, string>();

            returnDictionary.Add(CheckedForQuestionsKey, this.CheckedForQuestions.ToString());
            returnDictionary.Add(PatientQuestionsKey, this.PatientQuestions);
            returnDictionary.Add(SummarizedCallKey, this.SummarizedCall.ToString());
            returnDictionary.Add(CallSummaryKey, this.CallSummary);
            returnDictionary.Add(FinalCommentsKey, this.FinalComments);
            returnDictionary.Add(NextCallKey, this.NextCall); 
            returnDictionary.Add(ContactInfoKey, this.ContactInfo.ToString());
            returnDictionary.Add(CallObKey, this.CallOb.ToString());
                        
            return returnDictionary; 
        }

        public override string GetNoteText()
        {
            StringBuilder sb = new StringBuilder();

            if (this.AnyValues())
            {
                sb.AppendLine("Contact Information & End Call");

                sb.AppendLine("");

                if (this.CheckedForQuestions)
                    sb.AppendLine("Asked Patient if they had any questions");

                if (!string.IsNullOrWhiteSpace(this.PatientQuestions))
                    sb.AppendLine(this.PatientQuestions); 

                if (this.SummarizedCall)
                    sb.AppendLine("Summarized call, explained next steps and timing of next call");

                if (!string.IsNullOrWhiteSpace(this.CallSummary))
                    sb.AppendLine(this.CallSummary);

                if (!string.IsNullOrWhiteSpace(this.NextCall))
                    sb.AppendLine(string.Format("Next Call: {0}", this.NextCall)); 

                if (this.ContactInfo)
                    sb.AppendLine("Provided MCC & VA PCP contact information, encouraged to call for VA-related questions");

                if (this.CallOb)
                    sb.AppendLine("Reiterated to call OB with pregnancy-related questions, go to ER for emergencies");

                if (!string.IsNullOrWhiteSpace(this.FinalComments))
                    sb.AppendLine(FinalComments);

                sb.AppendLine();
            }

            return sb.ToString();
        }

        protected override bool AnyValues()
        {
            bool returnVal = false;

            if (this.CheckedForQuestions ||                
                this.SummarizedCall ||
                this.ContactInfo ||
                this.CallOb)
                returnVal = true;
            else if (!string.IsNullOrWhiteSpace(this.PatientQuestions))
                returnVal = true;
            else if (!string.IsNullOrWhiteSpace(this.CallSummary))
                returnVal = true;
            else if (!string.IsNullOrWhiteSpace(this.FinalComments))
                returnVal = true; 

            return returnVal;
        }

    }
}
