using System;
using System.Xml.Serialization;
using VA.Gov.Artemis.Core;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.Commands.Vpr.Data
{
    [Serializable]
    public class VprDateTime
    {
        [XmlAttribute("value")]
        public string Value { get; set; }

        public DateTime ToDateTime()
        {
            DateTime returnVal = DateTime.MinValue;

            returnVal = Util.GetDateTime(this.Value);

            if (returnVal == DateTime.MinValue)
                ErrorLogger.Log(string.Format("Unable to parse FileMan Date '{0}'", this.Value));

            return returnVal; 
        }
    }
}
