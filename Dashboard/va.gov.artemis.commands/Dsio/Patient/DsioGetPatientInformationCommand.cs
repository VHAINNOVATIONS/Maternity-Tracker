using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Commands.Dsio.Tracking;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.Commands.Dsio.Patient
{
    /// <summary>
    /// Command to retrieve basic patient information
    /// </summary>
    public class DsioGetPatientInformationCommand : DsioCommand
    {

        /// <summary>
        /// The patient details
        /// </summary>
        public DsioPatientInformation Patient { get; set; }

        /// <summary>
        /// Creates the command
        /// </summary>
        /// <param name="newBroker">An object which allows communication with VistA and implements IRpcBroker</param>
        public DsioGetPatientInformationCommand(IRpcBroker newBroker)
            : base(newBroker)
        {

        }

        /// <summary>
        /// Add command arguments to the RPC call
        /// </summary>
        /// <param name="patientDfn"></param>
        public void AddCommandArguments(string patientDfn)
        {
            this.CommandArgs = new object[] { patientDfn};
        }

        /// <summary>
        /// The name of the RPC
        /// </summary>
        public override string RpcName
        {
            get { return "DSIO GET PATIENT INFORMATION"; }
        }

        protected override void ProcessResponse()
        {
            if (this.ProcessQueryResponse())
            {
                this.Patient = new DsioPatientInformation();

                this.Patient.Dfn = this.CommandArgs[0] as string; 

                string[] lines = this.Response.Lines;

                foreach (string line in lines)
                {
                    string id = Util.Piece(line, Caret, 1);
                    string val = Util.Piece(line, Caret, 2);

                    switch (id)
                    {
                        case DsioPatientInformationFields.PatientKey: // Name 
                            //this.Patient.LastName = Util.Piece(val, ",", 1);
                            //this.Patient.FirstName = Util.Piece(val, ",", 2);
                            this.Patient.PatientName = val; 
                            break;
                        case DsioPatientInformationFields.TrackingKey: // Tracking Status
                            this.Patient.TrackingStatus = val; 
                            break;
                        case DsioPatientInformationFields.NextContactDueKey: // Next Contact Date
                            this.Patient.NextContactDue = val; 
                            break;
                        case DsioPatientInformationFields.SSNKey: // SSN
                            this.Patient.SSN = val;
                            break;
                        case DsioPatientInformationFields.DOBKey: // DOB
                            this.Patient.DOB = val;
                            break;
                        case DsioPatientInformationFields.ResidencePhoneKey: // Home Phone
                            this.Patient.HomePhone = val;
                            break;
                        case DsioPatientInformationFields.WorkPhoneKey: // Work Phone
                            this.Patient.WorkPhone = val;
                            break;
                        case DsioPatientInformationFields.CellPhoneKey: // Cell Phone
                            this.Patient.MobilePhone = val;
                            break;
                        case DsioPatientInformationFields.PregnantKey: // Pregnant
                            this.Patient.Pregnant = val;
                            break;
                        case DsioPatientInformationFields.EddKey: // EDD
                            this.Patient.EDD = val;
                            break;
                        case DsioPatientInformationFields.GravidaParaSummaryKey: // Gravida & Para
                            this.Patient.GravidaPara = val;
                            break;
                        case DsioPatientInformationFields.LastDeliveryKey:
                            this.Patient.LastLiveBirth = val;
                            break;
                        case DsioPatientInformationFields.LactatingKey:
                            this.Patient.Lactating = val;
                            break;
                        case DsioPatientInformationFields.LastContactDateKey:
                            this.Patient.LastContactDate = val;
                            break;
                        case DsioPatientInformationFields.NextChecklistDueKey:
                            this.Patient.NextChecklistDue = val;
                            break;
                        case DsioPatientInformationFields.LmpKey:
                            this.Patient.Lmp = val;
                            break;
                        case DsioPatientInformationFields.CurrentPregHighRiskKey:
                            this.Patient.CurrentPregnancyHighRisk = val;
                            string detail = Util.Piece(line, Caret, 3);
                            if (!string.IsNullOrWhiteSpace(detail))
                                this.Patient.HighRiskDetails = detail; 
                            break;

                        case DsioPatientInformationFields.ZipCodeKey:
                            this.Patient.ZipCode = val; 
                            break;

                        case DsioPatientInformationFields.EmailKey:
                            this.Patient.Email = val; 
                            break;

                        case DsioPatientInformationFields.T4BStatusKey:
                            this.Patient.Text4BabyStatus = val;
                            break;

                        case DsioPatientInformationFields.T4BDateKey:
                            this.Patient.Text4BabyDate = val; 
                            break; 

                        case DsioPatientInformationFields.T4BIdKey:
                            this.Patient.Text4BabyId = val;
                            break; 
                    }

                    this.Response.Status = RpcResponseStatus.Success;
                }
            }
        }
    }
}