// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.UI.Data.Models.Patient;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.UI.Data.Models.Education
{
    public class PatientEducationSelect: PatientRelatedModel
    {
        //public Dictionary<string, List<EducationItem>> CategoryLists { get; set; }

        private int tableSize = 15;
        private int itemsAdded = 0;
        private int tableIndex = 0; 

        public List<List<PatientEducationSelectItemRow>> SelectLists { get; set; }

        public string SelectedIens { get; set; }

        public PatientEducationSelect()
        {
            this.SelectLists = new List<List<PatientEducationSelectItemRow>>(); 
        }

        public void AddRow(PatientEducationSelectItemRow row)
        {
            if (this.SelectLists.Count == 0)
                this.SelectLists.Add(new List<PatientEducationSelectItemRow>());
            else if  (tableIndex > this.SelectLists.Count - 1)
            {
                this.SelectLists.Add(new List<PatientEducationSelectItemRow>());

                if (!row.CategoryRow)
                {
                    PatientEducationSelectItemRow continueRow = new PatientEducationSelectItemRow() 
                    { 
                        CategoryRow = true, 
                        Category = string.Format("{0} (continued)", row.Category )
                    };

                    this.SelectLists[tableIndex].Add(continueRow);

                    itemsAdded += 1;
                }

            }

            this.SelectLists[tableIndex].Add(row);

            itemsAdded += 1;

            if (itemsAdded % tableSize == 0)
                tableIndex += 1; 

        }

        public List<string> GetSelectedIenList()
        {
            List<string> returnVal = new List<string>();

            if (!string.IsNullOrWhiteSpace(this.SelectedIens))
            {
                string[] iens = this.SelectedIens.Split("^".ToCharArray());

                if (iens != null)
                    returnVal.AddRange(iens);
            }

            return returnVal;
        }
    }
}
