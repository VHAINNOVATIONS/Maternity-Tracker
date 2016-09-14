using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.Commands.Xus
{
    public class XusDivision : IComparable<XusDivision>
    {
        public string ID { get; set; }

        public string StationNumber { get; set; }

        public string Name { get; set; }
        public bool IsDefault { get; set; }

        public int CompareTo(XusDivision o)
        {
            return String.Compare(this.Name, o.Name);
        }
    }
}
