// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.Commands.Dsio.Checklist
{
    public class DsioSaveMccPatChecklistCommand: DsioCommand
    {
        public string Ien { get; set; }

        public DsioSaveMccPatChecklistCommand(IRpcBroker newBroker) : base(newBroker)
        {

        }

        public override string RpcName
        {
            get { return "MTD SAVE MCC PAT CHECKLIST"; }
        }

        public void AddCommandArguments(DsioPatientChecklistItem item)
        {
            //•	Ien – string – Unique id for existing item – Not Required
            //•	PatientDfn – string – Required
            //•	Pien – string – Pregnancy Id pointing to a pregnancy entry - Required
            // *** NOT PRESENT *** •	DateTime – DateTime – Date and time of last update of this item - Required
            //•	Category – string – Category of item – Not Required
            //•	Description – string Max 180 – Description of Item – Required
            //•	Type – List – Type of item – Required – See list in previous email
            //•	DueCalculationType – List – One of the calculation methods – Required – See list in previous email
            //•	DueCalculationValue – numeric – Value for the calculation – Not Required
            //•	Link – string – Identifies item that will complete item – Not Required
            //•	SpecificDueDate – Date – Specific date that item is due – Not Required
            //•	CompletionStatus – List – Status of the item – Required – See list below
            // *** NOT PRESENT *** •	CompleteDate – DateTime – Date and Time of completion – Not Required 
            //•	CompletionLink – String – Id for item that satisfies or completes item – Not Required
            //•	Note – Word Processing – Notes about this item – Not Required

            // *** SpecificDueDate MUST be fileman date ***

            string itemType = ((int)item.ItemType).ToString();
            string dueType =  ((int)item.DueCalculationType).ToString();
            string completion = ((int)item.CompletionStatus).ToString(); 

            this.CommandArgs = new object[]
            {
                item.PatientDfn, 
                item.Ien, 
                item.Description, 
                item.PregnancyIen, 
                itemType, 
                dueType, 
                item.DueCalculationValue, 
                item.Category, 
                item.Link, 
                item.SpecificDueDate, 
                completion, 
                item.CompletionLink, 
                item.Note, 
                item.InProgress, 
                item.EducationIen
            };

        }

        protected override void ProcessResponse()
        {
            if (this.ProcessQueryResponse())
            {
                string line = this.Response.Lines[0];
                this.Ien = Util.Piece(line, Caret, 2);

                this.Response.Status = RpcResponseStatus.Success;
            }
        }
    }
}
