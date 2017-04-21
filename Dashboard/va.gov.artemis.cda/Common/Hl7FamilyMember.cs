// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.CDA.Common
{
    public enum Hl7FamilyMember
    {
        Unknown, 
        FamilyMember, // FAMMEMB
        Child, // CHILD
        AdoptedChild, // CHILDADOPT
        AdoptedDaughter, // DAUADOPT
        AdoptedSon, // SONADOPT
        ChildInLaw, // CHLDINLAW
        DaughterInLaw, //DAUINLAW
        SonInLaw, // SONINLAW
        FosterChild, //CHLDFOST
        FosterDaughter, //DAUFOST
        FosterSon, //SONFOST
        NaturalChild, // NCHILD
        NaturalDaughter, // DAU
        NaturalSon, // SON
        StepChild, //STPCHLD
        StepDaughter, //STPDAU
        StepSon, //STPSON
        GrandChild, // GRNDCHILD
        GrandDaughter, // GRNDDAU
        GrandSon, // GRNDSON
        GrandParent, // GRPRN
        GrandFather, // GRFTH
        GrandMother, // GRMTH
        NieceNephew, //NIENEPH
        Nephew, // NEPHEW
        Niece, // NIECE
        Parent, // PRN
        NaturalParent, // NPRN
        NaturalFather, // NFTH
        NaturalMother, // NMTH
        ParentInLaw, // PRNINLAW
        FatherInLaw, // FTHINLAW
        MotherInLaw, // MTHINLAW
        StepParent, // STPPRN
        StepFther, // STPFTH
        StepMother, // STPMTH
        Father, // FTH
        Mother, // MTH
        Sibling, // SIB
        HalfSibling, // HSIB
        HalfBrother, // HBRO
        HalfSister, // HSIS
        NaturalSibling, // NSIB
        NaturalBrother, // NBRO
        NaturalSister, // NSIS
        SiblingInLaw, // SIBINLAW
        BrotherInLaw, // BROINLAW
        SisterInLaw, // SISINLAW
        StepSibling, // STPSIB
        StepBrother, // STPBRO
        StepSister, // STPSIS
        Brother, // BRO
        Sister, // SIS
        SignificantOther, // SIGOTHR
        Spouse, // SPS
        Husband, // HUSB
        Wife, // WIFE
        Aunt, // AUNT
        Cousin, // COUSN
        DomesticPartner, // DOMPART
        Roommate, // ROOM
        Uncle, // UNCLE
    }
}
