using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.Commands.Dsio.Observation
{
    /// <summary>
    /// A command used to save an observation to VistA using an RPC  
    /// </summary>
    public class DsioSaveObservationCommand: DsioCommand 
    {
        /// <summary>
        /// Creates the command
        /// </summary>
        /// <param name="newBroker">A broker which allows communication with VistA and implements the IRpcBroker interface</param>
        public DsioSaveObservationCommand(IRpcBroker newBroker) : base(newBroker) {}

        /// <summary>
        /// The IEN of the observation
        /// </summary>
        public string Ien { get; set; }

        /// <summary>
        /// The name of the RPC 
        /// </summary>
        public override string RpcName
        {
            get { return "DSIO SAVE OBSERVATION"; }
        }

        /// <summary>
        /// Add command arguments that are passed into the RPC 
        /// </summary>
        /// <param name="observation">An observation to be saved</param>
        public void AddCommandArguments(DsioObservation observation)
        {
            string dates = string.Format("{0}^{1}^{2}", observation.ExamDate, observation.EffectiveTimeStart, observation.EffectiveTimeEnd); 

            string preg = (string.IsNullOrWhiteSpace(observation.PregnancyIen)) ? "" : string.Format("PG.{0}", observation.PregnancyIen);
            string baby = (string.IsNullOrWhiteSpace(observation.BabyIen)) ? "" : string.Format("FB.{0}", observation.BabyIen);

            string[] babyPreg = new string[] { preg, baby };

            string tiu = (string.IsNullOrWhiteSpace(observation.NoteIen)) ? "" : string.Format("TIU.{0}", observation.NoteIen);
            string ihe = (string.IsNullOrWhiteSpace(observation.ExchangeDocumentIen)) ? "" : string.Format("IHE.{0}", observation.ExchangeDocumentIen);

            string[] refs = new string[] { tiu, ihe };

            string code = string.Format("{0}^{1}^{2}^{3}", observation.Code.CodeSystemName, observation.Code.CodeSystem, observation.Code.Code, observation.Code.DisplayName);
            //string code = string.Format("{0}^{1}^{2}", observation.Code.CodeSystem, observation.Code.Code, observation.Code.DisplayName);

            string value = string.Format("{0}^{1}^{2}", observation.ValueType, observation.Unit, observation.Value);

            string valueCode = string.Format("{0}^{1}^{2}^{3}", observation.ValueCode.CodeSystemName, observation.ValueCode.CodeSystem, observation.ValueCode.Code, observation.ValueCode.DisplayName);
            //string valueCode = string.Format("{0}^{1}^{2}", observation.ValueCode.CodeSystem, observation.ValueCode.Code, observation.ValueCode.DisplayName);

            string[] qualifiers = new string[]{};

            string[] narrative = (string.IsNullOrWhiteSpace(observation.Narrative)) ? new string[]{} : Util.Split(observation.Narrative);

            this.CommandArgs = new object[]{
                observation.Ien, 
                observation.PatientDfn,                 
                dates,
                babyPreg, 
                refs, 
                observation.Relationship, 
                observation.Category, 
                code,
                value, 
                valueCode, 
                observation.Negation, 
                qualifiers, 
                narrative };
        }

        protected override void ProcessResponse()
        {
            // *** Standard return processing is sufficient ***

            if (ProcessSaveResponse())
            {
                string line1 = this.Response.Lines[0];
                string piece1 = Util.Piece(line1, Caret, 1);

                this.Ien = piece1; 

                this.Response.Status = RpcResponseStatus.Success;
            }
        }


    }
}
