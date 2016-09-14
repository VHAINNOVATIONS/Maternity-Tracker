using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.UI.Data.Models.Cda.ValueCodes
{
    public class PainDictionary : Dictionary<string, string> 
    {
        public PainDictionary()
        {
            for (int i = 0; i <= 10; i++)
                this.Add(i.ToString(), i.ToString()); 
        }
    }
}
