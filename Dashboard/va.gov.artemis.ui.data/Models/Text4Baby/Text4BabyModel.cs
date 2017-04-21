// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.UI.Data.Models.Patient;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.UI.Data.Models.Text4Baby
{
    public class Text4BabyModel: PatientRelatedModel
    {
        public Text4BabyEnrollment Enrollment { get; set; }

        public string EnrollmentWarning { get; set; }
        public string EnrollmentInfo { get; set; }



        public Dictionary<Text4BabyParticipantType, string> ParticipantTypes { get; set; }

        public Text4BabyModel()
        {
            this.Enrollment = new Text4BabyEnrollment();

            this.ParticipantTypes = new Dictionary<Text4BabyParticipantType, string>();

            foreach (Text4BabyParticipantType item in Enum.GetValues(typeof(Text4BabyParticipantType)))
            {
                // *** Only allow NewMom or Pregnant registrations for now ***

                switch (item)
                {
                    case Text4BabyParticipantType.NewMom:
                    case Text4BabyParticipantType.Pregnant:
                        this.ParticipantTypes.Add(item, this.Enrollment.Text4BabyParticipantTypeDescriptions[(int)item]);
                        break;
                }
            }
        }
    }
}
