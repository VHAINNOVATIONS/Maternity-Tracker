using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.CDA.Common;
using VA.Gov.Artemis.UI.Data.Models.Common;
using VA.Gov.Artemis.UI.Data.Models.Patient;

namespace VA.Gov.Artemis.UI.Data.Models.Education
{
    public class PatientEducationAddEdit: PatientRelatedModel
    {
        public PatientEducationItem Item { get; set; }

        public PatientEducationAddEdit()
        {
            this.Item = new PatientEducationItem(); 
        }

        public Dictionary<EducationItemType, string> ItemTypeSelection { get; set; }

        //public Dictionary<string, CodingSystem> CodingSystemSelection
        //{
        //    get
        //    {
        //        Dictionary<string, CodingSystem> returnList = new Dictionary<string, CodingSystem>();

        //        returnList.Add("None", CodingSystem.None);
        //        returnList.Add("LOINC", CodingSystem.Loinc);
        //        returnList.Add("SNOMED-CT", CodingSystem.SnomedCT);

        //        return returnList;
        //    }
        //}

    }
}
