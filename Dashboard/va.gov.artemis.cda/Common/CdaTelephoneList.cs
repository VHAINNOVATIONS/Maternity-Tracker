using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.CDA.Common
{
    /// <summary>
    /// 
    /// </summary>
    public class CdaTelephoneList: List<CdaTelephone>
    {
        public TEL[] ToTelArray()
        {
            List<TEL> returnList = new List<TEL>();

            if (this.Count == 0)
                returnList.Add(new TEL() { nullFlavor = "UNK" });
            else 
                foreach (CdaTelephone cdaTel in this)
                    returnList.Add(cdaTel.ToTEL()); 

            return returnList.ToArray(); 
        }
    }
}
