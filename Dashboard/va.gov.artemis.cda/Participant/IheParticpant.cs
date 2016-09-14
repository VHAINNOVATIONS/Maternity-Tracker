using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.CDA.Participant
{
//    <code code="FTH" displayName="Father"
//codeSystemName="HL7RoleCode"
//codeSystem="2.16.840.1.113883.5.111">
//<translation code="9947008"
//displayName="Biological father"
//codeSystemName="SNOMED CT"
//codeSystem="2.16.840.1.113883.6.96"/>
//</code>

    public class IheParticipant: CdaParticipant
    {
        public IheParticipantType ParticipantType { get; set; }
        
        private string[] participantCodes = new string[] { "", "xx-spouse", "xx-fatherofbaby" };
        private string[] participantDisplayNames = new string[] { "", "Patient's Spouse", "Father Of Baby" }; 

        public override POCD_MT000040Participant1 ToPocdParticipant()
        {
            POCD_MT000040Participant1 returnVal = base.ToPocdParticipant();

            // *** Add IHE template id's for spouse ***
            List<II> templateIds = new List<II>();

            templateIds.Add(new II() { root = "1.3.6.1.4.1.19376.1.5.3.1.2.4" });

            CE code = new CE() { nullFlavor = "UNK" };

            if (this.ParticipantType == IheParticipantType.Spouse)
            {
                templateIds.Add(new II() { root = "1.3.6.1.4.1.19376.1.5.3.1.2.4.1" });
                code = new CE() { codeSystem = "2.16.840.1.113883.5.111", codeSystemName = "HL7RoleCode", code = "SPS", displayName = "Spouse" };
            }
            else if (this.ParticipantType == IheParticipantType.FatherOfFetus)
            {
                templateIds.Add(new II() { root = "1.3.6.1.4.1.19376.1.5.3.1.2.4.2" });
                code = new CE() { codeSystem = "2.16.840.1.113883.5.111", codeSystemName = "HL7RoleCode", code = "FAMMEMB", displayName = "Family Member" };
            }

            returnVal.templateId = templateIds.ToArray();

            CE codedEntry = new CE();
            codedEntry.code = this.participantCodes[(int)this.ParticipantType];
            codedEntry.displayName = this.participantDisplayNames[(int)this.ParticipantType];
            codedEntry.codeSystem = "2.16.840.1.113883.6.96";
            codedEntry.codeSystemName = "SNOMED CT";

            
            code.translation = new CD[] { codedEntry };

            // *** NOTE: This code adds IHE roles as translation...
            //returnVal.associatedEntity.code = code; 

            // *** NOTE: This code adds IHE roles as top code...
            returnVal.associatedEntity.code = codedEntry; 

            return returnVal; 
        }
    }
}
