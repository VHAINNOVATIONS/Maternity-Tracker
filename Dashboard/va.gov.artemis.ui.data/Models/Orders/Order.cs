using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.UI.Data.Models.Orders
{
    public class Order
    {
        public string Ifn { get; set; }
        public string Service { get; set; }
        public string OrderText { get; set; }
        public string StartStop { get; set; }
        public string Provider { get; set; }
        public string Nurse { get; set; }
        public string Clerk { get; set; }
        public string Chart { get; set; }
        public string Status { get; set; }
        public string Location { get; set; }
    }
}
