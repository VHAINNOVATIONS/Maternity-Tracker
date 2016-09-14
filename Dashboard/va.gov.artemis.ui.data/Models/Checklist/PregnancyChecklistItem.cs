using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Commands.Dsio.Checklist;
using VA.Gov.Artemis.UI.Data.Models.Edd;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.UI.Data.Models.Checklist
{
    public class PregnancyChecklistItem: ChecklistItem
    {
        public string PatientDfn { get; set; }
        public string PregnancyIen { get; set; }
        public DateTime ItemDate { get; set; }
        public DateTime SpecificDueDate { get; set; }

        [DisplayName("Completion Status")]
        public DsioChecklistCompletionStatus CompletionStatus { get; set; }

        public DateTime CompleteDate { get; set; }
        public string CompletionLink { get; set; }
        public string CompletedBy { get; set; }
        public string Note { get; set; }
        public string User { get; set; }

        public string StoredNote
        {
            get
            {
                string returnVal = "";

                if (!string.IsNullOrWhiteSpace(this.Note))
                    if (this.Note.Contains(Environment.NewLine))
                        returnVal = this.Note.Replace(Environment.NewLine, "|");
                    else
                        returnVal = this.Note; 

                return returnVal;
            }
            set
            {
                if (!string.IsNullOrWhiteSpace(value))
                    if (value.Contains("|"))
                        this.Note = value.Replace("|", Environment.NewLine);
                    else
                        this.Note = value; 
            }
        }

        // *** Values needed to calculate actual due date ***
        // *** Not stored with checklist ***
        // *** From pregnancy ***
        public DateTime Edd { get; set; }
        public DateTime PregnancyEndDate { get; set; }

        public PregnancyChecklistItem() { }

        public PregnancyChecklistItem(ChecklistItem baseItem)
        {
            PropertyInfo[] props = typeof(ChecklistItem).GetProperties();

            foreach (PropertyInfo pi in props)
            {
                object orig = pi.GetValue(baseItem);
                if (pi.CanWrite)
                    pi.SetValue(this, orig);
            }
        }

        //public string Status
        //{
        //    get
        //    {
        //        string returnVal = "";

        //        string genericFormat = "{0} on {1}"; 

        //        switch (this.CompletionStatus)
        //        {
        //            case DsioChecklistCompletionStatus.Complete:
        //                returnVal = string.Format(genericFormat,"Completed", this.CompleteDate.ToString(VistaDates.UserDateFormat));
        //                break; 
        //            case DsioChecklistCompletionStatus.MarkedComplete:
        //                returnVal = string.Format(genericFormat,"Marked complete", this.CompleteDate.ToShortDateString());
        //                break; 
        //            case DsioChecklistCompletionStatus.NotNeededOrApplicable: 
        //                returnVal = string.Format(genericFormat,"Canceled", this.CompleteDate.ToShortDateString());
        //                break; 
        //            case DsioChecklistCompletionStatus.NotComplete:
        //                returnVal = GetIncompleteStatus(); 
        //                break; 
        //            case DsioChecklistCompletionStatus.Unknown:
        //                returnVal = "Unknown";
        //                break; 
        //        }

        //        return returnVal; 
        //    }
        //}

        public string ItemDateDisplay
        {
            get
            {
                return this.ItemDate.ToString(VistaDates.UserDateFormat);
            }
        }

        public DueStatus DueStatus
        {
            get
            {
                DueStatus returnVal = Checklist.DueStatus.Unknown;

                switch (this.CompletionStatus)
                {
                    case DsioChecklistCompletionStatus.Complete:
                        returnVal = Checklist.DueStatus.Complete;
                        break;
                    case DsioChecklistCompletionStatus.MarkedComplete:
                        returnVal = Checklist.DueStatus.Complete; 
                        break;
                    case DsioChecklistCompletionStatus.NotNeededOrApplicable:
                        returnVal = Checklist.DueStatus.Canceled; 
                        break;
                    case DsioChecklistCompletionStatus.NotComplete:
                        DateTime dueDate = this.DueDate;

                        if (dueDate == DateTime.MinValue)
                            returnVal = Checklist.DueStatus.Pending; 
                        else if (dueDate.Date.AddDays(3) < DateTime.Now.Date)
                            returnVal = Checklist.DueStatus.Overdue;
                        else if (dueDate.Date.AddDays(-5) < DateTime.Now.Date)
                            returnVal = Checklist.DueStatus.Due;
                        else
                            returnVal = Checklist.DueStatus.Pending;                             

                        break;
                }

                return returnVal; 
            }
        }

        //private string GetIncompleteStatus()
        //{
        //    string returnVal = "";

        //    if (this.SpecificDueDate != DateTime.MinValue)
        //        returnVal = string.Format("Due on {0}", this.SpecificDueDate);
        //    else if (this.DueCalculationType == DsioChecklistCalculationType.Initial)
        //        returnVal = "Due Now";
        //    else if (this.PregnancyEndDate == DateTime.MinValue)
        //        returnVal = "After Delivery"; 
        //    else
        //    {
        //        DateTime dueDate = this.DueDate;

        //        if (dueDate == DateTime.MinValue)
        //            returnVal = "Unknown"; 
        //        else 
        //            returnVal = string.Format("Due on {0}", dueDate);
        //    }

        //    return returnVal; 
        //}

        public DateTime DueDate
        {
            get
            {
                DateTime returnVal = DateTime.MinValue;

                if (this.SpecificDueDate != DateTime.MinValue)
                    returnVal = this.SpecificDueDate;
                else
                {
                    switch (this.DueCalculationType)
                    {
                        case DsioChecklistCalculationType.Initial:
                            returnVal = DateTime.Now.AddDays(-1);
                            break;
                        case DsioChecklistCalculationType.WeeksGa:
                            if (this.Edd != DateTime.MinValue)
                            {
                                DateTime startDate = this.Edd.Subtract(new TimeSpan(280, 0, 0, 0));
                                int gaDays = this.DueCalculationValue * 7;
                                returnVal = startDate.AddDays(gaDays);
                            }
                            break;
                        case DsioChecklistCalculationType.TrimesterGa:
                            if (this.Edd != DateTime.MinValue)
                            {
                                DateTime startDate = this.Edd.Subtract(new TimeSpan(280, 0, 0, 0));
                                int gaDays = this.DueCalculationValue * 14 * 7;
                                returnVal = startDate.AddDays(gaDays);
                            }
                            break;
                        case DsioChecklistCalculationType.WeeksPostpartum:
                            if (this.PregnancyEndDate != DateTime.MinValue)
                                returnVal = this.PregnancyEndDate.AddDays(this.DueCalculationValue * 7);
                            else
                                returnVal = this.Edd.AddDays(this.DueCalculationValue * 7); // *** Assumes baby is delivered on due date ***
                            break;
                    }
                }
                return returnVal;
            }
        }

        public string DueDateDisplay
        {
            get
            {
                string returnVal = "";

                DateTime dueDate = this.DueDate;

                if (dueDate != DateTime.MinValue)
                    returnVal = dueDate.ToString(VistaDates.UserDateFormat); 

                return returnVal;
            }
        }

        public string CompletedDateDisplay
        {
            get
            {
                string returnVal = "";

                if (this.CompletionStatus == DsioChecklistCompletionStatus.Complete)
                    if (this.CompleteDate != DateTime.MinValue)
                        returnVal = this.CompleteDate.ToString(VistaDates.UserDateTimeFormat);

                return returnVal;
            }
        }

        public override string Due
        {
            get
            {
                string returnVal; 
                
                if (this.SpecificDueDate != DateTime.MinValue)
                    if (this.DueCalculationType == DsioChecklistCalculationType.Initial)
                        returnVal = base.Due; 
                    else 
                        returnVal = "Specific Date"; 
                else 
                    returnVal = base.Due; 

                return returnVal; 
            }
        }

        public string SpecificDueDateText
        {
            get
            {
                return (this.SpecificDueDate == DateTime.MinValue) ? "" : this.SpecificDueDate.ToString(VistaDates.UserDateFormat);
            }
            set
            {
                string temp = VistaDates.StandardizeDateFormat(value);

                if (!string.IsNullOrWhiteSpace(temp))
                    this.SpecificDueDate = VistaDates.ParseDateString(temp, VistaDates.VistADateOnlyFormat);
            }
        }
        
        public bool InProgress { get; set; }

    }
}
