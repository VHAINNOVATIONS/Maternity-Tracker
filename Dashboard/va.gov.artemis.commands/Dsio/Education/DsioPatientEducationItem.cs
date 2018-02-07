// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.Commands.Dsio.Education
{
//    MTD SAVE PATIENT EDUCATION

//Parameters:
//•	PatientDfn – string - Unique User ID – Required
//•	Ien – string - Identifier of existing record – Not Required
//•	CompletedOn – DateTime – Required
//•	EducationItemIEN – String – Not Required
//•	Category – String – Education Category – Not Required
//•	Description – String – Text Description – Not Required
//•	Type – Choice of (D)iscussion Topic, (L)ink to Material, (P)rinted Material, (E)nrollment, or (O)ther – Not Required
//•	URL – String – Web link to content – Not Required
//•	Code – Code – Not Required
//•	Code System – (L)oinc, (S)nomed, (N)one – Not Required

//Operation:
//•	The RPC should save the data included in the parameter values.
//•	The current user should be included in the stored data
//•	If Ien is present, update the existing record.
//•	If Ien is absent, create a new record.
//•	If EducationItemIEN is present, use values from MTD EDUCATION to populate the following:
//o	Category
//o	Description
//o	Type
//o	URL
//o	Code
//o	Code System
//•	If EducationItemIEN is absent, use parameter values and the following are required:
//o	Description
//o	Type
//o	CodeSystem
//•	Note: There should NOT be a link between MTD PATIENT EDUCATION and MTD EDUCATION.

    public class DsioPatientEducationItem: DsioEducationItem
    {
        public string PatientDfn { get; set; }

        // *** Not Stored - Used to copy values from education item ***
        public string EducationItemIen { get; set; }

        public string CompletedOn { get; set; }
        public string CompletedBy { get; set; }

        public DsioPatientEducationItem()
        {

        }

        public DsioPatientEducationItem(DsioEducationItem baseItem)
        {
            PropertyInfo[] props = typeof(DsioEducationItem).GetProperties();

            foreach (PropertyInfo pi in props)
            {
                object orig = pi.GetValue(baseItem);
                if (pi.CanWrite)
                    pi.SetValue(this, orig);
            }
        }

    }
}
