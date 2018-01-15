// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.UI.Data.Brokers;
using VA.Gov.Artemis.UI.Data.Brokers.Observations;

namespace VA.Gov.Artemis.UI.Data.Models.Pregnancy
{
    public class PregnancyHistory : ObservationCollection
    {
        private const string TotalPregnanciesCode = "11996-6";
        private const string TotalPregnanciesDescription = "Total Pregnancies (Including Current)";

        private const string TermBirthsCode = "11639-2";
        private const string TermBirthsDescription = "Term Births (Live & Stillborn)";

        private const string PretermBirthsCode = "11637-6";
        private const string PretermBirthsDescription = "Preterm Births (Live & Stillborn)";

        private const string SpontaneousAbortionsCode = "11614-5";
        private const string SpontaneousAbortionsDescription = "Spontaneous Abortions (Miscarriages)";

        private const string PregnancyTerminationsCode = "11613-7";
        private const string PregnancyTerminationsDescription = "Pregnancy Terminations";

        private const string EctopicCode = "33065-4";
        private const string EctopicDescription = "Ectopic Pregnancies";

        private const string LivingChildrenCode = "11638-4";
        private const string LivingChildrenDescription = "Living Children";

        private const string StillBirthsCode = "57062-2";
        private const string StillBirthsDescription = "Stillbirths";

        //private const string LiveBirthsCode = "11636-8";
        //private const string LiveBirthsDescription = "Total Live Births";


        public PregnancyHistory()
        {
            AddLoincObservation(TotalPregnanciesCode, TotalPregnanciesDescription);
            AddLoincObservation(TermBirthsCode, TermBirthsDescription);
            //AddLoincObservation(LiveBirthsCode, LiveBirthsDescription);
            AddLoincObservation(LivingChildrenCode, LivingChildrenDescription);
            AddLoincObservation(PretermBirthsCode, PretermBirthsDescription);
            AddLoincObservation(StillBirthsCode, StillBirthsDescription);
            AddLoincObservation(SpontaneousAbortionsCode, SpontaneousAbortionsDescription);
            AddLoincObservation(PregnancyTerminationsCode, PregnancyTerminationsDescription);
            AddLoincObservation(EctopicCode, EctopicDescription);
        }

        public override string Category
        {
            get { return "Pregnancy History"; }
        }

        private Nullable<int> GetInt(string code)
        {
            Nullable<int> returnval = null;

            string val = this.GetValue(code);

            int intVal = -1;
            if (int.TryParse(val, out intVal))
                returnval = intVal;

            return returnval;
        }

        private void SetInt(string code, Nullable<int> val)
        {
            if (val.HasValue)
                this.SetValue(code, val.Value.ToString());
            else
                this.SetValue(code, "");
        }

        [DisplayFormat(NullDisplayText = "Unknown")]
        [Display(Name = TotalPregnanciesDescription)]
        public Nullable<int> TotalPregnancies { get { return GetInt(TotalPregnanciesCode); } set { SetInt(TotalPregnanciesCode, value); } }

        [DisplayFormat(NullDisplayText = "Unknown")]
        [Display(Name = TermBirthsDescription)]
        public Nullable<int> TermBirths { get { return GetInt(TermBirthsCode); } set { SetInt(TermBirthsCode, value); } }

        //[DisplayFormat(NullDisplayText = "Unknown")]
        //[Display(Name = "Total Live Births")]
        //public Nullable<int> TotalLiveBirths { get { return GetInt(LiveBirthsCode); } set { SetInt(LiveBirthsCode, value); } }

        [DisplayFormat(NullDisplayText = "Unknown")]
        [Display(Name = LivingChildrenDescription)]
        public Nullable<int> LivingChildren { get { return GetInt(LivingChildrenCode); } set { SetInt(LivingChildrenCode, value); } }

        [DisplayFormat(NullDisplayText = "Unknown")]
        [Display(Name = PretermBirthsDescription)]
        public Nullable<int> PretermBirths { get { return GetInt(PretermBirthsCode); } set { SetInt(PretermBirthsCode, value); } }

        [DisplayFormat(NullDisplayText = "Unknown")]
        [Display(Name = StillBirthsDescription)]
        public Nullable<int> StillBirths { get { return GetInt(StillBirthsCode); } set { SetInt(StillBirthsCode, value); } }

        [DisplayFormat(NullDisplayText = "Unknown")]
        [Display(Name = SpontaneousAbortionsDescription)]
        public Nullable<int> SpontaneousAbortions { get { return GetInt(SpontaneousAbortionsCode); } set { SetInt(SpontaneousAbortionsCode, value); } }

        [DisplayFormat(NullDisplayText = "Unknown")]
        [Display(Name = PregnancyTerminationsDescription)]
        public Nullable<int> PregnancyTerminations { get { return GetInt(PregnancyTerminationsCode); } set { SetInt(PregnancyTerminationsCode, value); } }

        [DisplayFormat(NullDisplayText = "Unknown")]
        [Display(Name = EctopicDescription)]
        public Nullable<int> EctopicPregnancies { get { return GetInt(EctopicCode); } set { SetInt(EctopicCode, value); } }

        public string Gravidity
        {
            get
            {
                string returnVal = "";

                if (this.TotalPregnancies.HasValue)
                    returnVal = string.Format("G{0}", this.TotalPregnancies); 
                else
                    returnVal = "G?";

                return returnVal;
            }
        }

        public string Parity
        {
            get
            {
                string returnVal = "";

                string term = (this.TermBirths.HasValue) ? this.TermBirths.ToString() : "?";
                string preterm = (this.PretermBirths.HasValue) ? this.PretermBirths.ToString() : "?";

                //compute element 3 of the Gravida/Para Summary
                int element3 = 0;
                Boolean element3Known = false;
                if (this.SpontaneousAbortions.HasValue) {
                    element3 = this.SpontaneousAbortions.Value;
                    element3Known = true;
                }
                if (this.PregnancyTerminations.HasValue)
                {
                    element3 += this.PregnancyTerminations.Value;
                    element3Known = true;
                }
                if (this.EctopicPregnancies.HasValue)
                {
                    element3 += this.EctopicPregnancies.Value;
                    element3Known = true;
                }
                string element3ForDisplay = element3Known ? element3.ToString() : "?";

                string living = (this.LivingChildren.HasValue) ? this.LivingChildren.ToString() : "?";

                returnVal = string.Format("P{0}{1}{2}{3}", term, preterm, element3ForDisplay, living); 

                return returnVal;
            }
        }

        [Display(Name = "Summary")]
        [Editable(false)]
        public string GravidaPara
        {
            get
            {
                return string.Format("{0} {1}", this.Gravidity, this.Parity);
            }
        }

        public static bool IsPregnancyHistoryCode(string code)
        {
            bool returnVal = false;

            string[] codes = new string[] { TotalPregnanciesCode, TermBirthsCode, PretermBirthsCode, SpontaneousAbortionsCode, PregnancyTerminationsCode, EctopicCode, LivingChildrenCode, StillBirthsCode };

            if (codes.Contains(code))
                returnVal = true; 

            return returnVal;
        }
    }
}
