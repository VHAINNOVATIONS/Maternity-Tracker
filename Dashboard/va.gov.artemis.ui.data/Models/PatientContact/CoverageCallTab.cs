// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.UI.Data.Models.NonVACare;

namespace VA.Gov.Artemis.UI.Data.Models.PatientContact
{
    public class CoverageCallTab: CallTabBase
    {
        public const string AuthorizationReceivedKey = "COVER.AUTH";
        public const string LetterReceivedKey = "COVER.LETTER";
        public const string PurpleBookReceivedKey = "COVER.PURPLEBOOK";
        public const string LocatedOBKey = "COVER.LOCATEDOB";
        public const string ExistingObKey = "COVER.EXOB";
        public const string ExistingObIenKey = "COVER.EXOBIEN"; 
        public const string LocatedHospitalKey = "COVER.LOCATEDHOSP";
        public const string ExistingHospitalKey = "COVER.EXHOSP";
        public const string ExistingHospitalIenKey = "COVER.EXHOSPIEN";
        public const string WrittenVaAuthorizationKey = "COVER.WRITTENVA";
        public const string RoutinePrenatalCareKey = "COVER.PRENATAL";
        public const string VerifyCoverageKey = "COVER.VERIFYCOVERAGE";
        public const string EmergencyKey = "COVER.EMERGENCY";
        public const string ObtainingMedsKey = "COVER.OBTAINMEDS";
        public const string VANewbornCoverageKey = "COVER.NEWBORNCOVERAGE";
        public const string VADieticianKey = "COVER.DIETICIAN";
        public const string TubalLigationTopicKey = "COVER.TUBALLIGATION";
        public const string InterestedInTubalLigationKey = "COVER.INTERESTINTL";
        public const string InterestedInIudKey = "COVER.INTERESTEDINIUD";
        public const string NonVAMaternityBillKey = "COVER.BILL";
        public const string RemindToCarryKey = "COVER.REMINDTOCARRY"; 
        public const string ExplainBillProcessKey = "COVER.EXPLAINBILL"; 
        public const string BenefitsProblemsKey = "COVER.BENEPROBS"; 
        public const string TlIudFollowUpKey = "COVER.TLFOLLOWUP"; 
        
        public bool AuthorizationReceived { get; set; }
        public bool LetterReceived { get; set; }
        public bool PurpleBookReceived { get; set; }

        public Nullable<bool> LocatedOB { get; set; }
        public Nullable<bool> CreateNewOb { get; set; } // *** Not saved ***
        public string ExistingObIen { get; set; }
        public string ExistingObName { get; set; }
        public NonVACareItem NewOb { get; set; } // *** Saved separately - not part of discrete data ***
        
        public Nullable<bool> LocatedHospital { get; set; }
        public Nullable<bool> CreateNewHospital { get; set; } // *** Not saved ***
        public string ExistingHospitalIen { get; set; }
        public string ExistingHospitalName { get; set; }
        public NonVACareItem NewHospital { get; set; }
        
        public bool WrittenVaAuthorization { get; set; }
        public bool RoutinePrenatalCare { get; set; }
        public bool VerifyCoverage { get; set; }
        public bool Emergency { get; set; }
        public bool ObtainingMeds { get; set; }
        public bool VANewbornCoverage { get; set; }
        public bool VADietician { get; set; }
        public bool TubalLigationTopic { get; set; }
        public Nullable<bool> InterestedInTubalLigation { get; set; }
        public Nullable<bool> InterestedInIud { get; set; }
        public bool NonVAMaternityBill { get; set; }

        public bool RemindToCarry { get; set; }
        public bool ExplainBillProcess { get; set; }
        public bool BenefitsProblems { get; set; }
        public bool TlIudFollowUp { get; set; }

        public CoverageCallTab()
        {
            this.NewOb = new NonVACareItem() { ItemType = NonVACareItemType.Provider };
            this.NewHospital = new NonVACareItem() { ItemType = NonVACareItemType.Facility }; 
        }

        public static CoverageCallTab FromBase(CallTabBase tabBase)
        {
            CoverageCallTab returnVal = new CoverageCallTab();

            returnVal.CopyBase(tabBase);

            return returnVal;
        }

        public override void AddDataElement(string key, string value)
        {
            bool val;

            Nullable<bool> nullBool = null; 

            key = key.ToUpper();

            if (bool.TryParse(value, out val))
                nullBool = val; 

            switch (key)
            {
                case AuthorizationReceivedKey:
                    this.AuthorizationReceived = val;
                    break; 
                case LetterReceivedKey:
                    this.LetterReceived = val;
                    break; 
                case PurpleBookReceivedKey:
                    this.PurpleBookReceived = val;
                    break; 
                case LocatedOBKey:
                    this.LocatedOB = nullBool;
                    break; 
                case ExistingObKey:
                    this.ExistingObName = value; 
                    break; 
                case ExistingObIenKey:
                    this.ExistingObIen = value;
                    break; 
                case LocatedHospitalKey:
                    this.LocatedHospital = nullBool;
                    break; 
                case ExistingHospitalKey:
                    this.ExistingHospitalName = value; 
                    break; 
                case ExistingHospitalIenKey:
                    this.ExistingHospitalIen = value;
                    break; 
                case WrittenVaAuthorizationKey:
                    this.WrittenVaAuthorization = val;
                    break; 
                case RoutinePrenatalCareKey:
                    this.RoutinePrenatalCare = val;
                    break; 
                case VerifyCoverageKey:
                    this.VerifyCoverage = val;
                    break; 
                case EmergencyKey:
                    this.Emergency = val;
                    break; 
                case ObtainingMedsKey:
                    this.ObtainingMeds = val;
                    break; 
                case VANewbornCoverageKey:
                    this.VANewbornCoverage = val;
                    break; 
                case VADieticianKey:
                    this.VADietician = val;
                    break; 
                case TubalLigationTopicKey:
                    this.TubalLigationTopic = val;
                    break; 
                case InterestedInTubalLigationKey:
                    this.InterestedInTubalLigation = nullBool;
                    break; 
                case InterestedInIudKey:
                    this.InterestedInIud = nullBool;
                    break; 
                case NonVAMaternityBillKey:
                    this.NonVAMaternityBill = val;
                    break; 
                case RemindToCarryKey: 
                    this.RemindToCarry = val; 
                    break; 
                case ExplainBillProcessKey: 
                    this.ExplainBillProcess = val; 
                    break; 
                case BenefitsProblemsKey:
                    this.BenefitsProblems = val; 
                    break; 
                case TlIudFollowUpKey:
                    this.TlIudFollowUp = val; 
                    break; 
            }
        }

        public override Dictionary<string, string> GetTabDataElements()
        {
            Dictionary<string, string> returnDictionary = new Dictionary<string, string>();

            returnDictionary.Add(AuthorizationReceivedKey, this.AuthorizationReceived.ToString());
            returnDictionary.Add(LetterReceivedKey, this.LetterReceived.ToString());
            returnDictionary.Add(PurpleBookReceivedKey, this.PurpleBookReceived.ToString());
            returnDictionary.Add(LocatedOBKey, this.LocatedOB.ToString());
            returnDictionary.Add(ExistingObKey, this.ExistingObName);
            returnDictionary.Add(ExistingObIenKey, this.ExistingObIen); 
            returnDictionary.Add(LocatedHospitalKey, this.LocatedHospital.ToString());
            returnDictionary.Add(ExistingHospitalKey, this.ExistingHospitalName);
            returnDictionary.Add(ExistingHospitalIenKey, this.ExistingHospitalIen);
            returnDictionary.Add(WrittenVaAuthorizationKey, this.WrittenVaAuthorization.ToString());
            returnDictionary.Add(RoutinePrenatalCareKey, this.RoutinePrenatalCare.ToString());
            returnDictionary.Add(VerifyCoverageKey, this.VerifyCoverage.ToString());
            returnDictionary.Add(EmergencyKey, this.Emergency.ToString());
            returnDictionary.Add(ObtainingMedsKey, this.ObtainingMeds.ToString());
            returnDictionary.Add(VANewbornCoverageKey, this.VANewbornCoverage.ToString());
            returnDictionary.Add(VADieticianKey, this.VADietician.ToString());
            returnDictionary.Add(TubalLigationTopicKey, this.TubalLigationTopic.ToString());
            returnDictionary.Add(InterestedInTubalLigationKey, this.InterestedInTubalLigation.ToString());
            returnDictionary.Add(InterestedInIudKey, this.InterestedInIud.ToString());
            returnDictionary.Add(NonVAMaternityBillKey, this.NonVAMaternityBill.ToString()); 
            returnDictionary.Add(RemindToCarryKey, this.RemindToCarry.ToString()); 
            returnDictionary.Add(ExplainBillProcessKey, this.ExplainBillProcess.ToString()); 
            returnDictionary.Add(BenefitsProblemsKey, this.BenefitsProblems.ToString()); 
            returnDictionary.Add(TlIudFollowUpKey, this.TlIudFollowUp.ToString()); 

            return returnDictionary; 
        }

        public override string GetNoteText()
        {
            StringBuilder sb = new StringBuilder(); 

            if (this.AnyValues())
            {
                sb.AppendLine("Coverage");

                sb.AppendLine();

                if (this.AuthorizationReceived)
                    sb.AppendLine("Patient received VA Authorization for Maternity Benefits");

                if (this.LetterReceived)
                    sb.AppendLine("Patient received letter describing benefits");

                if (this.PurpleBookReceived)
                    sb.AppendLine("Patient received purple book");

                if (this.LocatedOB.HasValue)
                    if (this.LocatedOB.Value == true)
                        sb.AppendLine("Patient has identified a prenatal care provider");
                    else
                        sb.AppendLine("Patient has NOT identified a prenatal care provider");

                if (!string.IsNullOrWhiteSpace(this.ExistingObIen))
                    sb.AppendLine("Identified Obstetrician: " + this.ExistingObName);

                if (this.LocatedHospital.HasValue)
                    if (this.LocatedHospital.Value)
                        sb.AppendLine("Patient has identified a planned delivery facility"); 
                    else
                        sb.AppendLine("Patient has NOT identified a planned delivery facility");

                if (!string.IsNullOrWhiteSpace(this.ExistingHospitalIen))
                    sb.AppendLine("Planned Delivery Facility: " + this.ExistingHospitalName);

                if (this.WrittenVaAuthorization)
                    sb.AppendLine("Reviewed Benefit: Written VA authorization for maternity benefits = insurance card");

                if (this.RoutinePrenatalCare)
                    sb.AppendLine("Reviewed Benefit: Routine Prenatal Care");

                if (this.VerifyCoverage)
                    sb.AppendLine("Reviewed Benefit: If OB refers for additional care, verify coverage with MCC or VA first");

                if (this.Emergency)
                    sb.AppendLine("Reviewed Benefit: If emergency, go to nearest ER");

                if (this.ObtainingMeds)
                    sb.AppendLine("Discussed: Obtaining medications and medical supplies from VA");

                if (this.VANewbornCoverage)
                    sb.AppendLine("Discussed: VA newborn care coverage and obtaining non-VA newborn health insurance coverage");

                if (this.VADietician)
                    sb.AppendLine("Discussed: VA-provided dietician & weight management and Non-VA pregnancy-related classes");

                if (this.TubalLigationTopic)
                    sb.AppendLine("Discussed patient interest in Tubal Ligation and IUD");

                if (this.InterestedInTubalLigation.HasValue)
                    if (this.InterestedInTubalLigation.Value)
                        sb.AppendLine("Patient is interested in Tubal Ligation");
                    else
                        sb.AppendLine("Patient is NOT interested in Tubal Ligation");

                if (this.InterestedInIud.HasValue)
                    if (this.InterestedInIud.Value)
                        sb.AppendLine("Patient is interested in Intrauterine Device");
                    else
                        sb.AppendLine("Patient is NOT interested in Intrauterine Device");

                if (this.NonVAMaternityBill)
                    sb.AppendLine("Discussed patient response to receiving a bill from Non-VA Maternity Care provider");

                if (this.RemindToCarry)
                    sb.AppendLine("Reminded patient to carry VA Authorization papers like an insurance card");

                if (this.ExplainBillProcess)
                    sb.AppendLine("Described local processes for correcting situation when patient receives bill");

                if (this.BenefitsProblems)
                    sb.AppendLine("Asked about questions or problems with VA maternity care benefits, help problem-solve");

                if (this.TlIudFollowUp)
                    sb.AppendLine("Asked if patient had the opportunity to discuss IUD with OB"); 

                sb.AppendLine(); 
            }

            return sb.ToString();
        }

        protected override bool AnyValues()
        {
            bool returnVal = false;

            if (this.AuthorizationReceived ||
                this.LetterReceived ||
                this.PurpleBookReceived ||
                this.LocatedOB.HasValue || 
                (!string.IsNullOrWhiteSpace(this.ExistingObIen)) ||
                this.LocatedHospital.HasValue || 
                (!string.IsNullOrWhiteSpace(this.ExistingHospitalIen)) ||
                this.WrittenVaAuthorization ||
                this.RoutinePrenatalCare ||
                this.VerifyCoverage ||
                this.Emergency ||
                this.ObtainingMeds ||
                this.VANewbornCoverage ||
                this.VADietician ||
                this.TubalLigationTopic ||
                this.InterestedInTubalLigation.HasValue ||
                this.InterestedInIud.HasValue ||
                this.NonVAMaternityBill ||
                this.RemindToCarry ||
                this.ExplainBillProcess ||
                this.BenefitsProblems ||
                this.TlIudFollowUp)
                returnVal = true; 

            return returnVal; 
        }
    }
}
