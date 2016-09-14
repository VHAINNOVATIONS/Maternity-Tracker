using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.UI.Data.Models.Common;
using VA.Gov.Artemis.UI.Data.Models.Patient;

namespace VA.Gov.Artemis.UI.Data.Models.Consults
{
    public class ConsultIndex: PatientRelatedModel
    {
        public Paging Paging { get; set; }

        public List<Consult> Items { get; set; }

        public ConsultIndex()
        {
            this.Paging = new Paging();
            this.Items = new List<Consult>(); 
        }
    }
}
