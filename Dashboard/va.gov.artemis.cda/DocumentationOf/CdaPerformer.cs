// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.CDA.Common;

namespace VA.Gov.Artemis.CDA.DocumentationOf
{
    public class CdaPerformer
    {
        public CdaPerformer()
        {
            this.Address = new CdaAddress();
            this.WorkPhone = new CdaTelephone() { Usage = Hl7TelephoneUsage.WorkPlace };
            this.Npi = new CdaNpi();
            this.Provider = new CdaPerson();
        }

        public string[] Hl7ParticipationFunctionCode = new string[]{"", "ADMPHYS", "ANEST", "ANRS", "ATTPHYS", "DISPHYS", "FASST", 
                                                                    "MDWF", "NASST", "PCP", "PRISURG", "RNDPHYS", "SASST", "SNRS", "TASST"}; 
        /// <summary>
        /// The function code is defined as ParticipationFunction (2.16.840.1.113883.5.88) 
        /// </summary>
        public Hl7ParticipationFunction FunctionCode { get; set; }

        public CdaNpi Npi { get; set; }
        public CdaAddress Address { get; set; }
        public CdaTelephone WorkPhone { get; set; }

        public CdaPerson Provider { get; set; }

        /// <summary>
        /// Returns a CDA Performer object
        /// </summary>
        public POCD_MT000040Performer1 ToPocdPerformer()
        {
            POCD_MT000040Performer1 returnVal = new POCD_MT000040Performer1();

            if (this.FunctionCode != Hl7ParticipationFunction.Unknown)
            {
                returnVal.functionCode = new CE()
                {
                    codeSystem = "2.16.840.1.113883.5.88",
                    codeSystemName = "ParticipationFunction",
                    code = Hl7ParticipationFunctionCode[(int)this.FunctionCode]
                };
            }

            returnVal.assignedEntity = new POCD_MT000040AssignedEntity();

            returnVal.assignedEntity.id = this.Npi.ToIIArray();
            returnVal.assignedEntity.addr = new AD[]{this.Address.ToAD()};
            returnVal.assignedEntity.telecom = new TEL[]{this.WorkPhone.ToTEL()};

            returnVal.assignedEntity.assignedPerson = this.Provider.ToPocdPerson(); 

            return returnVal; 
        }


    }
}
