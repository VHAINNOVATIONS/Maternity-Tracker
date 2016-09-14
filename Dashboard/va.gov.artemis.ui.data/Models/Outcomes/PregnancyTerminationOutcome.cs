using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Commands.Dsio.Observation;
using VA.Gov.Artemis.UI.Data.Models.Observations;

namespace VA.Gov.Artemis.UI.Data.Models.Outcomes
{
    public class PregnancyTerminationOutcome : ObservationConstructable
    {
        //public string GestationalAgeWeeks { get; set; }
        //public string GestationalAgeDays { get; set; }
        public int Trimester { get; set; }
        public bool FetalAbnormalities { get; set; }
        public string Indication { get; set; }

        [IsNarrative]
        public string Notes { get; set; }

        public PregnancyTerminationOutcome() : base() { }

        public PregnancyTerminationOutcome(List<Observation> list) : base(list) { }

        protected override void Construct(List<Observation> list)
        {
            this.PopulateProperties(this, list);

            //if (!string.IsNullOrWhiteSpace(this.Notes))
            //    if (this.Notes.Contains("|"))
            //        this.Notes = this.Notes.Replace("|", Environment.NewLine);
        }

        public override List<Observation> GetObservations(string patientDfn, string pregnancyIen, string babyIen)
        {
            //if (!string.IsNullOrWhiteSpace(this.Notes))
            //    if (this.Notes.Contains(Environment.NewLine))
            //        this.Notes = this.Notes.Replace(Environment.NewLine, "|");

            return base.GetObservations(this, patientDfn, pregnancyIen, babyIen);
        }

        public override string ObservationCategory { get { return "PregnancyTerminationOutcome"; } }
    }
}
