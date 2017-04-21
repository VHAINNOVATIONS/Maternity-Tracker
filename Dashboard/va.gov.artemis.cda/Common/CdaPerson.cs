// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.CDA.Common
{
    /// <summary>
    /// A simplified person object for use in creating a Rich CDA object 
    /// </summary>
    public class CdaPerson
    {
        /// <summary>
        /// The person's name 
        /// </summary>
        public CdaName Name { get; set; }

        public CdaPerson()
        {
            this.Name = new CdaName(); 
        }

        /// <summary>
        /// Creates a raw "person" from the raw CDA schema
        /// </summary>
        /// <returns>A POCD_MT000040Person</returns>
        public POCD_MT000040Person ToPocdPerson()
        {
            POCD_MT000040Person returnPerson = new POCD_MT000040Person();

            returnPerson.name = new PN[]{this.Name.ToPN()};

            return returnPerson; 
        }
    }
}
