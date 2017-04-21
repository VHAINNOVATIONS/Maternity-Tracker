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
    /// A class which simplifies creating a list of performers 
    /// </summary>
    public class CdaPerformerList: List<CdaPerformer>
    {
        public POCD_MT000040Performer1[] ToPocdPerformerArray()
        {
            List<POCD_MT000040Performer1> returnList = new List<POCD_MT000040Performer1>();

            foreach (CdaPerformer performer in this)
                returnList.Add(performer.ToPocdPerformer()); 

            return returnList.ToArray(); 
        }
    }
}
