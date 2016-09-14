using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.CDA.Common;

namespace VA.Gov.Artemis.CDA.Observations
{
    /// <summary>
    /// Abstract simple observation
    /// </summary>
    public abstract class CdaSimpleObservation
    {
        public CdaTemplateIdList TemplateIds { get; set; }
        public string Id { get; set; }
        public CdaCode Code { get; set; }
        public bool NegationIndicator { get; set; }
        public Hl7ProblemActStatus Status { get; set; }
        public string Comment { get; set; }
        public Hl7FamilyMember Relationship { get; set; }
        public CdaEffectiveTime EffectiveTime { get; set; }
        public x_ActMoodDocumentObservation Mood { get; set; }

        protected abstract ANY[] BaseValue { get; }
        public abstract string DisplayValue { get; }

        public List<CdaSimpleObservation> SupportingObservations { get; set; }

        public CdaProviderAuthor Author { get; set; }

        public CdaReferenceRange ReferenceRange { get; set; }

        public string InterpretationCode { get; set; } 

        public CdaSimpleObservation()
        {
            this.TemplateIds = new CdaTemplateIdList("1.3.6.1.4.1.19376.1.5.3.1.4.13");
            this.EffectiveTime = new CdaEffectiveTime();
            this.Mood = x_ActMoodDocumentObservation.EVN;
            this.SupportingObservations = new List<CdaSimpleObservation>(); 
        }

        public CdaSimpleObservation(POCD_MT000040Observation pocdObs)
        {
            // *** Template Ids ***
            this.TemplateIds = new CdaTemplateIdList(pocdObs.templateId);

            // *** Observation Id ***
            if (pocdObs.id != null)
                if (pocdObs.id.Length > 0)
                    this.Id = pocdObs.id[0].root;

            // *** Code ***
            this.Code = CdaCode.FromPocd(pocdObs.code); 

            // *** Negation ***
            if (pocdObs.negationIndSpecified)
                this.NegationIndicator = pocdObs.negationInd; 
            
            // *** Status ***
            if (pocdObs.statusCode != null)
            {
                Hl7ProblemActStatus stat = Hl7ProblemActStatus.unknown;

                if (Enum.TryParse<Hl7ProblemActStatus>(pocdObs.statusCode.code, out stat))
                    this.Status = stat;
            }

            // *** Effective Time ***
            if (pocdObs.effectiveTime != null) 
                this.EffectiveTime = CdaEffectiveTime.FromPocd(pocdObs.effectiveTime);

            this.Mood = x_ActMoodDocumentObservation.EVN; 
        }

        public string ReferenceId
        {
            get
            {
                return string.Format("obs-{0}", this.Id);
            }
        }

        public POCD_MT000040Observation ToPocd()
        {
            POCD_MT000040Observation returnObservation = new POCD_MT000040Observation();

            // *** Elements that are the same for all ***
            returnObservation.classCode = "OBS";
            returnObservation.moodCode = this.Mood;

            returnObservation.templateId = this.TemplateIds.ToPocd();

            // *** Actual data from observation ***
            if (this.NegationIndicator)
            {
                returnObservation.negationInd = this.NegationIndicator;
                returnObservation.negationIndSpecified = true;
            }

            returnObservation.id = new II[] { new II() { root = this.Id } };
            returnObservation.code = this.Code.ToCE();
            returnObservation.text = new ED() { reference = new TEL() { value = string.Format("#{0}", this.ReferenceId) } };
            returnObservation.statusCode = new CS() { code = this.Status.ToString() };
            returnObservation.effectiveTime = this.EffectiveTime.ToIvlTs(); //new IVL_TS() { value = this.EffectiveTime.ToString(RawCdaDocument.CdaDateFormat) };
            returnObservation.value = this.BaseValue; 

            // *** Supporting Observations ***
            if (this.SupportingObservations != null)
                if (this.SupportingObservations.Count > 0)
                {
                    List<POCD_MT000040EntryRelationship> relList = new List<POCD_MT000040EntryRelationship>();

                    foreach (var item in this.SupportingObservations)
                    {
                        POCD_MT000040EntryRelationship rel = new POCD_MT000040EntryRelationship();

                        rel.typeCode = x_ActRelationshipEntryRelationship.SPRT;

                        rel.Item = item.ToPocd();

                        relList.Add(rel);
                    }

                    returnObservation.entryRelationship = relList.ToArray();
                }

            if (this.Author != null)
                returnObservation.author = new POCD_MT000040Author[] { this.Author.ToPocdAuthor() };

            if (this.ReferenceRange != null)
                returnObservation.referenceRange = new POCD_MT000040ReferenceRange[] {this.ReferenceRange.ToPocd()};

            if (!string.IsNullOrWhiteSpace(this.InterpretationCode))
                returnObservation.interpretationCode = new CE[] { new CE { 
                    code = this.InterpretationCode, 
                    codeSystem = "2.16.840.1.113883.5.83", 
                    codeSystemName = "ObservationInterpretation" 
                } }; 

            return returnObservation;
        }               
    }
}
