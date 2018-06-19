// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.Commands.Dsio.Pregnancy
{
    /// <summary>
    /// A command to save pregnancy details to VistA
    /// </summary>
    public class DsioSavePregDetailsCommand: DsioCommand 
    {
        /// <summary>
        /// Creates the command
        /// </summary>
        /// <param name="newBroker">An object which allows communication with VistA and implements IRpcBroker</param>
        public DsioSavePregDetailsCommand(IRpcBroker newBroker): base(newBroker){}

        /// <summary>
        /// The Ien of the person, either created or updated
        /// </summary>
        public string Ien { get; set; }

        public string BabyIen { get; set; }
        public string BabyNumber { get; set; }

        /// <summary>
        /// The name of the RPC
        /// </summary>
        public override string RpcName
        {
            get { return "WEBM SAVE PREG DETAILS"; }
        }

//;    DFN = PATIENT IEN
//;    IEN = IF NOT NULL THEN EDIT
//;  DATES = START^END^EDD
//;    TYP = C(urrent),H(istorical)
//;    FOF = IEN, U(nspecified), S(pouse)
//;    OBP = OB (VARIABLE POINTER)
//;          NVA.IEN (NON-VA) (19641.1)
//;           VA.IEN (VA) (200)
//;    FAP = FACILITY (VARIABLE POINTER)
//;          NVA.IEN (NON-VA) (19641.1)
//;           VA.IEN (VA) (4)
//;    BAB = NUMBER
//;            IF 1,2,3 THEN THREE BABIES WILL BE ADDED
//;            IF 1,2@,3 THEN BABY 2 WILL BE DELETED
//;   POST = ADDITIONAL DETAILS (CARET DELIMITED STRING)
//;            1: GESTATIONAL AGE AT DELIVERY (NUMBER 0 - 99)
//;            2: LENGTH OF LABOR (NUMBER (IN HOURS))
//;            3: TYPE OF DELIVERY (TEXT 1-20 CHARACTERS)
//;            4: EPIDERAL/SPINAL (0 (NO), 1 (YES))
//;            5: PRETERM LABOR (0 (NO), 1 (YES))
//;    COM = COMMENTS (ARRAY OF TEXT)


//Input: IEN,DFN,DATES,TYP,FOF,OBP,FAP,BAB,POST,COM,HRD
//; CREATE, UPDATE, or DELETE a PREGNANCY HISTORY record
//;
//;    DFN = PATIENT IEN
//;    IEN = If not null then edit unless ###@ then delete
//;  DATES = EDC^END^EDD
//;    TYP = C(urrent),H(istorical)
//;    FOF = IEN, U(nspecified), S(pouse)
//;    OBP = OB (VARIABLE POINTER)
//;          NVA.IEN (NON-VA) (19641.1)
//;           VA.IEN (VA) (200)
//;    FAP = FACILITY (VARIABLE POINTER)
//;          NVA.IEN (NON-VA) (19641.1)
//;           VA.IEN (VA) (4)
//;    BAB = NUMBER
//;            IF 1,2,3 THEN THREE BABIES WILL BE ADDED
//;            IF 1,2@,3 THEN BABY 2 WILL BE DELETED
//;            *** + is the next number.
//;   POST = ADDITIONAL DETAILS (CARET DELIMITED STRING)
//;            1: GESTATIONAL AGE AT DELIVERY (NUMBER 0 - 99)
//;            2: LENGTH OF LABOR (NUMBER (IN HOURS))
//;            3: TYPE OF DELIVERY (TEXT 1-20 CHARACTERS)
//;            4: EPIDURAL/SPINAL (0:NO,1:YES)
//;            5: PRETERM LABOR (0:NO,1:YES)
//;            6: COMPLICATION (E:ECTOPICS,AI:AB. INDUCED,AS:AB. SPONTANEOUS)
//;            7: HIGH RISK FLAG (0:FALSE,1:TRUE)
//;    COM = COMMENTS (ARRAY of Text)
//;    HRD = HIGH RISK DESCRIPTION (ARRAY of Text)

// New Version 2/17/16..
//        PREG(RET,IEN,DFN,DATES,TYP,FOF,OBP,FAP,BAB,POST,COM,HRD,AB) ; RPC: WEBM SAVE PREG DETAILS
//;
//; CREATE, UPDATE, or DELETE a PREGNANCY HISTORY record
//;
//;    IEN = If not null then edit unless ###@ then delete
//;    DFN = PATIENT IEN
//;  DATES = EDC^END^EDD
//;    TYP = C(urrent),H(istorical)
//;    FOF = IEN, U(nspecified), S(pouse)
//;    OBP = OB (VARIABLE POINTER)
//;          NVA.IEN (NON-VA) (19641.1)
//;           VA.IEN (VA) (200)
//;    FAP = FACILITY (VARIABLE POINTER)
//;          NVA.IEN (NON-VA) (19641.1)
//;           VA.IEN (VA) (4)
//;    BAB = NUMBER
//;            IF 1,2,3 THEN THREE BABIES WILL BE ADDED
//;            IF 1,2@,3 THEN BABY 2 WILL BE DELETED
//;            *** + is the next number.
//;   POST = ADDITIONAL DETAILS (CARET DELIMITED STRING)
//;            1: GESTATIONAL AGE (#W#D)
//;            2: LENGTH OF LABOR (NUMBER (IN HOURS))
//;            3: TYPE OF DELIVERY (TEXT 1-20 CHARACTERS)
//;            4: ANESTHESIA
//;            5: PRETERM DELIVERY (0:NO,1:YES)
//;            6: OUTCOME (E:ECTOPICS,AI:TERMINATION,AS:SPONTANEOUS ABORTION,
//;                        S:STILLBIRTH,F:FULL TERM,U:UNKNOWN,P:PRETERM)
//;            7: HIGH RISK FLAG (0:FALSE,1:TRUE)
//;    COM = COMMENTS (ARRAY of Text)
//;    HRD = HIGH RISK DESCRIPTION (ARRAY of Text)


        /// <summary>
        /// Add command arguments to the RPC call. 
        /// Call prior to calling "Execute"
        /// </summary>
        /// <param name="pregnancy"></param>
        public void AddCommandArguments(DsioPregnancy pregnancy, bool addBaby)
        {
            string dates = string.Format("{0}^{1}^{2}", pregnancy.StartDate, pregnancy.EndDate, pregnancy.EDD); 

            // *** Create baby parameter ***            
            string babyParam = (addBaby) ? "+" : "";

            string ob = (string.IsNullOrWhiteSpace(pregnancy.ObstetricianIen)) ? "" : string.Format("NVA.{0}", pregnancy.ObstetricianIen);
            string fac = (string.IsNullOrWhiteSpace(pregnancy.LDFacilityIen)) ? "" : string.Format("NVA.{0}", pregnancy.LDFacilityIen);

            string post = string.Format("{0}^{1}^{2}^{3}^{4}^{5}^{6}", 
                pregnancy.GestationalAgeAtDelivery, 
                pregnancy.LengthOfLabor, 
                pregnancy.TypeOfDelivery, 
                pregnancy.Anesthesia, 
                pregnancy.PretermDelivery, 
                pregnancy.Outcome, 
                pregnancy.HighRisk);

            string[] comments = Util.MakeVistAStringArray(pregnancy.Comment); 

            string[] highRiskDetails = Util.MakeVistAStringArray(pregnancy.HighRiskDetails); 

            this.CommandArgs = new object[]{                
                pregnancy.Ien, 
                pregnancy.PatientDfn, 
                dates,
                pregnancy.RecordType, 
                pregnancy.FatherOfFetusIen, 
                ob, 
                fac, 
                babyParam, 
                post, 
                comments,
                highRiskDetails
            };
        }

        protected override void ProcessResponse()
        {
            if (this.ProcessSaveResponse())
            {
                this.Ien = Util.Piece(this.Response.Lines[0], Caret, 1);
                string baby = Util.Piece(this.Response.Lines[0], Caret, 2);

                if (!string.IsNullOrWhiteSpace(baby))
                {
                    this.BabyIen = Util.Piece(baby, ";", 1);
                    this.BabyNumber = Util.Piece(baby, ";", 2);
                }

                this.Response.Status = RpcResponseStatus.Success;
            }
        }

    }
}
