using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.CDA.Common
{
    public class CdaCode
    {
        public const string LoincSystemId = "2.16.840.1.113883.6.1";
        public const string SnomedCtSystemId = "2.16.840.1.113883.6.96";
        public const string VhaSystemId = "2.16.840.1.113883.6.233";
        public const string Icd9SystemId = "2.16.840.1.113883.6.103";

        public const string LoincSystemName = "LOINC";
        public const string SnomedCtSystemName = "Snomed-CT";
        public const string VhaSystemName = "VHA";
        public const string Icd9SystemName = "ICD-9CM";

        public CodingSystem CodeSystem { get; set; }
        public string Code { get; set; }
        public string DisplayName { get; set; }
        public string Reference { get; set; }

        public CdaCode()
        {
            this.DisplayName = ""; 
        }

        public static CdaCode FromPocd(CD cd) 
        {
            CdaCode returnVal = new CdaCode() { DisplayName = "" };

            if (cd != null)
            {
                returnVal.Code = cd.code;
                returnVal.DisplayName = cd.displayName;
                if (string.Equals(cd.codeSystemName, LoincSystemName, StringComparison.CurrentCultureIgnoreCase))
                    returnVal.CodeSystem = CodingSystem.Loinc;
                else if (string.Equals(cd.codeSystemName, SnomedCtSystemName, StringComparison.CurrentCultureIgnoreCase))
                    returnVal.CodeSystem = CodingSystem.SnomedCT;
                else if (string.Equals(cd.codeSystemName, VhaSystemName, StringComparison.CurrentCultureIgnoreCase))
                    returnVal.CodeSystem = CodingSystem.Vha;
                else if (string.Equals(cd.codeSystemName, Icd9SystemName, StringComparison.CurrentCultureIgnoreCase))
                    returnVal.CodeSystem = CodingSystem.Icd9;
                else
                    returnVal.CodeSystem = CodingSystem.Other; 
            }

            return returnVal; 
        }

        public CD ToCD()
        {
            CD returnVal = new CD()
            {
                code = this.Code,
                displayName = this.DisplayName
            };

            switch (this.CodeSystem)
            {
                case CodingSystem.Loinc:
                    returnVal.codeSystem = LoincSystemId;
                    returnVal.codeSystemName = LoincSystemName;
                    break;

                case CodingSystem.SnomedCT:
                    returnVal.codeSystem = SnomedCtSystemId;
                    returnVal.codeSystemName = SnomedCtSystemName;
                    break;
                
                case CodingSystem.Vha:
                    returnVal.codeSystem = VhaSystemId;
                    returnVal.codeSystemName = VhaSystemName;
                    break;

                case CodingSystem.Icd9:
                    returnVal.codeSystem = Icd9SystemId;
                    returnVal.codeSystemName = Icd9SystemName;
                    break; 
            }

            return returnVal; 
        }

        public CE ToCE()
        {
            CE returnVal = new CE()
            {
                code = this.Code,
                displayName = this.DisplayName
            };

            switch (this.CodeSystem)
            {
                case CodingSystem.Loinc:
                    returnVal.codeSystem = LoincSystemId;
                    returnVal.codeSystemName = LoincSystemName;
                    break;
                case CodingSystem.SnomedCT:
                    returnVal.codeSystem = SnomedCtSystemId;
                    returnVal.codeSystemName = SnomedCtSystemName;
                    break;

                case CodingSystem.Vha:
                    returnVal.codeSystem = VhaSystemId;
                    returnVal.codeSystemName = VhaSystemName;
                    break;

                case CodingSystem.Icd9:
                    returnVal.codeSystem = Icd9SystemId;
                    returnVal.codeSystemName = Icd9SystemName;
                    break; 
            }

            if (!string.IsNullOrWhiteSpace(this.Reference))
                returnVal.originalText = new ED() { reference = new TEL() { value = this.Reference } };

            return returnVal;
        }
    }
}
