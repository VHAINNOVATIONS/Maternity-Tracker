// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.UI.Data.Models.Cda.ValueCodes
{
    public class FetalPresentationDictionary: Dictionary<string, string> 
    {
        public FetalPresentationDictionary()
        {
            this.Add("Vertex", "70028003");
            this.Add("Breech", "6096002");
            this.Add("Transverse", "73161006");
            this.Add("Oblique", "63750008");
            this.Add("Compound", "124736009");
            this.Add("Brow", "8014007");
            this.Add("Face", "21882006");
        }
    }
}
