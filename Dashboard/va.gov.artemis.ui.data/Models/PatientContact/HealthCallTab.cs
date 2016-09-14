using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.UI.Data.Models.PatientContact
{
    public class HealthCallTab: CallTabBase
    {
        private const string UpdateHealthProblemsKey = "HEALTH.UPDATEHEALTHPROB";
        private const string NewMedicationsKey = "HEALTH.MEDICATIONS";
        private const string NoNewHealthProblemsKey = "HEALTH.NONEWHEALTHPROB";
        private const string NoNewMedicationsKey = "HEALTH.NONEWMEDS";
        private const string HealthProblemsKey = "HEALTH.HEALTHPROBLEMS";
        private const string MedicationsKey = "HEALTH.MEDCATIONS";
        private const string HypertensionKey = "HEALTH.HYPERTENSION";
        private const string DiabetesKey = "HEALTH.DIABETES";


        public bool UpdateHealthProblems { get; set; }
        public bool NewMedications { get; set; }

        public bool NoNewHealthProblems { get; set; }
        public bool NoNewMedications { get; set; }

        public List<string> HealthProblems { get; set; }
        public List<string> Medications { get; set; }

        public Nullable<bool> Hypertension { get; set; }
        public Nullable<bool> Diabetes { get; set; }

        public HealthCallTab()
        {
            this.HealthProblems = new List<string>();
            this.Medications = new List<string>(); 

            for (int i = 0; i < 5; i++)
            {
                this.HealthProblems.Add("");
                this.Medications.Add("");
            }
        }

        public override void AddDataElement(string key, string value)
        {
            bool val;
            key = key.ToUpper();
            switch (key)
            {
                    
                case UpdateHealthProblemsKey:
                    if (bool.TryParse(value, out val))
                        this.UpdateHealthProblems = val;
                    break;
                case NewMedicationsKey:
                    if (bool.TryParse(value, out val))
                        this.NewMedications = val;
                    break;
                case NoNewHealthProblemsKey:
                    if (bool.TryParse(value, out val))
                        this.NoNewHealthProblems = val;
                    break;
                case NoNewMedicationsKey:
                    if (bool.TryParse(value, out val))
                        this.NoNewMedications = val;
                    break;
                case HypertensionKey:
                    if (!string.IsNullOrWhiteSpace(value))
                        if (bool.TryParse(value, out val))
                            this.Hypertension = val;
                    break;
                case DiabetesKey:
                    if (!string.IsNullOrWhiteSpace(value))
                        if (bool.TryParse(value, out val))
                            this.Diabetes = val;
                    break; 
            }
            if (key.StartsWith(HealthProblemsKey))
            {
                string idx = key.Substring(HealthProblemsKey.Length);

                int idxVal = -1;
                int.TryParse(idx, out idxVal);

                if (idxVal > -1)
                    if (idxVal < this.HealthProblems.Count)
                        this.HealthProblems[idxVal] = value; 
                    else 
                        this.HealthProblems.Add(value);
            }

            if (key.StartsWith(MedicationsKey))
            {
                string idx = key.Substring(MedicationsKey.Length);
                int idxVal = -1;
                int.TryParse(idx, out idxVal);

                if (idxVal > -1)
                    if (idxVal < this.Medications.Count)
                        this.Medications[idxVal] = value;
                    else
                        this.Medications.Add(value);
            }
        }

        public override Dictionary<string, string> GetTabDataElements()
        {
            Dictionary<string, string> returnDictionary = new Dictionary<string, string>();

            returnDictionary.Add(UpdateHealthProblemsKey, this.UpdateHealthProblems.ToString());
            returnDictionary.Add(NewMedicationsKey, this.NewMedications.ToString());
            returnDictionary.Add(NoNewHealthProblemsKey, this.NoNewHealthProblems.ToString());
            returnDictionary.Add(NoNewMedicationsKey, this.NoNewMedications.ToString());
            returnDictionary.Add(HypertensionKey, this.Hypertension.ToString());
            returnDictionary.Add(DiabetesKey, this.Diabetes.ToString());
            
            for (int i = 0; i < this.HealthProblems.Count; i++)
                returnDictionary.Add(string.Format("{0}{1}", HealthProblemsKey, i), this.HealthProblems[i]);
            
            for (int i = 0; i < this.Medications.Count; i++)
                returnDictionary.Add(string.Format("{0}{1}", MedicationsKey, i), this.Medications[i]);

            return returnDictionary;
        }

        public override string GetNoteText()
        {
            StringBuilder sb = new StringBuilder();

            if (this.AnyValues())
            {
                sb.AppendLine("Health Problems");

                sb.AppendLine("");                

                if (this.UpdateHealthProblems)
                    sb.AppendLine("Updated health problems and advised patient to tell OB about all problems");

                if (this.NoNewHealthProblems)
                    sb.AppendLine("Patient has no new health problems");

                sb.AppendLine("Current Health Problems");

                foreach (string problem in this.HealthProblems)
                    if (!string.IsNullOrWhiteSpace(problem))
                        sb.AppendLine(problem);

                if (this.NewMedications)
                    sb.AppendLine("Asked patient about new medications");

                if (this.NoNewMedications)
                    sb.AppendLine("Patient has no new medications");

                sb.AppendLine("Current Medications");

                foreach (string medication in this.Medications)
                    if (!string.IsNullOrWhiteSpace(medication))
                        sb.AppendLine(medication);
                
                if (this.Hypertension.HasValue)
                    if (this.Hypertension.Value)
                        sb.AppendLine("Patient has pregnancy-related hypertension");
                    else
                        sb.AppendLine("Patient does not have pregnancy-related hypertension");

                if (this.Diabetes.HasValue)
                    if (this.Diabetes.Value)
                        sb.AppendLine("Patient has pregnancy-related diabetes");
                    else
                        sb.AppendLine("Patient does not have pregnancy-related diabetes");

                sb.AppendLine();
            }

            return sb.ToString();

        }

        protected override bool AnyValues()
        {
            bool returnVal = false;

            if (this.UpdateHealthProblems ||
                this.NewMedications ||
                this.NoNewHealthProblems ||
                this.NoNewMedications ||
                this.Hypertension.HasValue ||
                this.Diabetes.HasValue)
                returnVal = true;
            
            if (!returnVal)
                foreach (string problem in this.HealthProblems)
                    if (!string.IsNullOrWhiteSpace(problem))
                        returnVal = true;

            if (!returnVal)
                foreach (string med in this.Medications)
                    if (!string.IsNullOrWhiteSpace(med))
                        returnVal = true; 

            return returnVal; 
        }

    }
}
