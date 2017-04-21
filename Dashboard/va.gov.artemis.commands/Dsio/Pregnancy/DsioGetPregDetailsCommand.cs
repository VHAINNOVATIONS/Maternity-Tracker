// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.Commands.Dsio.Pregnancy
{
    /// <summary>
    /// A command which retrieves pregnancy details from VistA
    /// </summary>
    public class DsioGetPregDetailsCommand: DsioPagableCommand
    {
        /// <summary>
        /// Creates the command
        /// </summary>
        /// <param name="newBroker">An object which allows communication with VistA and implements IRpcBroker</param>
        public DsioGetPregDetailsCommand(IRpcBroker newBroker): base(newBroker) {}

        /// <summary>
        /// The list of pregnancy details returned by the RPC
        /// </summary>
        public List<DsioPregnancy> PregnancyList
        {
            get
            {
                List<DsioPregnancy> returnList = new List<DsioPregnancy>();

                if (this.pregList != null)
                    returnList = this.pregList.Values.ToList();

                return returnList; 
            }
        }

        // *** Pregnancy information, keyed by IEN ***
        private Dictionary<string, DsioPregnancy> pregList { get; set; }

        /// <summary>
        /// The command arguments passed into the RPC 
        /// </summary>
        /// <param name="patientDfn"></param>
        /// <param name="pregnancyIen"></param>
        public void AddCommandArguments(string patientDfn, string pregnancyIen)
        {
            this.CommandArgs = new object[] { pregnancyIen, patientDfn };
        }

        /// <summary>
        /// The name of the RPC
        /// </summary>
        public override string RpcName
        {
            get { return "DSIO GET PREG DETAILS"; }
        }

        protected override void ProcessLine(string line)
        {
            // *** Create a pregnancy detail object ***

            DsioPregnancy preg = new DsioPregnancy();

            // *** Commented out pieces not needed at this time ***

            // TODO: Implement additional data...

            //;  L^IEN^DATE RECORDED^EDC^DFN|PATIENT^STATUS^FOF|(IEN OR IDENTIFIER)^
            //;    EDD^PREGNANCY END^OB IEN|OB^FACILITY IEN|FACILITY^
            //;    UPDATED BY IEN|UPDATED BY^GESTATIONAL AGE AT DELIVERY^LENGTH OF DELIVERY^
            //;    EPIDERAL/SPINAL^PRETERM LABOR^BIRTH TYPE^IEN;BABY |IEN;BABY
            //;  C^IEN^COMMENT

            // L^26^05/22/2015@11:23:57^^126|Azdhshts,Jxaalshula^CURRENT^Unspecified|u^^^|^|^10000000052|Cprsnurse,One^^^^^^NONE^

            //10/12/2015
            //Input: IEN,DFN,SORT

            //; If IEN = "C" get only the CURRENT pregnancy
            //;
            //; RETURN:
            //;  L^IEN^DATE RECORDED^EDC^DFN|PATIENT^STATUS^FOF|(IEN OR IDENTIFIER)^
            //;    EDD^PREGNANCY END^OB IEN|OB^FACILITY IEN|FACILITY^
            //;    UPDATED BY IEN|UPDATED BY^GESTATIONAL AGE AT DELIVERY^LENGTH OF DELIVERY^
            //;    TYPE OF DELIVERY^EPIDERAL/SPINAL^PRETERM LABOR^BIRTH TYPE^
            //;    IEN;BABY#|IEN;BABY#^COMPLICATION(E,AI,AS)^HIGH RISK FLAG(0,1)
            //;  C^IEN^COMMENT
            //;  H^IEN^COMMENT

            // L^111^10/12/2015@10:49:29^^711|Cprspatient,Eight F^HISTORICAL^Unspecified|u^^05/05/2010^|^|^10000000052|Cprsnurse,One^^^^^^NONE^

            //L^114^10/14/2015@06:07:53^^126|Azdhshts,Jxaalshula^HISTORICAL^Unspecified|u^^^|^|^10000000052|Cprsnurse,One^^^^^^NONE^^^1
            //C^114^
            
            //1 2  3                    5               6          7              9              12                            13    15      18     21 
            //L^18^02/17/2016@10:46:57^^531|Jxyht,Aaaaa^HISTORICAL^Unspecified|u^^02/17/2015^|^|^10000000032|Cprsphysician,One^0W0D^^OTHER^^^NONE^^^0

            string piece1 = Util.Piece(line, Caret, 1);
            string ien = ""; 

            switch (piece1)
            {
                case "L":
                    preg.Ien = Util.Piece(line, Caret, 2);
                    preg.Created = Util.Piece(line, Caret, 3); 

                    preg.StartDate = Util.Piece(line, Caret, 4);

                    string pat = Util.Piece(line, Caret, 5);
                    preg.PatientDfn = Util.Piece(pat, "|", 1);

                    preg.RecordType = Util.Piece(line, Caret, 6);

                    string fof = Util.Piece(line, Caret, 7);
                    preg.FatherOfFetus = Util.Piece(fof, "|", 1);
                    preg.FatherOfFetusIen = Util.Piece(fof, "|", 2);

                    preg.EDD = Util.Piece(line, Caret, 8);
                    preg.EndDate = Util.Piece(line, Caret, 9);

                    string ob = Util.Piece(line, Caret, 10);
                    preg.Obstetrician = Util.Piece(ob, "|", 2);
                    preg.ObstetricianIen = Util.Piece(ob, "|", 1);

                    string fac = Util.Piece(line, Caret, 11);
                    preg.LDFacility = Util.Piece(fac, "|", 2);
                    preg.LDFacilityIen = Util.Piece(fac, "|", 1);

                    preg.GestationalAgeAtDelivery = Util.Piece(line, Caret, 13);
                    preg.LengthOfLabor = Util.Piece(line, Caret, 14);
                    preg.TypeOfDelivery = Util.Piece(line, Caret, 15);
                    preg.Anesthesia = Util.Piece(line, Caret, 16);
                    preg.PretermDelivery = Util.Piece(line, Caret, 17); 

                    string babies = Util.Piece(line, Caret, 19);
                    if (!string.IsNullOrWhiteSpace(babies))
                        if (!babies.Equals("NONE", StringComparison.CurrentCultureIgnoreCase))
                        {
                            string[] babyArray = babies.Split("|".ToCharArray());
                            if (babyArray != null)
                                foreach (string baby in babyArray)
                                {
                                    DsioBaby tempBaby = new DsioBaby();
                                    tempBaby.Ien = Util.Piece(baby, ";", 1);
                                    tempBaby.Number = Util.Piece(baby, ";", 2);

                                    if (!string.IsNullOrWhiteSpace(tempBaby.Ien) && !string.IsNullOrWhiteSpace(tempBaby.Number))
                                        preg.Babies.Add(tempBaby);
                                }
                        }

                    preg.Outcome = Util.Piece(line, Caret, 20); 

                    //preg.User = Util.Piece(line, Caret,14); 
                    //preg.UserIen = Util.Piece(line, Caret, 15);

                    preg.HighRisk = Util.Piece(line, Caret, 21);

                    if (this.pregList == null)
                        this.pregList = new Dictionary<string, DsioPregnancy>();

                    this.pregList.Add(preg.Ien, preg);
                    break;

                case "C":
                    ien = Util.Piece(line, Caret, 2);
                    string comment = Util.Piece(line, Caret, 3);

                    if (!string.IsNullOrWhiteSpace(comment))
                        if (this.pregList.ContainsKey(ien))
                            this.pregList[ien].Comment += comment; 

                    break; 

                case "H":
                    ien = Util.Piece(line, Caret, 2);
                    string highRiskDetails = Util.Piece(line, Caret, 3);

                    if (!string.IsNullOrWhiteSpace(highRiskDetails))
                        if (this.pregList.ContainsKey(ien))
                            this.pregList[ien].HighRiskDetails += highRiskDetails; 

                    break; 
            }
        }
    }
}
