using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.CDA.Common
{
    /// <summary>
    /// A CDA object used to represent the subject pertaining to a section
    /// </summary>
    public class CdaSubject
    {
        // *** Information about this subject ***
        public Hl7FamilyMember FamilyMember { get; set; }
        public string FirstName { get; set; }
        public Hl7Gender Gender { get; set; }
        public DateTime BirthTime { get; set; }

        // NOTE: Could be expanded to include other subject data 

        /// <summary>
        /// Creates the CDA subject object ***
        /// </summary>
        /// <returns>A CDA Subject</returns>
        public POCD_MT000040Subject ToPocdSubject()
        {
            // *** Create the subject ***
            POCD_MT000040Subject subject = new POCD_MT000040Subject() { typeCode = ParticipationTargetSubject.SBJ, typeCodeSpecified = true };

            // *** Create the related subject ***
            POCD_MT000040RelatedSubject relatedSubject = new POCD_MT000040RelatedSubject(); // { classCode = x_DocumentSubject.PRS };

            // *** Create the role and add as code ***
            if (this.FamilyMember != Hl7FamilyMember.Unknown)
            {
                CdaRoleCode roleCode = new CdaRoleCode() { FamilyMember = this.FamilyMember };
                relatedSubject.code = roleCode.ToCe();
            }

            // *** Create the person ***
            POCD_MT000040SubjectPerson subjectPerson = new POCD_MT000040SubjectPerson();             

            // *** Set the gender ***
            if (this.Gender != Hl7Gender.Unknown)
            {
                CdaGender gender = new CdaGender() { Value = this.Gender };
                subjectPerson.administrativeGenderCode = gender.ToCE();
            }

            // *** Birth date and/or time ***
            if (this.BirthTime != DateTime.MinValue)
                subjectPerson.birthTime = new TS() { value = this.BirthTime.ToString(RawCdaDocument.CdaDateFormat)}; 
            else
                subjectPerson.birthTime = new TS() {nullFlavor = "UNK"};

            // *** First Name ***
            CdaName tempName = new CdaName();

            if (!string.IsNullOrWhiteSpace(this.FirstName))
                tempName.First = this.FirstName;
            else
                tempName.NullFlavor = "UNK"; 
            
            subjectPerson.name = new PN[] { tempName.ToPN() };            

            // *** Add subject person ***
            relatedSubject.subject = subjectPerson; 

            // *** Add the related subject to the subject ***
            subject.relatedSubject = relatedSubject;

            return subject;
        }
    }
}
