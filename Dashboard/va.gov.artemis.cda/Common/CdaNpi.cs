using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.CDA.Common
{
    /// <summary>
    /// Object to hold an NPI (National Provider Identification) 
    /// </summary>
    public class CdaNpi
    {
        /// <summary>
        /// The actual NPI
        /// </summary>
        public string Value { get; set; }

        /// <summary>
        /// Converts the NPI to a raw II array from the CDA schema 
        /// </summary>
        /// <returns></returns>
        public II[] ToIIArray()
        {
            // *** Create single item array ***
            II[] returnVal = new II[1]; 

            // *** Add as null if not present ***
            if (string.IsNullOrWhiteSpace(this.Value)) 
                returnVal[0] = new II { root = "2.16.840.1.113883.4.6", nullFlavor= "UNK" };
            else 
                returnVal[0] = new II() { root = "2.16.840.1.113883.4.6", extension = this.Value };

            return returnVal;
        }

    }
}
