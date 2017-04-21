// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.Commands.Dsio.Tracking
{
    public class DsioFlaggedPatient: DsioPatient
    {
        // *** Dictionary of tracking items that can be accessed by key ***
        public Dictionary<string, DsioTrackingItem> TrackingItems { get; set; }

        public DsioFlaggedPatient()
        {
            // *** Creat empty ***
            this.TrackingItems = new Dictionary<string, DsioTrackingItem>();
        }

        public string FlagSummary
        {
            get
            {
                string returnValue = "";

                // *** Check that there are items to work with 
                if (TrackingItems != null)
                    if (TrackingItems.Count > 0)
                    {
                        // *** Set return value to first item in list ***
                        DsioTrackingItem item = this.TrackingItems.First().Value;
                        returnValue = string.Format("{0}: {1}", item.Source, item.Reason);
                    }

                return returnValue; 
            }
        }

        public DateTime FlaggedOn
        {
            get
            {
                // *** Gets the most recent date that a flag was added to tracking history for a patient ***

                CultureInfo enUS = new CultureInfo("en-US");

                DateTime returnVal = DateTime.MinValue;

                // *** Check if we have items to work with ***
                if (TrackingItems != null)
                    foreach (DsioTrackingItem item in this.TrackingItems.Values)
                    {
                        // *** Parse the date and set to return if newer ***
                        DateTime tempDateTime; 
                        if (DateTime.TryParseExact(item.TrackingItemDateTime,"M/d/yyyy@HH:mm:ss",enUS, DateTimeStyles.None, out tempDateTime))
                            if (tempDateTime > returnVal)
                                returnVal = tempDateTime;
                    }

                return returnVal; 
            }
        }
    }
}
