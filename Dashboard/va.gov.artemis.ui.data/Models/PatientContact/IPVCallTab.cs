using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.UI.Data.Models.PatientContact
{
    public class IpvCallTab : CallTabBase
    {
        //private const string BeenHitTopicKey = "IPV.BEENHITTOPIC";
        private const string BeenHitKey = "IPV.BEENHIT";
        private const string BeenHitDetailsKey = "IPV.BEENHITDETAILS";
        private const string BeenHitFollowUpKey = "IPV.BEENHITFOLLOWUP";
        //private const string ForcedSexTopicKey = "IPV.FORCEDSEXTOPIC";
        private const string ForcedSexKey = "IPV.FORCEDSEX";
        private const string ForcedSexDetailsKey = "IPV.FORCEDSEXDETAILS";
        private const string ForceSexFollowUpActionsKey = "IPV.FORCEDSEXFOLLOWUP";
        private const string ReferToResourcesKey = "IPV.REFERTORESOURCES";

        //public bool BeenHitTopic { get; set; }
        public Nullable<bool> BeenHit { get; set; }
        public string BeenHitDetails { get; set; }
        public string BeenHitFollowUpActions { get; set; }
        //public bool ForcedSexTopic { get; set; }
        public Nullable<bool> ForcedSex { get; set; }
        public string ForcedSexDetails { get; set; }
        public string ForcedSexFollowUpActions { get; set; }
        public bool ReferToResources {get; set; }

        public override void AddDataElement(string key, string value)
        {
            bool val;
            key = key.ToUpper();
            switch (key)
            {
                //case BeenHitTopicKey:
                //    if (bool.TryParse(value, out val))
                //        this.BeenHitTopic = val;
                //    break;

                case BeenHitKey:
                    if (!string.IsNullOrWhiteSpace(value))
                        if (bool.TryParse(value, out val))
                            this.BeenHit = val;
                    break;
                case BeenHitDetailsKey:
                    this.BeenHitDetails = value;
                    break;
                case BeenHitFollowUpKey:
                    this.BeenHitFollowUpActions = value;
                    break;
                //case ForcedSexTopicKey:
                //    if (bool.TryParse(value, out val))
                //        this.ForcedSexTopic = val;
                //    break;
                case ForcedSexKey:
                    if (!string.IsNullOrWhiteSpace(value))
                        if (bool.TryParse(value, out val))
                            this.ForcedSex = val;
                    break;
                case ForcedSexDetailsKey:
                    this.ForcedSexDetails = value;
                    break;
                case ForceSexFollowUpActionsKey:
                    this.ForcedSexFollowUpActions = value;
                    break;
                case ReferToResourcesKey:
                    if (bool.TryParse(value, out val))
                        this.ReferToResources = val;
                    break;

            }
        }

        public override Dictionary<string, string> GetTabDataElements()
        {
            Dictionary<string, string> returnDictionary = new Dictionary<string, string>();

            //returnDictionary.Add(BeenHitTopicKey, this.BeenHitTopic.ToString());
            returnDictionary.Add(BeenHitKey, this.BeenHit.ToString());
            returnDictionary.Add(BeenHitDetailsKey, this.BeenHitDetails);
            returnDictionary.Add(BeenHitFollowUpKey, this.BeenHitFollowUpActions);
            //returnDictionary.Add(ForcedSexTopicKey, this.ForcedSexTopic.ToString());
            returnDictionary.Add(ForcedSexKey, this.ForcedSex.ToString());
            returnDictionary.Add(ForcedSexDetailsKey, this.ForcedSexDetails);
            returnDictionary.Add(ForceSexFollowUpActionsKey, this.ForcedSexFollowUpActions);
            returnDictionary.Add(ReferToResourcesKey, this.ReferToResources.ToString());
            return returnDictionary; 
        }

        public override string GetNoteText()
        {
            StringBuilder sb = new StringBuilder();

            if (this.AnyValues())
            {
                sb.AppendLine("Interpersonal Violence");

                sb.AppendLine("");

                if (this.BeenHit.HasValue)
                {
                    sb.AppendLine("Asked if patient has been hit, slapped, kicked, or otherwise physically hurt by someone");
                    if (this.BeenHit.Value)
                        sb.AppendLine("Patient has been physically hurt by someone");
                    else
                        sb.AppendLine("Patient has not been physically hurt by someone");
                }

                if (!string.IsNullOrWhiteSpace(BeenHitDetails))
                    sb.AppendLine(BeenHitDetails);

                if (!string.IsNullOrWhiteSpace(BeenHitFollowUpActions))
                    sb.AppendLine(BeenHitFollowUpActions);

                if (this.ForcedSex.HasValue)
                {
                    sb.AppendLine("Asked if patient has been forced to engage in sexual activities");
                    if (this.ForcedSex.Value)
                        sb.AppendLine("Patient has been forced to engage in sexual activities");
                    else
                        sb.AppendLine("Patient has not been forced to engage in sexual activities");
                }

                if (!string.IsNullOrWhiteSpace(ForcedSexDetails))
                    sb.AppendLine(ForcedSexDetails);

                if (!string.IsNullOrWhiteSpace(ForcedSexFollowUpActions))
                    sb.AppendLine(ForcedSexFollowUpActions);

                if (this.ReferToResources)
                    sb.AppendLine("Referred to resources as appropriate");

                sb.AppendLine();
            }

            return sb.ToString();         
        }

        protected override bool AnyValues()
        {
            bool returnVal = false;

            if (this.BeenHit.HasValue ||
                this.ForcedSex.HasValue ||
                this.ReferToResources)
                returnVal = true;

            return returnVal; 
        }
    }
}
