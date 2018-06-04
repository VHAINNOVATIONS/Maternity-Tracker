// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.Commands.Dsio.Observation
{
    /// <summary>
    /// Command used to retrieve observations from VistA using RPC
    /// </summary>
    public class DsioGetObservationsCommand: DsioPagableCommand    
    {
        /// <summary>
        /// The list of observations returned by the command
        /// </summary>
        public List<DsioObservation> ObservationsList { get; set; }

        private DsioObservation workingObservation { get; set; }

        /// <summary>
        /// Creates a new object
        /// </summary>
        /// <param name="newBroker">A broker which can be used to interact with VistA</param>
        public DsioGetObservationsCommand(IRpcBroker newBroker)
            : base(newBroker){}

        /// <summary>
        /// Add the command arguments which will be passed with the RPC
        /// </summary>
        /// <param name="patientDfn"></param>
        /// <param name="observationIen"></param>
        /// <param name="pregnancyIen"></param>
        /// <param name="babyIen"></param>
        /// <param name="fromDate"></param>
        /// <param name="toDate"></param>
        /// <param name="category"></param>
        /// <param name="page"></param>
        /// <param name="itemsPerPage"></param>
        public void AddCommandArguments(
            string patientDfn, 
            string observationIen, 
            string pregnancyIen, 
            string babyIen, 
            string tiuIen,
            string fromDate, 
            string toDate, 
            string category, 
            int page, 
            int itemsPerPage)
        {

            string preg = (string.IsNullOrWhiteSpace(pregnancyIen)) ? "" : string.Format("PG.{0}", pregnancyIen);
            string baby = (string.IsNullOrWhiteSpace(babyIen)) ? "" : string.Format("FB.{0}", babyIen);

            string[] babyPreg = new string[] { preg, baby };

            string tiu = (string.IsNullOrWhiteSpace(tiuIen)) ? "" : string.Format("TIU.{0}", tiuIen);

            // TODO: Pass in and utilize IHE parameter
            // (string.IsNullOrWhiteSpace(observation.ExchangeDocumentIen)) ? "" : string.Format("IHE.{0}", observation.ExchangeDocumentIen);
            string ihe = ""; 

            string[] refs = new string[] { tiu, ihe };

            string pageParam = "";

            if ((page > 0) && (itemsPerPage > 0))
                pageParam = string.Format("{0},{1}", page, itemsPerPage);

            this.CommandArgs = new object[]
            {
                observationIen, 
                patientDfn,
                babyPreg, 
                refs,
                fromDate, 
                toDate, 
                "", 
                category, 
                "", 
                "", 
                pageParam
            };    
        }

        /// <summary>
        /// The name of the RPC 
        /// </summary>
        public override string RpcName
        {
            get { return "WEBM GET OBSERVATIONS"; }
        }

        //// *** Processes the response data ***
        //protected override void ProcessResponse()
        //{
        //    // *** First do standard processing ***
        //    if (this.ProcessAnyResponse())
        //    {
        //        // *** Process pageable data ***
        //        this.ProcessPage(); 

        //        this.Response.Status = RpcResponseStatus.Success;
        //    }
        //}

        protected override void ProcessResponse()
        {
            base.ProcessResponse();

            // *** Override defautl respone for missing category ***
            if (this.Response.Status == RpcResponseStatus.Fail)
                if (!string.IsNullOrWhiteSpace(this.Response.Data))
                    if (this.Response.Lines[0] == "-1^Unknown category.")
                        this.Response.Status = RpcResponseStatus.Success; 
                    
        }

        // *** Called by base to process an individual line ***
        protected override void ProcessLine(string line)
        {
            //DsioObservation observation = new DsioObservation();

            // *** Format of the return line ***

            //3^06/24/2014@12:58:43^Ays,Shts^8^^^^^Pregnancy History^LOINC^11996-6^Cprsphysician,One^10000000032^Total Pregnancies (Including Current)^1
            //L^141^126^06/02/2015@10:47:29^PG.52;JUN 02, 2015@10:33:58|FB.8;1^^^BABYDETAILS^^^^BabySomething^1.2.3.4^Made Up Code System Name^This is a baby observation^^^^^^Test Val^^FALSE^Cprsnurse,One^06/02/2015@10:47:36^

            string lineType = Util.Piece(line, Caret, 1);

            if (lineType == "L")
            {
                if (this.workingObservation != null)
                    AddWorkingObservationToList(); 

                this.workingObservation = new DsioObservation(); 

                this.workingObservation.Ien = Util.Piece(line, Caret, 2);
                this.workingObservation.PatientDfn = Util.Piece(line, Caret, 3);
                this.workingObservation.ExamDate = Util.Piece(line, Caret, 4);

                // *** Initialize values to empty ***
                this.workingObservation.PregnancyIen = "";
                this.workingObservation.BabyIen = "";
                this.workingObservation.BabyNum = ""; 

                string pregBaby = Util.Piece(line, Caret, 5);
                string[] pregBabyArray = pregBaby.Split("|".ToCharArray());

                foreach (string item in pregBabyArray)
                {
                    string pc1 = Util.Piece(item, ";", 1);
                    string pc2 = Util.Piece(item, ";", 2);

                    string key = Util.Piece(pc1, ".", 1);
                    string ien = Util.Piece(pc1, ".", 2); 

                    //if (key == "WEBM(19641.112,")
                    //    observation.BabyIen = val;
                    //else if (key == "WEBM(19641.13,")
                    //    observation.PregnancyIen = val;
                    if (key == "PG")
                        this.workingObservation.PregnancyIen = ien;
                    else if (key == "FB")
                    {
                        this.workingObservation.BabyIen = ien;
                        this.workingObservation.BabyNum = pc2; 
                    }
                }

                // *** Initialize Values ***
                this.workingObservation.NoteIen = "";
                this.workingObservation.ExchangeDocumentIen = ""; 

                string refs = Util.Piece(line, Caret, 6);
                string[] refsArray = refs.Split("|".ToCharArray());
                foreach (string item in refsArray)
                {
                    //string key = Util.Piece(item, ";", 2);
                    //string val = Util.Piece(item, ";", 1);

                    //if (key == "TIU(8925,")
                    //    this.workingObservation.NoteIen = val;
                    //else if (key == "WEBM(19641.6,")
                    //    this.workingObservation.ExchangeDocumentIen = val;

                    string key = Util.Piece(item, ".", 1);
                    string val = Util.Piece(item, ".", 2);

                    if (key == "TIU")
                        this.workingObservation.NoteIen = Util.Piece(val, ";", 1);
                    else if (key == "IHE")
                        this.workingObservation.ExchangeDocumentIen = Util.Piece(val, ";", 1);                    
                }

                this.workingObservation.Relationship = Util.Piece(line, Caret, 7);
                this.workingObservation.Category = Util.Piece(line, Caret, 8);
                this.workingObservation.EffectiveTimeStart = Util.Piece(line, Caret, 9);
                this.workingObservation.EffectiveTimeEnd = Util.Piece(line, Caret, 10);

                this.workingObservation.Code.Code = Util.Piece(line, Caret, 12);
                this.workingObservation.Code.CodeSystemName = Util.Piece(line, Caret, 13);
                this.workingObservation.Code.CodeSystem = Util.Piece(line, Caret, 14);
                this.workingObservation.Code.DisplayName = Util.Piece(line, Caret, 15);

                this.workingObservation.ValueCode.Code = Util.Piece(line, Caret, 16);
                this.workingObservation.ValueCode.CodeSystemName = Util.Piece(line, Caret, 17);
                this.workingObservation.ValueCode.CodeSystem = Util.Piece(line, Caret, 18);
                this.workingObservation.ValueCode.DisplayName = Util.Piece(line, Caret, 19); 

                this.workingObservation.ValueType = Util.Piece(line, Caret, 20); 
                this.workingObservation.Value = Util.Piece(line, Caret, 21);
                this.workingObservation.Unit = Util.Piece(line, Caret, 22);
                this.workingObservation.Negation = Util.Piece(line, Caret, 23);

                this.workingObservation.EnteredBy = Util.Piece(line, Caret, 24);

                this.workingObservation.EntryDate = Util.Piece(line, Caret, 25); 
                this.workingObservation.Qualifiers = Util.Piece(line, Caret, 26); 
            }
            else if (lineType == "C")
            {
                string lineToAdd = string.Format("{0}\n", Util.Piece(line, Caret, 3));
                if (string.IsNullOrWhiteSpace(this.workingObservation.Narrative))
                    this.workingObservation.Narrative = lineToAdd;
                else
                    this.workingObservation.Narrative += lineToAdd;
            }
        }

        private void AddWorkingObservationToList()
        {
            if (this.workingObservation != null)
            {
                if (this.ObservationsList == null)
                    this.ObservationsList = new List<DsioObservation>();

                this.ObservationsList.Add(this.workingObservation);
            }
        }

        protected override void ProcessEndData()
        {
            AddWorkingObservationToList(); 
        }
    }
}