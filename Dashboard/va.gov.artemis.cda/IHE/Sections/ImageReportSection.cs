// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.CDA.Common;

namespace VA.Gov.Artemis.CDA.IHE.Sections
{
    public class ImageReportSection
    {
        public string ReportText { get; set; } 

        public POCD_MT000040Component2 ToPocdComponent()
        {
            POCD_MT000040Component2 returnVal = new POCD_MT000040Component2();

            POCD_MT000040NonXMLBody item = new POCD_MT000040NonXMLBody();

            item.text = new ED() { mediaType = "text/plain", representation = BinaryDataEncoding.B64 };

            if (!string.IsNullOrWhiteSpace(this.ReportText))
            {
                // NOTE: Spec indicates base 64; but encoding as such makes in unreadable
                //       For now keep it legible

                //var bytes = UTF8Encoding.UTF8.GetBytes(this.ReportText);

                //string b64 = Convert.ToBase64String(bytes);

                item.text.Text = new string[] { this.ReportText };
            }

            returnVal.Item = item; 

            return returnVal; 
        }
    }
}
