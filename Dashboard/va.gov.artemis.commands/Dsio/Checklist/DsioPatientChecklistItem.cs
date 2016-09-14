using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.Commands.Dsio.Checklist
{
    public class DsioPatientChecklistItem: DsioChecklistItem
    {        
        //•	Ien – string – Unique id for existing item – Not Required
        //•	PatientDfn – string – Required
        //•	Pien – string – Pregnancy Id pointing to a pregnancy entry - Required
        //•	DateTime – DateTime – Date and time of last update of this item - Required
        //•	Category – string – Category of item – Not Required
        //•	Description – string Max 180 – Description of Item – Required
        //•	Type – List – Type of item – Required – See list in previous email
        //•	DueCalculationType – List – One of the calculation methods – Required – See list in previous email
        //•	DueCalculationValue – numeric – Value for the calculation – Not Required
        //•	Link – string – Identifies item that will complete item – Not Required
        //•	SpecificDueDate – Date – Specific date that item is due – Not Required
        //•	CompletionStatus – List – Status of the item – Required – See list below
        //•	CompleteDate – DateTime – Date and Time of completion – Not Required 
        //•	CompletionLink – String – Id for item that satisfies or completes item – Not Required
        //•	Note – Word Processing – Notes about this item – Not Required

        public string PatientDfn { get; set; }
        public string PregnancyIen { get; set; }
        public string ItemDate { get; set; }
        public string SpecificDueDate { get; set; }
        public DsioChecklistCompletionStatus CompletionStatus { get; set; }
        public string CompleteDate { get; set; }
        public string CompletionLink { get; set; }
        public string CompletedBy { get; set; }
        public string Note { get; set; }
        public string User { get; set; }

        public string InProgress { get; set; }

        public DsioPatientChecklistItem () {}

        public DsioPatientChecklistItem(DsioChecklistItem baseItem)
        {
            PropertyInfo[] props = typeof(DsioChecklistItem).GetProperties();

            foreach (PropertyInfo pi in props)
            {
                object orig = pi.GetValue(baseItem);
                if (pi.CanWrite)
                    pi.SetValue(this, orig);
            }
        }
    }
}
