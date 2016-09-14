using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.CDA.Common
{
    /// <summary>
    /// A simple CDA object to represent gender
    /// </summary>
    public class CdaGender
    {
        public Hl7Gender Value { get; set; }

        public CdaGender() {}

        public CdaGender(string val)
        {
            Hl7Gender gender = Hl7Gender.Unknown;

            if (Enum.TryParse<Hl7Gender>(val, out gender))
                this.Value = gender; 
        }

        public CE ToCE()
        {
            CE returnEntry = new CE();

            //Unknown, Male, Female, Undifferentiated
            string[] codes = new string[] { "", "M", "F", "UN" };

            returnEntry.code = codes[(int)this.Value];
            returnEntry.codeSystem = "2.16.840.1.113883.5.1";
            returnEntry.codeSystemName = "HL7AdministrativeGender";

            if (this.Value == Hl7Gender.Unknown)
                returnEntry.nullFlavor = "UNK"; 

            return returnEntry;
        }
    }
}
