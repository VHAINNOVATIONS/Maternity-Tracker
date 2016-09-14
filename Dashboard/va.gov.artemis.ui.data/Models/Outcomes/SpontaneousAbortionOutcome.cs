using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.CDA.Common;
using VA.Gov.Artemis.Commands.Dsio.Observation;
using VA.Gov.Artemis.UI.Data.Models.Observations;
using VA.Gov.Artemis.UI.Data.Models.Patient;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.UI.Data.Models.Outcomes
{
    public class SpontaneousAbortionOutcome: ObservationConstructable
    {
        public string GestationalAgeWeeks { get; set; }
        public string GestationalAgeDays {get; set; }
        public int Trimester { get; set; }
        public bool WithoutSurgery { get; set; }
        public bool DilationCurettage { get; set; }
        public bool VacuumAspiration { get; set; }
        //public bool MedicationNeeded { get; set; }
        public string MedicationsNeeded { get; set; }
        public bool IncompetentCervix { get; set; }

        [IsNarrative]
        public string Notes { get; set; }

        public SpontaneousAbortionOutcome() : base() {}

        public SpontaneousAbortionOutcome(List<Observation> list) : base(list) {}

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

        public override string ObservationCategory { get { return "SpontaneousAbortionOutcome"; } }
    }
}
