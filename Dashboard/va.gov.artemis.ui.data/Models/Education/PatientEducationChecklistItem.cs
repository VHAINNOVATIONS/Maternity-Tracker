// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Commands.Dsio.Checklist;
using VA.Gov.Artemis.UI.Data.Models.Checklist;

namespace VA.Gov.Artemis.UI.Data.Models.Education
{
    public class PatientEducationChecklistItem
    {
        // *** Intended to be a row in the patient education list ***

        // *** List will contain: 
        // ***                   (1) List of PregnancyChecklistItems which are of type Education
        // ***                         (a) Education Item Detail included
        // ***                   (2) PatientEducationItems which are not attached to a checklist item 

        // *** If completed checklist item, PatientEducationItem is present, EducationItem is NULL
        // *** If incomplete checklist item, PatientEducationItem is NULL, EducationItem is present 
        // *** If non-checklist education item, PregnancyChecklistItem is NULL, PatientEducationItem is present, EducationItem is NULL 

        public PregnancyChecklistItem PregnancyChecklistItem { get; set; }

        // *** PregnancyChecklistItem.CompletionLink => EducationItem.Ien
        // *** PregnancyChecklistItem.Link => PatientEducationItem.Ien 

        public PatientEducationItem PatientEducationItem { get; set; }
        public EducationItem EducationItem { get; set; }

        public string Ien
        {
            get
            {
                string returnVal = "";

                if (this.PregnancyChecklistItem != null)
                    returnVal = this.PregnancyChecklistItem.Ien;
                else if (this.PatientEducationItem != null)
                    returnVal = this.PatientEducationItem.Ien;

                return returnVal;
            }
        }

        public EducationItemType ItemType
        {
            get
            {
                EducationItemType returnVal = EducationItemType.Unknown;

                if (this.PatientEducationItem != null)
                    returnVal = this.PatientEducationItem.ItemType;
                else if (this.EducationItem != null)
                    returnVal = this.EducationItem.ItemType;

                return returnVal;
            }
        }

        public string ItemTypeDescription
        {
            get
            {
                string returnVal = "";

                if (this.PatientEducationItem != null)
                    returnVal = this.PatientEducationItem.ItemTypeDescription;
                else if (this.EducationItem != null)
                    returnVal = this.EducationItem.ItemTypeDescription;

                return returnVal;
            }
        }

        public string Category
        {
            get
            {
                string returnVal = "";

                if (this.PatientEducationItem != null)
                    returnVal = this.PatientEducationItem.Category;
                else if (this.EducationItem != null)
                    returnVal = this.EducationItem.Category;

                return returnVal;
            }
        }

        public string Description
        {
            get
            {
                string returnVal = "";

                if (this.PregnancyChecklistItem != null)
                    returnVal = this.PregnancyChecklistItem.Description; 
                if (this.PatientEducationItem != null)
                    returnVal = this.PatientEducationItem.Description;
                else if (this.EducationItem != null)
                    returnVal = this.EducationItem.Description;

                return returnVal;
            }
        }

        public string Due
        {
            get
            {
                string returnVal = "";

                if (this.PregnancyChecklistItem != null)
                    returnVal = this.PregnancyChecklistItem.Due;

                return returnVal;
            }
        }

        public string DueDate
        {
            get
            {
                string returnVal = "";

                if (this.PregnancyChecklistItem != null)
                    returnVal = this.PregnancyChecklistItem.DueDateDisplay;

                return returnVal;
            }
        }

        public string Completed
        {
            get
            {
                string returnVal = "";

                if (this.PregnancyChecklistItem != null)
                    returnVal = this.PregnancyChecklistItem.CompletedDateDisplay;
                else if (this.PatientEducationItem != null)
                    returnVal = this.PatientEducationItem.CompletedOnDisplay;

                return returnVal;
            }
        }

        public bool InProgress
        {
            get
            {
                bool returnVal = false;

                if (this.PregnancyChecklistItem != null)
                    returnVal = this.PregnancyChecklistItem.InProgress; 

                return returnVal;
            }
        }

        public DueStatus DueStatus
        {
            get
            {
                DueStatus returnVal = Checklist.DueStatus.Unknown;

                if (this.PregnancyChecklistItem != null)
                    returnVal = this.PregnancyChecklistItem.DueStatus;
                else if (this.PatientEducationItem != null)
                    returnVal = Checklist.DueStatus.Complete; 

                return returnVal;
            }
        }

        public string Link 
        {
            get 
            {
                // *** Link for checklist items ***
                // *** IEN for completed items ***

                string returnVal = ""; 

                if (this.PregnancyChecklistItem != null) 
                    if (this.PregnancyChecklistItem.CompletionStatus == DsioChecklistCompletionStatus.Complete) 
                        returnVal = this.PregnancyChecklistItem.CompletionLink; 
                    else if (this.PregnancyChecklistItem.ItemType == DsioChecklistItemType.EducationItem)
                        returnVal = this.PregnancyChecklistItem.EducationItemIen; 
                    else 
                        returnVal = this.PregnancyChecklistItem.Link; 
                else if (this.PatientEducationItem != null) 
                    returnVal = this.PatientEducationItem.Ien; 

                return returnVal; 
            }
        }

        public DateTime CompareDate
        {
            get
            {
                DateTime returnVal = DateTime.MinValue;

                if (this.PatientEducationItem != null)
                    returnVal = this.PatientEducationItem.CompletedOn;
                else if (this.PregnancyChecklistItem != null)
                    if (this.PregnancyChecklistItem.CompleteDate != DateTime.MinValue)
                        returnVal = this.PregnancyChecklistItem.CompleteDate;
                    else
                        returnVal = this.PregnancyChecklistItem.DueDate; 

                return returnVal;
            }
        }

    }
}
