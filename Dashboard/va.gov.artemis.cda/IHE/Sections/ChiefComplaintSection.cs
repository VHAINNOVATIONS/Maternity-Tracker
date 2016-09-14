using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.CDA.Common;

namespace VA.Gov.Artemis.CDA.IHE.Sections
{
    /// <summary>
    /// CDA Document Body Section: Chief Complaint
    /// </summary>
    public class ChiefComplaintSection : CdaSection
    {
        // *** Section Information ***
        public override string CodeSystemName { get { return "LOINC"; } }
        public override string CodeSystemId { get { return "2.16.840.1.113883.6.1"; } }
        public override string Code { get { return "10154-3"; } }
        public override string DisplayName { get { return "Chief Complaint"; } }
        public override CdaTemplateIdList TemplateIds 
        { 
            get 
            { 
                return new CdaTemplateIdList("1.3.6.1.4.1.19376.1.5.3.1.1.13.2.1"); 
            } 
        }

        public override CodingSystem CodeSystem
        {
            get { return CodingSystem.Loinc; }
        }

        public override string SectionTitle
        {
            get { return "Chief Complaint"; }
        }

        public override POCD_MT000040Component3 ToPocdComponent()        
        {
            if (string.IsNullOrWhiteSpace(this.Narrative)) 
                    this.Narrative = "(No Data)"; 
                        
            POCD_MT000040Component3 returnVal = base.ToPocdComponent();

            return returnVal; 
        }

        // *** Chief Complaint Observation From Vista ***
        //public string Narrative { get; set; }

        //<component>
        //    <section>
        //        <templateId root="1.3.6.1.4.1.19376.1.5.3.1.1.13.2.1"/>
        //        <code code="10154-3" displayName="CHIEF COMPLAINT"
        //            codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC"/>
        //        <text> Chief Complaint text </text>
        //    </section>
        //</component>

        //public override POCD_MT000040Component3 ToPocdComponent()
        //{
        //    POCD_MT000040Component3 returnVal = new POCD_MT000040Component3();

        //    // *** If there is something to use ***
        //    if (!string.IsNullOrWhiteSpace(this.Narrative))
        //    {
        //        // *** First create basic section ***
        //        returnVal = base.ToPocdComponent();

        //        // *** Then add the text ***
        //        returnVal.section.text = new StrucDocText() { Text = new string[] { this.Narrative } };
        //    }

        //    return returnVal;
        //}

        protected override StrucDocTable GetEntriesTable()
        {
            // *** No table needed ***
            return null; 
        }
    }
}
