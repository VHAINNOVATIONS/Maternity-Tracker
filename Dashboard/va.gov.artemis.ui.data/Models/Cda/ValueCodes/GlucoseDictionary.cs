// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.UI.Data.Models.Cda.ValueCodes
{
    public class GlucoseDictionary : Dictionary<string, string> 
    {
        public GlucoseDictionary()
        {
            //Negative (finding) CID 167261002
            //Trace (finding) CID 167262009
            //1+ (finding) CID 167264005
            //2+ (finding) CID 167265006
            //3+ (finding) CID 167266007
            //4+ (finding) CID 167267003

            this.Add("Negative", "167261002");
            this.Add("Trace", "167262009");
            this.Add("1+", "167264005");
            this.Add("2+", "167265006");
            this.Add("3+", "167266007");
            this.Add("4+", "167267003"); 
        }
    }
}
