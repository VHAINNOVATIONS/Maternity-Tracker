using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.UI.Data.Models.PatientContact
{
    /// <summary>
    /// Creates a call tab model based on tab type
    /// </summary>
    public static class CallTabModelFactory
    {
        public static CallTabBase CreateNewCallTab(MccPatientCallTab tabType)
        {
            CallTabBase returnVal = null;

            switch (tabType)
            {
                case MccPatientCallTab.Introduction:
                    returnVal = new IntroductionCallTab(); 
                    break;

                case MccPatientCallTab.VACoverage:
                    returnVal = new CoverageCallTab(); 
                    break;

                case MccPatientCallTab.HealthProblems:
                    returnVal = new HealthCallTab(); 
                    break;

                case MccPatientCallTab.Smoking:
                    returnVal = new SmokingCallTab();
                    break;

                case MccPatientCallTab.Alcohol:
                    returnVal = new AlcoholCallTab();
                    break;

                case MccPatientCallTab.DepressionSuicide:
                    returnVal = new DepressionCallTab(); 
                    break;

                case MccPatientCallTab.InterpersonalViolence:
                    returnVal = new IpvCallTab(); 
                    break;

                case MccPatientCallTab.PregnancyRelatedClasses:
                    returnVal = new ClassesCallTab(); 
                    break;

                case MccPatientCallTab.BreastfeedingSupplies:
                    returnVal = new BreastfeedingCallTab();
                    break;

                case MccPatientCallTab.WomenInfantsChildren:
                    returnVal = new WicCallTab();
                    break;

                case MccPatientCallTab.FamilyPlanningContraception:
                    returnVal = new ContraceptionCallTab(); 
                    break;

                case MccPatientCallTab.PostpartumVisit:
                    returnVal = new PostpartumVisitCallTab(); 
                    break;

                case MccPatientCallTab.VAPrimaryCareFollowUp:
                    returnVal = new VaPcpCallTab(); 
                    break;

                case MccPatientCallTab.ContactInfoEndCall:
                    returnVal = new EndCallTab(); 
                    break;
            }

            return returnVal; 
        }
    }
}
