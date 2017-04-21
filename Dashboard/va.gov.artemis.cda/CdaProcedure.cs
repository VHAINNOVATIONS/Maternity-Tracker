// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.CDA.Common;

namespace VA.Gov.Artemis.CDA
{
    public class CdaProcedure
    {
        public string Id { get; set; }
        public CdaCode Code { get; set; }
        public CdaEffectiveTime EffectiveTime { get; set; }
        
        public CdaProcedure(DateTime dateTime, CodingSystem codingSystem, string code, string displayName)
        {
            this.Id = Guid.NewGuid().ToString(); 
            this.EffectiveTime = new CdaEffectiveTime() { High = dateTime };
            this.Code = new CdaCode() { CodeSystem = codingSystem, Code = code, DisplayName = displayName }; 
        }

        public CdaProcedure(POCD_MT000040Procedure pocdProcedure)
        {
            if (pocdProcedure.id != null) 
                if (pocdProcedure.id.Length > 0)
                    this.Id = pocdProcedure.id[0].root;

            this.Code = CdaCode.FromPocd(pocdProcedure.code);

            this.EffectiveTime = CdaEffectiveTime.FromPocd(pocdProcedure.effectiveTime);
        }

        public string ReferenceId
        {
            get
            {
                return string.Format("obs-{0}", this.Id);
            }
        }

        public POCD_MT000040Procedure ToPocd()
        {
            POCD_MT000040Procedure returnVal = new POCD_MT000040Procedure();

//<procedure classCode='PROC' moodCode='EVN|INT'> 3880
//<templateId root='1.3.6.1.4.1.19376.1.5.3.1.4.19'/>
//<templateId root='2.16.840.1.113883.10.20.1.29'/><!-- see text of section 0 -->
//<templateId root='2.16.840.1.113883.10.20.1.25'/><!-- see text of section 0 -->
//<id root='' extension=''/>
//<code code='' codeSystem='2.16.840.1.113883.5.4' codeSystemName='ActCode' /> 3885
//<text><reference value='#xxx'/></text>
//<statusCode code='completed|active|aborted|cancelled'/>
//<effectiveTime>
//<low value=''/>
//<high value=''/> 3890
//</effectiveTime>
//<priorityCode code=''/>
//<approachSiteCode code='' displayName='' codeSystem='' codeSystemName=''/>
//<targetSiteCode code='' displayName='' codeSystem='' codeSystemName=''/>
//<author /> 3895
//<informant />
//<entryRelationship typeCode='COMP' inversionInd='true'>
//<act classCode='ACT' moodCode=''>
//<templateId root='1.3.6.1.4.1.19376.1.5.3.1.4.4.1'/>
//<id root='' extension=''/> 3900
//</act>
//</entryRelationship>
//<entryRelationship typeCode='RSON'>
//<act classCode='ACT' moodCode='EVN'>
//<templateId root='1.3.6.1.4.1.19376.1.5.3.1.4.4.1'/> 3905
//<id root='' extension=''/>
//</act>
//</entryRelationship>
//</procedure>

            returnVal.classCode = "PROC"; 

            CdaTemplateIdList templateIds = new CdaTemplateIdList(
                "1.3.6.1.4.1.19376.1.5.3.1.4.19",
                "2.16.840.1.113883.10.20.1.29"
                );

            returnVal.moodCode = x_DocumentProcedureMood.EVN;

            returnVal.templateId = templateIds.ToPocd(); 

            returnVal.id = new II[] { new II() { root = this.Id } };

            returnVal.code = this.Code.ToCE();

            returnVal.text = new ED() { reference = new TEL() { value = string.Format("#{0}", this.ReferenceId) } };

            returnVal.statusCode = new CS() { code = "completed" };
            returnVal.effectiveTime = this.EffectiveTime.ToIvlTs(); 

            return returnVal; 
        }
    }
}
