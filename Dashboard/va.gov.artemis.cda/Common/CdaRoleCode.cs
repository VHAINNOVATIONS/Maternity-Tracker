// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.CDA.Common
{
    public class CdaRoleCode
    {
        private static string[] relationshipDescriptions = new string[]{
            "", 
            "FAMMEMB",
            "CHILD",
            "CHILDADOPT",
            "DAUADOPT",
            "SONADOPT",
            "CHLDINLAW",
            "DAUINLAW",
            "SONINLAW",
            "CHLDFOST",
            "DAUFOST",
            "SONFOST",
            "NCHILD",
            "DAU",
            "SON",
            "STPCHLD",
            "STPDAU",
            "STPSON",
            "GRNDCHILD",
            "GRNDDAU",
            "GRNDSON",
            "GRPRN",
            "GRFTH",
            "GRMTH",
            "NIENEPH",
            "NEPHEW",
            "NIECE",
            "PRN",
            "NPRN",
            "NFTH",
            "NMTH",
            "PRNINLAW",
            "FTHINLAW",
            "MTHINLAW",
            "STPPRN",
            "STPFTH",
            "STPMTH",
            "FTH",
            "MTH",
            "SIB",
            "HSIB",
            "HBRO",
            "HSIS",
            "NSIB",
            "NBRO",
            "NSIS",
            "SIBINLAW",
            "BROINLAW",
            "SISINLAW",
            "STPSIB",
            "STPBRO",
            "STPSIS",
            "BRO",
            "SIS",
            "SIGOTHR",
            "SPS",
            "HUSB",
            "WIFE",
            "AUNT",
            "COUSN",
            "DOMPART",
            "ROOM",
            "UNCLE",
        };

        private string[] displayNames = new string[]{
            "", 
            "Family Member",
            "Child",
            "Adopted Child",
            "Adopted Daughter",
            "Adopted Son",
            "Child In-Law",
            "Daughter In-Law",
            "Son In-Law",
            "Foster Child",
            "Foster Daughter",
            "Foster Son",
            "Natural Child",
            "Natural Daughter",
            "Natural Son",
            "Step Child",
            "Step Daughter",
            "Step Son",
            "Grandchild",
            "Granddaughter",
            "Grandson",
            "Grandparent",
            "Grandfather",
            "Grandmother",
            "Neice/Nephew",
            "Nephew",
            "Niece",
            "Parent",
            "Natural Parent",
            "Natural Father",
            "Natural Mother",
            "Parent In-Law",
            "Father In-Law",
            "Mother In-Law",
            "Step Parent",
            "Step Father",
            "Step Mother",
            "Father",
            "Mother",
            "Sibling",
            "Half Sibling",
            "Half Brother",
            "Half Sister",
            "Natural Sibling",
            "Natural Brother",
            "Natural Sister",
            "Sibling In-Law",
            "Brother In-Law",
            "Sister In-Law",
            "Step Sibling",
            "Step Brother",
            "Step Sister",
            "Brother",
            "Sister",
            "Significant Other",
            "Spouse",
            "Husband",
            "Wife",
            "Aunt",
            "Cousin",
            "Domestic Partner",
            "Roommate",
            "Uncle",
        };
        public Hl7FamilyMember FamilyMember {get; set ; }

        public CE ToCe()
        {
            CE returnVal = new CE() { codeSystem = "2.16.840.1.113883.5.111", codeSystemName = "RoleCode", displayName = this.DisplayName}; 

            returnVal.code = relationshipDescriptions[(int)this.FamilyMember]; 

            return returnVal; 
        }

        public string DisplayName
        {
            get
            {
                return displayNames[(int)this.FamilyMember];
            }
        }

        public static Hl7FamilyMember GetHl7FamilyMember(string fam)
        {
            Hl7FamilyMember returnVal = Hl7FamilyMember.Unknown;

            int idx = Array.IndexOf(relationshipDescriptions, fam); 

            if (idx >= 0) 
                returnVal =(Hl7FamilyMember)idx; 

            return returnVal;
        }        
    }
}
