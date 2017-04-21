// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.CDA.Common;
using VA.Gov.Artemis.CDA.Observations;

namespace VA.Gov.Artemis.CDA.IHE.Sections
{
    /// <summary>
    /// A Coded Physical Exam Section as defined in the IHE PCC TF2
    /// </summary>
    public class CodedPhysicalExamSection: CdaSection
    {
        // *** Section Information *** 
        public override CodingSystem CodeSystem { get { return CodingSystem.Loinc; } }
        public override string CodeSystemName { get { return "LOINC"; } }
        public override string CodeSystemId { get { return "2.16.840.1.113883.6.1"; } }
        public override string Code { get { return "29545-1"; } }
        public override string DisplayName { get { return "Physical Examination"; } }
        public override CdaTemplateIdList TemplateIds
        {
            get
            {
                return new CdaTemplateIdList("1.3.6.1.4.1.19376.1.5.3.1.3.24", "1.3.6.1.4.1.19376.1.5.3.1.1.9.15", "1.3.6.1.4.1.19376.1.5.3.1.1.9.15.1");
            }
        }

        public override string SectionTitle
        {
            get { return "Coded Detailed Physical Examination"; }
        }

        public CodedVitalSignsSection VitalSigns { get; set; }

        // *** Key is LOINC for subsection, subsections contain narrative only ***
        public Dictionary<string, PhysicalExamSubsection> Subsections { get; set; }

        public CodedPhysicalExamSection()
        {
            this.VitalSigns = new CodedVitalSignsSection(); 

            this.Subsections = new Dictionary<string, PhysicalExamSubsection>();

            // *** Subsection information ***
            // *** NOTE: This data could be externalized for configurability ***
            this.AddPhysicalExamSubsection(CodingSystem.Loinc, "10210-3", "General Status", "1.3.6.1.4.1.19376.1.5.3.1.1.9.16", "General Appearance");
            this.AddPhysicalExamSubsection(CodingSystem.Loinc, "57080-4", "Implanted Medical Device", "1.3.6.1.4.1.19376.1.5.3.1.1.9.48", "Visible Implanted Medical Devices");
            this.AddPhysicalExamSubsection(CodingSystem.Loinc, "29302-7", "Integumentary System", "1.3.6.1.4.1.19376.1.5.3.1.1.9.17", "Integumentary System");
            this.AddPhysicalExamSubsection(CodingSystem.Loinc, "10199-8", "Head", "1.3.6.1.4.1.19376.1.5.3.1.1.9.18", "Head");
            this.AddPhysicalExamSubsection(CodingSystem.Loinc, "10197-2", "Physical Findings of Eye", "1.3.6.1.4.1.19376.1.5.3.1.1.9.19", "Eyes");
            this.AddPhysicalExamSubsection(CodingSystem.Loinc, "11393-6", "Ears and Notes and Mouth and Throat", "1.3.6.1.4.1.19376.1.5.3.1.1.9.20", "Ears, Nose, Mouth and Throat");
            this.AddPhysicalExamSubsection(CodingSystem.Loinc, "10195-6", "Ear", "1.3.6.1.4.1.19376.1.5.3.1.1.9.21", "Ears");
            this.AddPhysicalExamSubsection(CodingSystem.Loinc, "10203-8", "Nose", "1.3.6.1.4.1.19376.1.5.3.1.1.9.22", "Nose");
            this.AddPhysicalExamSubsection(CodingSystem.Loinc, "10201-2", "Mouth and Throat and Teeth", "1.3.6.1.4.1.19376.1.5.3.1.1.9.23", "Mouth, Throat, and Teeth");
            this.AddPhysicalExamSubsection(CodingSystem.Loinc, "11411-6", "Neck", "1.3.6.1.4.1.19376.1.5.3.1.1.9.24", "Neck");
            this.AddPhysicalExamSubsection(CodingSystem.Loinc, "29307-6", "Endocrine System", "1.3.6.1.4.1.19376.1.5.3.1.1.9.25", "Endocrine System");
            this.AddPhysicalExamSubsection(CodingSystem.Loinc, "10207-9", "Thorax and Lungs", "1.3.6.1.4.1.19376.1.5.3.1.1.9.26", "Thorax and Lungs");
            this.AddPhysicalExamSubsection(CodingSystem.Loinc, "11392-8", "Chest Wall", "1.3.6.1.4.1.19376.1.5.3.1.1.9.27", "Chest Wall");
            this.AddPhysicalExamSubsection(CodingSystem.Loinc, "10193-1", "Breasts", "1.3.6.1.4.1.19376.1.5.3.1.1.9.28", "Breasts");
            this.AddPhysicalExamSubsection(CodingSystem.Loinc, "10200-4", "Heart", "1.3.6.1.4.1.19376.1.5.3.1.1.9.29", "Heart");
            this.AddPhysicalExamSubsection(CodingSystem.Loinc, "11412-4", "Respiratory System", "1.3.6.1.4.1.19376.1.5.3.1.1.9.30", "Respiratory System");
            this.AddPhysicalExamSubsection(CodingSystem.Loinc, "10191-5", "Abdomen", "1.3.6.1.4.1.19376.1.5.3.1.1.9.31", "Abdomen");
            this.AddPhysicalExamSubsection(CodingSystem.Loinc, "11447-0", "Hemtologic, Lymphatic, and Immunologic System", "1.3.6.1.4.1.19376.1.5.3.1.1.9.32", "Lymphatic System");
            this.AddPhysicalExamSubsection(CodingSystem.Loinc, "10208-7", "Vessels", "1.3.6.1.4.1.19376.1.5.3.1.1.9.33", "Vessels");
            this.AddPhysicalExamSubsection(CodingSystem.Loinc, "11410-8", "Musculoskeletal System", "1.3.6.1.4.1.19376.1.5.3.1.1.9.34", "Musculoskeletal System");
            this.AddPhysicalExamSubsection(CodingSystem.Loinc, "10202-0", "Neurologic System", "1.3.6.1.4.1.19376.1.5.3.1.1.9.35", "Neurologic System");
            this.AddPhysicalExamSubsection(CodingSystem.Loinc, "11400-9", "Genitalia", "1.3.6.1.4.1.19376.1.5.3.1.1.9.36", "Genitalia");
            this.AddPhysicalExamSubsection(CodingSystem.Loinc, "10205-3", "Rectum", "1.3.6.1.4.1.19376.1.5.3.1.1.9.37", "Rectum");
            this.AddPhysicalExamSubsection(CodingSystem.Loinc, "10196-4", "Extremities", "1.3.6.1.4.1.19376.1.5.3.1.1.16.2.1", "Extremities");
            this.AddPhysicalExamSubsection(CodingSystem.Loinc, "10204-6", "Pelvis", "1.3.6.1.4.1.19376.1.5.3.1.1.21.2.10", "Pelvis");
        }

        private void AddPhysicalExamSubsection(CodingSystem codingSys, string code, string displayName, string templateId, string sectionTitle)
        {
            // *** Adds a subsection to the list ***

            PhysicalExamSubsection tempSubsection = PhysicalExamSubsectionFactory.CreateSubsection(codingSys, code, displayName, templateId, sectionTitle); 
            this.Subsections.Add(code, tempSubsection); 
        }

        /// <summary>
        /// Adds a narrative value for a loinc code ***
        /// </summary>
        /// <param name="loincCode"></param>
        /// <param name="narrative"></param>
        public void AddNarrative(string loincCode, string narrative)
        {
            if (this.Subsections.ContainsKey(loincCode))
                this.Subsections[loincCode].Narrative = narrative; 
        }

        /// <summary>
        /// Creates a POCD component 3
        /// </summary>
        /// <returns></returns>
        public override POCD_MT000040Component3 ToPocdComponent()
        {

            POCD_MT000040Component3 returnVal = base.ToPocdComponent();
                        
            List<POCD_MT000040Component5> componentList = new List<POCD_MT000040Component5>();

            // *** Create Vitals Subsection ***
            componentList.Add(this.VitalSigns.ToPocdComponent5()); 

            // *** Create Other Subsections ***
            foreach (string key in this.Subsections.Keys)
                if ((!string.IsNullOrWhiteSpace(this.Subsections[key].Narrative)) ||
                    (this.Subsections[key].Observations.Count > 0))
                    componentList.Add(this.Subsections[key].ToPocdComponent5());

            returnVal.section.component = componentList.ToArray(); 

            return returnVal; 
        }

        public POCD_MT000040Component5[] ToPocdComponentArray()
        {
            List<POCD_MT000040Component5> returnList = new List<POCD_MT000040Component5>();

            // *** Create Vitals Subsection ***
            returnList.Add(this.VitalSigns.ToPocdComponent5());

            // *** Create Other Subsections ***
            foreach (string key in this.Subsections.Keys)
                if ((!string.IsNullOrWhiteSpace(this.Subsections[key].Narrative)) ||
                    (this.Subsections[key].Observations.Count > 0))
                    returnList.Add(this.Subsections[key].ToPocdComponent5());

            return returnList.ToArray(); 
        }

        protected override StrucDocTable GetEntriesTable()
        {
            // *** No table here ***
            return null; 
        }
    }
}
