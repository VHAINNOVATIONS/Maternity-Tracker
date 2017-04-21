// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.UI.Data.Models.Cda.ValueCodes
{
    public class FetalMovementDictionary : Dictionary<string, string> 
    {
        public FetalMovementDictionary()
        {
            //fetal movement activity (finding) CID 364755008
            //baby kicks a lot (finding) CID 276368003
            //baby not moving (finding) CID 276370007
            //reduced fetal movement (finding) CID 276369006
            //fetal movements present (finding) CID 289431008
            //fetal movements felt (finding) CID 268470003
            //fetal movements seen (finding) CID 169731002

            this.Add("fetal movement activity", "364755008");
            this.Add("baby kicks a lot", "276368003");
            this.Add("baby not moving", "276370007");
            this.Add("reduced fetal movement", "276369006");
            this.Add("fetal movements present", "289431008");
            this.Add("fetal movements felt", "268470003");
            this.Add("fetal movements seen", "169731002"); 

        }
    }
}
