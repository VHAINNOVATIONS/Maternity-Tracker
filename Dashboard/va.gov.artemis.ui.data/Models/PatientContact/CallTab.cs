using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.UI.Data.Models.PatientContact
{
    public class CallTab
    {
        public MccPatientCallTab TabType { get; set; }
        public string ViewName { get; set; }
        public string ShortName { get; set; }
        public string FullName { get; set; }

        public CallTab(MccPatientCallTab tabType)
        {
            this.TabType = tabType;

            this.ViewName = MccPatientCallTabViewName[(int)tabType];
            this.ShortName = MccPatientCallTabShortName[(int)tabType];
            this.FullName = MccPatientCallTabName[(int)tabType];
        }

        internal static string[] MccPatientCallTabName = new string[]
        {
            "Introduction", 
            "VA Coverage of Maternity/Newborn Care", 
            "Health Problems", 
            "Smoking", 
            "Alcohol", 
            "Depression & Suicide", 
            "Interpersonal Violence", 
            "Pregnancy-Related Classes", 
            "Breastfeeding Supplies", 
            "WIC (Nutrition Program for Women, Infants, and Children)", 
            "Family Planning (Contraception)", 
            "Post-Partum Visit", 
            "VA Primary Care Provider Follow-up Care", 
            "Contact Information & End Call"
        };

        // *** Used as view names ***
        internal static string[] MccPatientCallTabViewName = new string[]
        {
            "Intro", 
            "Coverage", 
            "Health", 
            "Smoking", 
            "Alcohol", 
            "Depression", 
            "IPV", 
            "Classes", 
            "Breastfeeding", 
            "WIC", 
            "Contraception", 
            "PostpartumVisit", 
            "VAPCP", 
            "End"
        };

        internal static string[] MccPatientCallTabShortName = new string[]
        {
            "Intro", 
            "Coverage", 
            "Health", 
            "Smoking", 
            "Alcohol", 
            "Depression", 
            "IPV", 
            "Classes", 
            "Breastfeeding", 
            "WIC", 
            "Contraception", 
            "PP Visit", 
            "VA Primary", 
            "End"
        };
    }
}
