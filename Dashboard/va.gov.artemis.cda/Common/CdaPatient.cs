// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.CDA.Common
{
    public class CdaPatient
    {
        // *** Required ***
        public CdaName Name { get; set; } 
        public Hl7Gender Gender { get; set; } 
        public DateTime DateOfBirth { get; set; } 
        
        // *** Not Required ***
        public Hl7MaritalStatus MaritalStatus { get; set; }

        public Hl7Race Race { get; set; }
        public Hl7EthnicGroup EthnicGroup { get; set; }

        // *** TODO: These values not exported to POCD yet ...
        public Hl7ReligiousAffiliation Religion { get; set; }
        
        public CdaPatient()
        {
            this.Name = new CdaName();
        }

        internal POCD_MT000040Patient ToPocdPat()
        {
            POCD_MT000040Patient returnPat = new POCD_MT000040Patient();

            // *** Name ***
            returnPat.name = new PN[] { this.Name.ToPN() };

            // *** Gender ***
            returnPat.administrativeGenderCode = this.GenderEntry;

            // *** DOB ***
            returnPat.birthTime = new TS();
            if (this.DateOfBirth != DateTime.MinValue)
                returnPat.birthTime.value = this.DateOfBirth.ToString("yyyyMMdd");
            else
                returnPat.birthTime.nullFlavor = "UNK"; 

            // *** Marital Status ***
            if (this.MaritalStatus != Hl7MaritalStatus.Unknown)
                returnPat.maritalStatusCode = this.MaritalStatusEntry; 

            // *** Ethnic Group ***
            if (this.EthnicGroup != Hl7EthnicGroup.Unknown)
                returnPat.ethnicGroupCode = this.EthnicGroupEntry; 

            // *** Race ***
            if (this.Race != Hl7Race.Unknown)
                returnPat.raceCode = this.RaceEntry; 

            return returnPat; 
        }

        private CE GenderEntry
        {
            get
            {
                CE returnEntry = new CE();

                //Unknown, Male, Female, Undifferentiated
                string[] codes = new string[] {"", "M", "F", "UN" };

                returnEntry.code = codes[(int)this.Gender];
                returnEntry.codeSystem = "2.16.840.1.113883.5.1";

                return returnEntry;
            }
        }

        private CE MaritalStatusEntry
        {
            get
            {
                CE returnEntry = new CE();
                
                //Unknown, Annulled, Divorced, Interlocutory, LegallySeparated, Married, Polygamous, NeverMarried, DomesticPartner, Widowed 
                string[] codes = new string[] { "", "A", "D", "I", "L", "M", "P", "S", "T", "W" };
                string[] displayNames = new string[] {"", "Annulled", "Divorced", "Interlocutory", "Legally Separated", "Married", "Polygamous", "Never Married", "Domestic Partner", "Widowed" };

                returnEntry.codeSystem = "2.16.840.1.113883.5.2";
                returnEntry.codeSystemName = "MaritalStatus";
                returnEntry.code = codes[(int)this.MaritalStatus];
                returnEntry.displayName = displayNames[(int)this.MaritalStatus]; 

                return returnEntry;
            }
        }

        private CE EthnicGroupEntry
        {
            get
            {
                CE returnEntry = new CE();

                //  Unknown, HispanicLatino, NonHispanicLatino
                string[] codes = new string[] {"", "2135-2","2186-5"};
                string[] displayNames = new string[] {"", "Hispanic Or Latino", "Not Hispanic Or Latino"};

                returnEntry.codeSystem = "2.16.840.1.113883.6.238";
                returnEntry.codeSystemName = "Race and Ethnicity - CDC";
                returnEntry.code = codes[(int)this.EthnicGroup];
                returnEntry.displayName = displayNames[(int)this.EthnicGroup];

                return returnEntry;
            }
        }

        private CE RaceEntry
        {
            get 
            {
                CE returnEntry = new CE();

                //  Unknown, AmericanIndian, Asian, AfricanAmerican, PacificIslander, White
                string[] codes = new string[] { "","1002-5" ,"2028-9","2054-5","2076-8","2106-3" };
                string[] displayNames = new string[] { "", "American Indian or Alaska Native", "Asian", "Black or African American", "Native Hawaiian or Other Pacific Islander", "White" };

                returnEntry.codeSystem = "2.16.840.1.113883.6.238";
                returnEntry.codeSystemName = "Race and Ethnicity - CDC";
                returnEntry.code = codes[(int)this.Race];
                returnEntry.displayName = displayNames[(int)this.Race];

                return returnEntry;
            }
        }
                

    }
}
