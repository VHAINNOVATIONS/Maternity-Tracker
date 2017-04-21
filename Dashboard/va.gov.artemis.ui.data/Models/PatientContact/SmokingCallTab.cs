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
    public class SmokingCallTab: CallTabBase
    {
        private const string SmokingStatusKey = "SMOKE.SMOKINGSTATUS";
        private const string ContemplatingQuitKey = "SMOKE.CONTEPLATEQUIT";
        private const string RecentlyQuitKey = "SMOKE.RECENTLYQUIT";
        private const string RecentQuitResourceKey = "SMOKE.RECENTQUITRESORCE";
        private const string RecentQuitCongratKey = "SMOKE.RECENTQUITCONGRAT";
        private const string RecentQuitImportanceKey = "SMOKE.RECENTQUITIMPORTANCE";
        private const string RecentQuitEducateKey = "SMOKE.RECENTQUITEDUCATE";
        private const string CigarettesPerDayKey = "SMOKE.CIGARETTESPERDAY";

        public SmokingStatus SmokingStatus { get; set; }
        public Nullable<bool> ContemplatingQuitting { get; set; }
        public Nullable<bool> RecentlyQuit { get; set; }
        public bool RecentlyQuitResources { get; set; }
        public bool RecentlyQuitCongratulate { get; set; }
        public bool RecentlyQuitImportance { get; set; }
        public bool RecentlyQuitEducate { get; set; }

        public string CigarettesPerDay { get; set; }

        public override void AddDataElement(string key, string value)
        {
            bool val;
            key = key.ToUpper();
            SmokingStatus statusVal;

            switch (key)
            {
                case SmokingStatusKey:
                    if (Enum.TryParse<SmokingStatus>(value, out statusVal))
                        this.SmokingStatus = statusVal;
                    break; 
                case ContemplatingQuitKey:
                    if (!string.IsNullOrWhiteSpace(value))
                        if (bool.TryParse(value, out val))
                            this.ContemplatingQuitting = val;
                    break;
                case RecentlyQuitKey:
                    if (!string.IsNullOrWhiteSpace(value))
                        if (bool.TryParse(value, out val))
                            this.RecentlyQuit = val;
                    break;
                case RecentQuitResourceKey:
                    if (bool.TryParse(value, out val))
                        this.RecentlyQuitResources = val;
                    break;
                case RecentQuitCongratKey:
                    if (bool.TryParse(value, out val))
                        this.RecentlyQuitCongratulate = val;
                    break;
                case RecentQuitImportanceKey:
                    if (bool.TryParse(value, out val))
                        this.RecentlyQuitImportance = val;
                    break;
                case RecentQuitEducateKey:
                    if (bool.TryParse(value, out val))
                        this.RecentlyQuitEducate = val;
                    break;
                case CigarettesPerDayKey:
                    this.CigarettesPerDay = value;
                    break;
            }
           
        }

        public override Dictionary<string, string> GetTabDataElements()
        {
            Dictionary<string, string> returnDictionary = new Dictionary<string, string>();

            returnDictionary.Add(SmokingStatusKey, this.SmokingStatus.ToString());
            returnDictionary.Add(ContemplatingQuitKey, this.ContemplatingQuitting.ToString());
            returnDictionary.Add(RecentlyQuitKey, this.RecentlyQuit.ToString());
            returnDictionary.Add(RecentQuitResourceKey, this.RecentlyQuitResources.ToString());
            returnDictionary.Add(RecentQuitCongratKey, this.RecentlyQuitCongratulate.ToString());
            returnDictionary.Add(RecentQuitImportanceKey, this.RecentlyQuitImportance.ToString());
            returnDictionary.Add(RecentQuitEducateKey, this.RecentlyQuitEducate.ToString());
            returnDictionary.Add(CigarettesPerDayKey, this.CigarettesPerDay);

            return returnDictionary; 

        }

        public override string GetNoteText()
        {
            StringBuilder sb = new StringBuilder();

            if (this.AnyValues())
            {
                sb.AppendLine("Smoking");

                sb.AppendLine("");

                switch (this.SmokingStatus)
                {
                    case SmokingStatus.CurrentSmoker:
                        
                        sb.AppendLine("Current Smoker");

                        sb.AppendLine("Patient smokes " + CigarettesPerDay + " cigarettes per day");

                        if (this.ContemplatingQuitting.HasValue)
                            if (this.ContemplatingQuitting.Value)
                                sb.AppendLine("Patient is contemplating quitting smoking (Offered resources/referral)");
                            else
                                sb.AppendLine("Patient is not contemplating quitting smoking (Educated on importance for baby)");

                        sb.AppendLine();

                        break;

                    case SmokingStatus.PastSmoker:
                        
                        sb.AppendLine("Past Smoker");

                        if (this.RecentlyQuit.HasValue)
                            if (this.RecentlyQuit.Value)
                                sb.AppendLine("Patient recently quit smoking");

                        if (this.RecentlyQuitResources)
                            sb.AppendLine("Offered resources and referral");

                        if (this.RecentlyQuitCongratulate)
                            sb.AppendLine("Congratulated patient on quitting smoking");

                        if (this.RecentlyQuitImportance)
                            sb.AppendLine("Reinforced importance of quitting smoking");

                        if (this.RecentlyQuitEducate)
                            sb.AppendLine("Educated patient about second and third-hand smoke");

                        sb.AppendLine(); 

                            break;

                    case SmokingStatus.NeverASmoker:

                        sb.AppendLine("Never Smoked");
                        sb.AppendLine(); 

                        break;
                }
    
            }
            return sb.ToString();
        }

        protected override bool AnyValues()
        {
            bool returnVal = false;

            if (this.ContemplatingQuitting.HasValue ||
                this.RecentlyQuit.HasValue ||
                this.RecentlyQuitResources ||
                this.RecentlyQuitCongratulate ||
                this.RecentlyQuitImportance ||
                this.RecentlyQuitEducate)
                returnVal = true;

            return returnVal; 
        }

    }
}
