// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.CDA.Common;

namespace VA.Gov.Artemis.CDA.IHE.Sections
{
    internal static class PhysicalExamSubsectionFactory
    {
        /// <summary>
        /// Creates a Physical Exam Subsection using initial values that are required
        /// </summary>
        /// <param name="codingSys">The system of coding</param>
        /// <param name="code">The code used</param>
        /// <param name="displayName">The name associated with the code</param>
        /// <param name="templateId">The template id of the sub-section</param>
        /// <param name="sectionTitle">The title of the section</param>
        /// <returns>A new PhysicalExamSubsection</returns>
        public static PhysicalExamSubsection CreateSubsection(CodingSystem codingSys, string code, string displayName, string templateId, string sectionTitle)
        {
            PhysicalExamSubsection returnVal = new PhysicalExamSubsection();

            // *** Get system info ***
            string codeSysName = CodingSystemUtility.GetDescription(codingSys);
            string codeSysId = CodingSystemUtility.GetSystemId(codingSys); 

            // *** Set the code ***
            returnVal.SetCode(codeSysName, codeSysId, code, displayName, codingSys);

            // *** Set the template id ***
            returnVal.SetTemplateIds(templateId);

            // *** Set the section title ***
            returnVal.SetSectionTitle(sectionTitle);

            return returnVal; 
        }
    }

}
