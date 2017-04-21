// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.CDA
{
    public class CdaDeviceAuthor : CdaAuthor
    {
        public CdaAssignedAuthoringDevice AssignedAuthoringDevice { get; set; }

        public CdaDeviceAuthor()
        {
            this.AssignedAuthoringDevice = new CdaAssignedAuthoringDevice();
        }

        public override POCD_MT000040Author ToPocdAuthor()
        {
            POCD_MT000040Author returnVal = new POCD_MT000040Author();

            POCD_MT000040AuthoringDevice authoringDevice = new POCD_MT000040AuthoringDevice();
            authoringDevice.manufacturerModelName = new SC() { Text = new string[] { this.AssignedAuthoringDevice.ManufacturerModelName } };
            authoringDevice.softwareName = new SC() { Text = new string[] { this.AssignedAuthoringDevice.SoftwareName } };

            returnVal.assignedAuthor = new POCD_MT000040AssignedAuthor(); 

            returnVal.assignedAuthor.Item = authoringDevice;

            returnVal.time = new TS() { value = DateTime.Now.ToString(RawCdaDocument.CdaDateFormat) };

            return returnVal; 
        }

        public bool IsEmpty
        {
            get
            {
                bool returnVal = false;

                if (string.IsNullOrWhiteSpace(this.AssignedAuthoringDevice.ManufacturerModelName))
                    if (string.IsNullOrWhiteSpace(this.AssignedAuthoringDevice.SoftwareName))
                        returnVal = true; 

                return returnVal;
            }
        }
    }
}
