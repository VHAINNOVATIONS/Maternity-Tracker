// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.UI.Data.Models.Cda.ValueCodes
{
    public class AlbuminDictionary : Dictionary<string, string> 
    {
        public AlbuminDictionary()
        {
            // SNOMED CT
            //Negative (finding) CID 167273002
            //Trace (finding) CID 167274008
            //1+ (finding) CID 167275009
            //2+ (finding) CID 167276005
            //3+ (finding) CID 167277001
            //4+ (finding) CID 167278006

            this.Add("Negative", "167273002");
            this.Add("Trace", "167274008");
            this.Add("1+", "167275009");
            this.Add("2+", "167276005");
            this.Add("3+", "167277001");
            this.Add("4+", "167278006"); 
        }
    }
}
