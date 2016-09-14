using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.UI.Data.Models.PatientContact
{
    public class IntroductionCallTab: CallTabBase
    {
        private const string IntroducedSelfKey = "INTRO.INTRODUCEDSELF";
        private const string PatientAvailableKey = "INTRO.PATIENTAVAILABLE"; 

        public bool IntroducedSelf { get; set; }
        public bool PatientAvailableToDiscuss { get; set; }

        public override void AddDataElement(string key, string value)
        {
            bool boolVal;
            
            key = key.ToUpper(); 
            
            switch (key)
            {
                case IntroducedSelfKey:
                    if (bool.TryParse(value, out boolVal))
                        this.IntroducedSelf = boolVal;
                    break; 
                case PatientAvailableKey:
                    if (bool.TryParse(value, out boolVal))
                        this.PatientAvailableToDiscuss = boolVal;
                    break; 
            }
        }

        public override Dictionary<string, string> GetTabDataElements()
        {
            Dictionary<string, string> returnDictionary = new Dictionary<string, string>();

            returnDictionary.Add(IntroducedSelfKey, this.IntroducedSelf.ToString());
            returnDictionary.Add(PatientAvailableKey, this.PatientAvailableToDiscuss.ToString());

            return returnDictionary; 
        }

        public override string GetNoteText()
        {
            StringBuilder sb = new StringBuilder();

            if (this.AnyValues())
            {
                sb.AppendLine("Introduction");

                sb.AppendLine();

                if (this.IntroducedSelf)
                    if (this.CallType == MccPatientCallType.PhoneCall_1)
                        sb.AppendLine("Introduced self and role");
                    else
                        sb.AppendLine("Re-introduced self and role");

                if (this.PatientAvailableToDiscuss)
                    sb.AppendLine("Ask if patient free to discuss private topics, and available to speak for 10-15 minutes");

                sb.AppendLine(); 
            }            

            return sb.ToString();
        }

        protected override bool AnyValues()
        {
            bool returnVal = false; 
    
            if ((this.IntroducedSelf) || (this.PatientAvailableToDiscuss))
                returnVal = true; 

            return returnVal; 
        }
    }
}
