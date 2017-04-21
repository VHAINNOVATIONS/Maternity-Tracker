// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.UI.Data.Brokers;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.UI.Data.Models.Common
{
    public class Person
    {
        public string Ien { get; set; }

        public string FirstName { get; set; }
        public string LastName { get; set; }

        public Address Address { get; set; }

        public Nullable<DateTime> DOB { get; set; }

        public string DobText
        {
            get
            {
                string returnVal = "";

                if (this.DOB.HasValue)
                    if (this.DOB.Value != DateTime.MinValue)
                        returnVal = this.DOB.Value.ToString(VistaDates.VistADateOnlyFormat);

                return returnVal;
            }
            set
            {
                DateTime tempDate = VistaDates.ParseDateString(value, VistaDates.VistADateOnlyFormat); 
                if (tempDate != DateTime.MinValue)
                    this.DOB = tempDate; 
            }
        }
            
        public string HomePhone { get; set; }
        public string WorkPhone { get; set; }
        public string MobilePhone { get; set; }

        public Nullable<int> YearsSchool { get; set; }

        public string Name
        {
            get
            {
                return string.Format("{0}, {1}", this.LastName, this.FirstName);
            }
        }

        public bool Spouse { get; set; }
    }
}
