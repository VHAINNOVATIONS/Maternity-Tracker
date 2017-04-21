// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.UI.Data.Models.PatientList
{
    public class DashboardModel
    {
        public int TrackedPatients { get; set; }
        public int FlaggedPatients { get; set; }
        public int DueThisWeek { get; set; }
        public int HighRisk { get; set; }

        public int Tri1 { get; set; }
        public int Tri2 { get; set; }
        public int Tri3 { get; set; }
        public int TriUnknown {get; set;}
        //public int Postpartum { get; set; } 

        public int T4BEnrolled { get; set; }
        public int T4BNotInterested { get; set; }
        public int T4BUnknown { get; set; }

        public List<TrackedPatient> NextDueList { get; set; }

        public string OutcomesJson { get; set; }

        public string UpcomingPregnanciesJson { get; set; }

        public Outcomes Outcomes { get; set; }

        public DashboardModel()
        {
            this.Outcomes = new Outcomes(); 
        }
    }
}
