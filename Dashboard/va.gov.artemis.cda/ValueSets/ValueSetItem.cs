using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.CDA.Common;

namespace VA.Gov.Artemis.CDA.ValueSets
{
    public class ValueSetItem
    {
        public string Code { get; set; }
        public CodingSystem CodeSystem { get; set; }
        public string ItemName { get; set; }
        public string Category { get; set; }

        public ValueSetItem()
        {

        }

        public ValueSetItem(string code, CodingSystem system, string name, string category)
        {
            this.Code = code;
            this.CodeSystem = system;
            this.ItemName = name;
            this.Category = category; 
        }
    }
}
