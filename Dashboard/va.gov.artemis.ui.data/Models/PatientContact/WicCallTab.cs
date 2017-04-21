// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.UI.Data.Models.PatientContact
{
    public class WicCallTab : CallTabBase
    {
        private const string InformAboutWicKey = "WIC.INFORMABOUTWIC";
        private const string DiscusswithObKey = "WIC.DISCUSSWITHOB";
        private const string LactationSupportKey = "WIC.LACTATIONSUPPORT";
        private const string WicContactInfoKey = "WIC.WICCONTACKTINFO";

        public bool InformAboutWic { get; set; }
        public bool DiscussWithOb { get; set; }
        public bool LactationSupport { get; set; }
        public bool WicContactInfo { get; set; }

        public override void AddDataElement(string key, string value)
        {
            bool val;
            key = key.ToUpper();
            switch (key)
            {
                case InformAboutWicKey:
                    if (bool.TryParse(value, out val))
                        this.InformAboutWic = val;
                    break;
                case DiscusswithObKey:
                    if (bool.TryParse(value, out val))
                        this.DiscussWithOb = val;
                    break;
                case LactationSupportKey:
                    if (bool.TryParse(value, out val))
                        this.LactationSupport = val;
                    break;
                case WicContactInfoKey:
                    if (bool.TryParse(value, out val))
                        this.WicContactInfo = val;
                    break;
            }
            
        }

        public override Dictionary<string, string> GetTabDataElements()
        {
            Dictionary<string, string> returnDictionary = new Dictionary<string, string>();

            returnDictionary.Add(InformAboutWicKey, this.InformAboutWic.ToString());
            returnDictionary.Add(DiscusswithObKey, this.DiscussWithOb.ToString());
            returnDictionary.Add(LactationSupportKey, this.LactationSupport.ToString());
            returnDictionary.Add(WicContactInfoKey, this.WicContactInfo.ToString());
            return returnDictionary; 
            
        }

        public override string GetNoteText()
        {
            StringBuilder sb = new StringBuilder();

            if (this.AnyValues())
            {
                sb.AppendLine("Women, Infants, and Children (WIC)");

                sb.AppendLine("");

                if (this.InformAboutWic)
                    sb.AppendLine("Informed patient that WIC provides low-income families with healthy food, breast feeding support, and connections to community resources");
                if (this.DiscussWithOb)
                    sb.AppendLine("Encouraged patient to discuss with OB if would like more information");
                if (this.LactationSupport)
                    sb.AppendLine("Informed patient regarding lactation support services provided by hospitals");
                if (this.WicContactInfo)
                    sb.AppendLine("Provided WIC contact information: 1-888-WIC-WORKS (1-888-942-9675) or website");
                sb.AppendLine();
            }

            return sb.ToString(); 
        }

        protected override bool AnyValues()
        {
            bool returnVal = false;

            if (this.InformAboutWic || 
                this.DiscussWithOb || 
                this.LactationSupport || 
                this.WicContactInfo)
                returnVal = true;

            return returnVal;

        }

    }
}

