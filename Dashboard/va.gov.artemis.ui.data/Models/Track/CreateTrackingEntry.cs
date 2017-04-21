// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.UI.Data.Models.Outcomes;
using VA.Gov.Artemis.UI.Data.Models.Common;

namespace VA.Gov.Artemis.UI.Data.Models.Track
{
    public class CreateTrackingEntry
    {
        public string PageTitle { get; set; }

        public string PageMessage { get; set; }

        public TrackingEntry TrackingEntry { get; set; }

        public string ButtonText { get; set; }

        public List<string> Reasons { get; set; }

        public string OutcomeTableHeader { get; set; }

        public string OutcomeHeader { get; set; }

        public string DateHeader { get; set; }

        public string ReasonText { get; set; }

        public string ReasonDetail { get; set; }

        public BasePatient Patient { get; set; }

        public string ReturnUrl { get; set; }

        public OutcomeDetails Outcome { get; set; }

        public bool UpdatePregnancyStatus { get; set; }

        public CreateTrackingEntry()
        {
            this.Outcome = new OutcomeDetails(); 
        }

    }
}
