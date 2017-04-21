// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.CDA.Common;

namespace VA.Gov.Artemis.CDA.DocumentationOf
{
    /// <summary>
    /// Simplifies the creation of the CDA documentation of section
    /// </summary>
    public class CdaDocumentationOf
    {        
        /// <summary>
        /// The effective time of the information in this document.  May be a single date for a single encounter.  May
        /// May also be a date range for a summary.
        /// </summary>
        public CdaEffectiveTime EffectiveTime { get; set; }

        /// <summary>
        /// List of performers which appear in this document 
        /// </summary>
        public CdaPerformerList PerformerList { get; set; }

        public CdaDocumentationOf()
        {
            this.PerformerList = new CdaPerformerList();
            this.EffectiveTime = new CdaEffectiveTime(); 
        }

        /// <summary>
        /// Creates a raw CDA class which can be serialized to CDA
        /// </summary>
        /// <returns>Raw Documentation Of Class</returns>
        public POCD_MT000040DocumentationOf ToPocdDocumentationOf()
        {
            // *** Converts to raw format ***

            POCD_MT000040DocumentationOf returnVal = new POCD_MT000040DocumentationOf();

            // *** Create the service event ***
            returnVal.serviceEvent = new POCD_MT000040ServiceEvent();

            //// *** Create effective Time ***
            returnVal.serviceEvent.effectiveTime = this.EffectiveTime.ToIvlTs(); 

            // *** Add performers ***
            returnVal.serviceEvent.performer = this.PerformerList.ToPocdPerformerArray(); 

            return returnVal; 
        }
    }
}
