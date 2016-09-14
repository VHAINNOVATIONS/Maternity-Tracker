using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.UI.Data.Models.PatientContact
{
    public class DepressionCallTab : CallTabBase
    {
        private const string LittleInterestKey = "DEPRESSION.LITTLEINTEREST";
        private const string FeelingDownKey = "DEPRESSION.FEELINGDOWN";
        private const string SuicideScreenKey = "DEPRESSION.SUICICESCREEN";

        public int LittleInterest { get; set; }
        public int FeelingDown { get; set; }
        
        public int PatientScore
        {
            get
            {
                int returnVal = -1;

                if (this.LittleInterest >= 0)
                    returnVal = this.LittleInterest;

                if (this.FeelingDown >= 0)
                    if (returnVal >= 0)
                        returnVal += this.FeelingDown;
                    else
                        returnVal = this.FeelingDown;

                return returnVal; 
            }
        }

        public bool SuicideScreen { get; set; }

        public DepressionCallTab()
        {
            this.LittleInterest = -1;
            this.FeelingDown = -1; 
        }

        public override void AddDataElement(string key, string value)
        {
            bool boolVal;
            int intVal;
            key = key.ToUpper();

            switch (key)
            {
                case LittleInterestKey:
                    if (!string.IsNullOrWhiteSpace(value))
                        if (int.TryParse(value, out intVal))
                            this.LittleInterest = intVal;
                    break;
                case FeelingDownKey:
                    if (!string.IsNullOrWhiteSpace(value))
                        if (int.TryParse(value, out intVal))
                            this.FeelingDown = intVal;
                    break;
                case SuicideScreenKey:
                    if (bool.TryParse(value, out boolVal))
                        this.SuicideScreen = boolVal;
                    break;
            }
        }

        public override Dictionary<string, string> GetTabDataElements()
        {
            Dictionary<string, string> returnDictionary = new Dictionary<string, string>();

            returnDictionary.Add(LittleInterestKey, this.LittleInterest.ToString());
            returnDictionary.Add(FeelingDownKey, this.FeelingDown.ToString());
            returnDictionary.Add(SuicideScreenKey, this.SuicideScreen.ToString());
      
            return returnDictionary; 
        }

        public override string GetNoteText()
        {
            StringBuilder sb = new StringBuilder();

            if (this.AnyValues())
            {
                sb.AppendLine("Depression");

                sb.AppendLine("");

                if (this.LittleInterest.Equals(0))
                    sb.AppendLine(string.Format("In the past 2 weeks, patient has been bothered by little interest or pleasure in doing things not at all (0)"));

                if (this.LittleInterest.Equals(1))
                    sb.AppendLine(string.Format("In the past 2 weeks, patient has been bothered by little interest or pleasure in doing things several days (1)"));

                if (this.LittleInterest.Equals(2))
                    sb.AppendLine(string.Format("In the past 2 weeks, patient has been bothered by little interest or pleasure in doing things more than half the days (2)"));

                if (this.LittleInterest.Equals(3))
                    sb.AppendLine(string.Format("In the past 2 weeks, patient has been bothered by little interest or pleasure in doing things nearly every day (3)"));

                if (this.FeelingDown.Equals(0))
                    sb.AppendLine(string.Format("In the past 2 weeks, patient has been bothered by feeling down, depressed or hopeless not at all (0)"));

                if (this.FeelingDown.Equals(1))
                    sb.AppendLine(string.Format("In the past 2 weeks, patient has been bothered by feeling down, depressed or hopeless several days (1)"));

                if (this.FeelingDown.Equals(2))
                    sb.AppendLine(string.Format("In the past 2 weeks, patient has been bothered by feeling down, depressed or hopeless more than half the days (2)"));

                if (this.FeelingDown.Equals(3))
                    sb.AppendLine(string.Format("In the past 2 weeks, patient has been bothered by feeling down, depressed or hopeless nearly every day (3)"));

                if (this.PatientScore >= 0)
                    sb.AppendLine(string.Format("Patient Score: {0}", this.PatientScore)); 

                if (this.SuicideScreen)
                    sb.AppendLine("Suicide screen and referral to resources is recommended");
                 
                sb.AppendLine();
            }

            return sb.ToString();     
        }

        protected override bool AnyValues()
        {
            bool returnVal = false;

            if (this.LittleInterest.Equals(0) ||
                this.LittleInterest.Equals(1) ||
                this.LittleInterest.Equals(2) ||
                this.LittleInterest.Equals(3) ||
                this.FeelingDown.Equals(0) ||
                this.FeelingDown.Equals(1) ||
                this.FeelingDown.Equals(2) ||
                this.FeelingDown.Equals(3) ||
                this.SuicideScreen)
                returnVal = true;

            return returnVal; 
        }


    }
}
