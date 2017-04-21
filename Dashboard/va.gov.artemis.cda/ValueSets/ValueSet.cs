// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.CDA.ValueSets
{
    public class ValueSet
    {
        public string ValueSetName { get; set; }
        public string Id { get; set; }

        public List<ValueSetItem> Items { get; set; }

        public ValueSet()
        {
            this.Items = new List<ValueSetItem>(); 
        }

    }
}
