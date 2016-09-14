using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.CDA.Common
{
    /// <summary>
    /// Generic Section for CDA Document Body
    /// </summary>
    public abstract class CdaSection
    {
        // *** Public properties that need to be implemented ***
        // TODO: These should be consolidated into a CdaCode object
        public abstract string CodeSystemName { get; }
        public abstract string CodeSystemId { get; }
        public abstract string Code { get; }
        public abstract string DisplayName { get; }
        public abstract CodingSystem CodeSystem { get; }

        public abstract CdaTemplateIdList TemplateIds { get; }
        public abstract string SectionTitle { get; }

        // *** Narrative text for this section ***
        public string Narrative { get; set; }

        /// <summary>
        /// Creates a CDA component for use with adding into documents
        /// </summary>
        /// <returns>A CDA component</returns>
        public virtual POCD_MT000040Component3 ToPocdComponent()
        {
            // *** Creates the basic section ***

            POCD_MT000040Component3 returnVal = new POCD_MT000040Component3();

            returnVal.section = new POCD_MT000040Section();
            
            // *** Template ID ***            
            returnVal.section.templateId = this.TemplateIds.ToPocd();

            // *** Make sure section has an unique ID ***
            returnVal.section.id = new II { root = Guid.NewGuid().ToString() };

            // *** Code ***
            returnVal.section.code = new CE()
            {
                code = this.Code,
                displayName = this.DisplayName,
                codeSystem = this.CodeSystemId,
                codeSystemName = this.CodeSystemName
            };

            // *** Title ***
            returnVal.section.title = new ST() { Text = new string[] { this.SectionTitle } };

            // *** Then add the text ***             
            returnVal.section.text = this.GetSectionText();

            return returnVal;
        }

        /// <summary>
        /// Creates a CDA component for use with adding into documents
        /// </summary>
        /// <returns>A CDA component</returns>
        public virtual POCD_MT000040Component5 ToPocdComponent5()
        {
            POCD_MT000040Component5 returnVal = new POCD_MT000040Component5();

            returnVal.section = new POCD_MT000040Section();

            // *** Template ID ***
            returnVal.section.templateId = this.TemplateIds.ToPocd();

            // *** Make sure section has an unique ID ***
            returnVal.section.id = new II { root = Guid.NewGuid().ToString() };

            // *** Code ***
            returnVal.section.code = new CE()
            {
                code = this.Code,
                displayName = this.DisplayName,
                codeSystem = this.CodeSystemId,
                codeSystemName = this.CodeSystemName
            };

            // *** Title ***
            returnVal.section.title = new ST() { Text = new string[] { this.SectionTitle } };

            // *** Then add the text ***             
            returnVal.section.text = this.GetSectionText();

            return returnVal;
        }

        protected virtual StrucDocText GetSectionText()
        {
            // *** Create the section text ***

            // **** Narrative + Entries Table ***

            StrucDocText returnVal = new StrucDocText();

            // *** Create list of items ***
            List<object> textItems = new List<object>();

            if (!string.IsNullOrWhiteSpace(this.Narrative))
            {
                // *** Add narrative ***
                StrucDocParagraph narrativeParagraph = new StrucDocParagraph();
                narrativeParagraph.Text = new string[] { this.Narrative };

                textItems.Add(narrativeParagraph);
            }

            // *** Add entries ***
            StrucDocTable entriesTable = this.GetEntriesTable();

            if (entriesTable != null) 
                textItems.Add(entriesTable);

            // *** Add any additional text needed ***
            List<object> additionalText = this.GetAdditionalText(); 

            if (additionalText != null) 
                if (additionalText.Count > 0) 
                    textItems.AddRange(additionalText); 

            returnVal.Items = textItems.ToArray();

            return returnVal;
        }

        /// <summary>
        /// Gets a table for use within the narrative section
        /// </summary>
        /// <returns>A CDA StrucDocTable containing the entries</returns>
        protected abstract StrucDocTable GetEntriesTable();

        /// <summary>
        /// Gets any additional text items beyond entry tables if needed
        /// </summary>
        /// <returns>A list of objects suitable for adding as the Text of a document</returns>
        protected virtual List<object> GetAdditionalText()
        {
            return null;
        }
    }
}
