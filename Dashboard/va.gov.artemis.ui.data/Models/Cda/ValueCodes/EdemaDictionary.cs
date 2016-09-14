using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.UI.Data.Models.Cda.ValueCodes
{
    public class EdemaDictionary: Dictionary<string, string> 
    {
        public EdemaDictionary()
        {
            // Trace 44996-0
            //1+ pitting edema 420829009
            //2+ pitting edema 421605005
            //3+ pitting edema 421346005
            //4+ pitting edema 421129002

            this.Add("Trace", "44996-0");
            this.Add("1+ pitting edema", "420829009");
            this.Add("2+ pitting edema", "421605005");
            this.Add("3+ pitting edema", "421346005");
            this.Add("4+ pitting edema", "421129002"); 
        }
    }
}
