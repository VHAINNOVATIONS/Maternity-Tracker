using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.UI.Data.Models.PatientContact
{
    public enum DrinksInterval { Day, Week, Month } 

    public class AlcoholCallTab : CallTabBase
    {
        public const string AlcoholUseKey = "ALCOHOL.USE";
        public const string EducateKey = "ALCOHOL.EDUCATE";
        public const string DrinksAlcoholKey = "ALCOHOL.DRINKS";
        public const string DrinksPerKey = "ALCOHOL.PER";
        public const string DrinksIntervalKey = "ALCOHOL.INTERVAL"; 

        public bool AlcoholUse { get; set; }
        public bool Educate { get; set; }
        public Nullable<bool> DrinksAlcohol { get; set; }
        public Nullable<int> DrinksPer { get; set; }
        public DrinksInterval DrinksInterval { get; set; }

        public override void AddDataElement(string key, string value)
        {
            bool boolVal;
            int intVal; 
            DrinksInterval drinksVal; 

            key = key.ToUpper();

            switch (key)
            {
                case AlcoholUseKey:
                    if (bool.TryParse(value, out boolVal))
                        this.AlcoholUse = boolVal; 
                    break; 
                case EducateKey:
                    if (bool.TryParse(value, out boolVal))
                        this.Educate = boolVal; 
                    break; 
                case DrinksAlcoholKey:
                    if (!string.IsNullOrWhiteSpace(value))
                        if (bool.TryParse(value, out boolVal))
                            this.DrinksAlcohol = boolVal;
                    break; 
                case DrinksPerKey:
                    if (int.TryParse(value, out intVal))
                        this.DrinksPer = intVal;
                    else
                        this.DrinksPer = 0; 

                    break; 
                case DrinksIntervalKey:
                    if (Enum.TryParse<DrinksInterval>(value, out drinksVal))
                        this.DrinksInterval = drinksVal;
                    break; 
            }
        }

        public override Dictionary<string, string> GetTabDataElements()
        {
            Dictionary<string, string> returnDictionary = new Dictionary<string, string>();

            returnDictionary.Add(AlcoholUseKey, this.AlcoholUse.ToString());
            returnDictionary.Add(EducateKey, this.Educate.ToString());
            returnDictionary.Add(DrinksAlcoholKey, this.DrinksAlcohol.ToString());
            returnDictionary.Add(DrinksPerKey, this.DrinksPer.ToString());
            returnDictionary.Add(DrinksIntervalKey, this.DrinksInterval.ToString());

            return returnDictionary; 
        }

        public override string GetNoteText()
        {
            StringBuilder sb = new StringBuilder();

            if (this.AnyValues())
            {
                sb.AppendLine("Alcohol");

                sb.AppendLine("");

                if (this.AlcoholUse)
                    sb.AppendLine("Verified alcohol use status");

                if (this.DrinksAlcohol.HasValue)
                    if (this.DrinksAlcohol.Value)
                        sb.AppendLine("Patient drinks alcohol");
                    else
                        sb.AppendLine("Patient does not drink alcohol");

                if (this.DrinksPer.HasValue)
                    sb.AppendLine(string.Format("Patient consumes {0} drinks per {1}", this.DrinksPer.Value, this.DrinksInterval));

                if (this.Educate)
                    sb.AppendLine("Educated patient on danger of alcohol to fetal development and that no amount of alcohol is save");

                sb.AppendLine();
            }
            
            return sb.ToString();            
        }

        protected override bool AnyValues()
        {
            bool returnVal = false;

            if (this.AlcoholUse ||
                this.Educate ||
                this.DrinksAlcohol.HasValue ||
                this.DrinksPer.HasValue)
                returnVal = true;

            return returnVal; 
        }
    }
}
