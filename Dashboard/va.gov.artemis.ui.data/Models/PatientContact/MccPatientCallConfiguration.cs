using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.UI.Data.Models.PatientContact
{
    public class MccPatientCallConfiguration
    {

        /// <summary>
        /// Returns a list of call templates
        /// </summary>
        public static List<MccPatientCallTemplate> CallList
        {
            get
            {
                List<MccPatientCallTemplate> returnList = new List<MccPatientCallTemplate>();

                // *** Go through all types of calls ***
                foreach (MccPatientCallType callType in Enum.GetValues(typeof(MccPatientCallType)))
                {
                    if (callType != MccPatientCallType.AdditionalCall)
                    {
                        // *** Create a template for each ***
                        MccPatientCallTemplate newTemplate = GetCallTemplate(callType);

                        // *** Add to return list ***
                        returnList.Add(newTemplate);
                    }
                }

                return returnList;
            }
        }

        /// <summary>
        /// Returns a single call template based on type
        /// </summary>
        /// <param name="callType"></param>
        /// <returns></returns>
        public static MccPatientCallTemplate GetCallTemplate(MccPatientCallType callType)
        {
            MccPatientCallTemplate returnTemplate = new MccPatientCallTemplate();

            // *** Set the type ***
            returnTemplate.CallType = callType;

            if (callType != MccPatientCallType.AdditionalCall)
            {
                // *** Get the list of tabs ***
                returnTemplate.TabList = GetTabs(callType);
            }

            return returnTemplate; 
        }

        public static MccPatientCallTemplate GetCallTemplate(string noteTitle)
        {
            MccPatientCallTemplate returnTemplate = new MccPatientCallTemplate(noteTitle);

            // *** Get the list of tabs ***
            returnTemplate.TabList = GetTabs(returnTemplate.CallType);

            return returnTemplate;
        }

        //  *** Gets a list of tabs for a specific call type ***
        private static List<MccPatientCallTab> GetTabs(MccPatientCallType callType)
        {
            List<MccPatientCallTab> returnList = new List<MccPatientCallTab>();

            if (callType != MccPatientCallType.AdditionalCall)
            {

                // *** All templates have intro/coverage ***
                returnList.Add(MccPatientCallTab.Introduction);
                returnList.Add(MccPatientCallTab.VACoverage);

                switch (callType)
                {
                    case MccPatientCallType.PhoneCall_1:

                        returnList.Add(MccPatientCallTab.HealthProblems);
                        returnList.Add(MccPatientCallTab.Smoking);
                        returnList.Add(MccPatientCallTab.Alcohol);
                        returnList.Add(MccPatientCallTab.DepressionSuicide);
                        returnList.Add(MccPatientCallTab.InterpersonalViolence);

                        break;

                    case MccPatientCallType.PhoneCall_2:

                        returnList.Add(MccPatientCallTab.HealthProblems);
                        returnList.Add(MccPatientCallTab.Smoking);

                        break;

                    case MccPatientCallType.PhoneCall_3:

                        returnList.Add(MccPatientCallTab.PregnancyRelatedClasses);
                        returnList.Add(MccPatientCallTab.HealthProblems);
                        returnList.Add(MccPatientCallTab.Smoking);
                        returnList.Add(MccPatientCallTab.DepressionSuicide);
                        returnList.Add(MccPatientCallTab.InterpersonalViolence);

                        break;

                    case MccPatientCallType.PhoneCall_4:

                        returnList.Add(MccPatientCallTab.PregnancyRelatedClasses);
                        returnList.Add(MccPatientCallTab.BreastfeedingSupplies);
                        returnList.Add(MccPatientCallTab.WomenInfantsChildren);
                        returnList.Add(MccPatientCallTab.FamilyPlanningContraception);
                        returnList.Add(MccPatientCallTab.HealthProblems);
                        returnList.Add(MccPatientCallTab.DepressionSuicide);

                        break;

                    case MccPatientCallType.PhoneCall_5:

                        returnList.Add(MccPatientCallTab.BreastfeedingSupplies);
                        returnList.Add(MccPatientCallTab.FamilyPlanningContraception);
                        returnList.Add(MccPatientCallTab.HealthProblems);
                        returnList.Add(MccPatientCallTab.DepressionSuicide);
                        returnList.Add(MccPatientCallTab.InterpersonalViolence);

                        break;

                    case MccPatientCallType.PhoneCall_6a:

                        returnList.Add(MccPatientCallTab.HealthProblems);
                        returnList.Add(MccPatientCallTab.DepressionSuicide);
                        returnList.Add(MccPatientCallTab.BreastfeedingSupplies);

                        break;

                    case MccPatientCallType.PhoneCall_6b:

                        returnList.Add(MccPatientCallTab.HealthProblems);
                        returnList.Add(MccPatientCallTab.DepressionSuicide);
                        returnList.Add(MccPatientCallTab.InterpersonalViolence);
                        returnList.Add(MccPatientCallTab.BreastfeedingSupplies);
                        returnList.Add(MccPatientCallTab.FamilyPlanningContraception);
                        returnList.Add(MccPatientCallTab.PostpartumVisit);

                        break;

                    case MccPatientCallType.PhoneCall_7:

                        returnList.Add(MccPatientCallTab.HealthProblems);
                        returnList.Add(MccPatientCallTab.BreastfeedingSupplies);
                        returnList.Add(MccPatientCallTab.DepressionSuicide);
                        returnList.Add(MccPatientCallTab.PostpartumVisit);
                        returnList.Add(MccPatientCallTab.VAPrimaryCareFollowUp);

                        break;
                }

                // *** All calls end with this tab ***
                returnList.Add(MccPatientCallTab.ContactInfoEndCall);
            }

            return returnList;
        }
    }
}
