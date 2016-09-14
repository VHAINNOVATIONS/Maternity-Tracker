using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.CDA.Common;

namespace VA.Gov.Artemis.CDA.RecordTarget
{
    public class CdaLanguage
    {
        public Hl7LanguageCode Code { get; set; }
        public Hl7LanguageAbility Ability { get; set; }
        public Hl7LanguageProficiency Proficiency { get; set; }
    }
}
