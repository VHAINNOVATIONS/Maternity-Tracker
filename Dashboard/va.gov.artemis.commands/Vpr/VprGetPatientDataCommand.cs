// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;
using VA.Gov.Artemis.Commands.Vpr.Data;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Vista.Commands;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.Commands.Vpr
{
    public class VprGetPatientDataCommand: CommandBase 
    {
        public VprPatientResult PatientResult { get; set; }

        /// <summary>
        /// Creates the command
        /// </summary>
        /// <param name="newBroker">An object which allows communication with VistA and implements IRpcBroker</param>
        public VprGetPatientDataCommand(IRpcBroker newBroker) : base(newBroker)
        {
        }

        public override string RpcName {get { return "VPR GET PATIENT DATA"; }}

        public override string Version {get { return "0"; }}

        public void AddCommandArguments(string dfn, 
                            VprDataType type = VprDataType.All, 
                            DateTime? start = null, 
                            DateTime? stop = null, 
                            string max = "", 
                            string item = "")
        {
            string[] VprDataTypeDescriptions = {"all","accessions","reactions","appointments","clinicalProcedures","consults","demographics", 
                                                "documents","healthFactors","flags","immunizations","skinTests","exams","educationTopics",
                                                "insurancePolicies","labs","panels","meds","observations","orders","problems","procedures",
                                                "surgeries","visits","vitals","radiologyExams","patients"};

            string startDateParam = "";
            string stopDateParam = "";
            string typeParam = ""; 

            if (start.HasValue)
                if (start != DateTime.MinValue)
                    startDateParam = Util.GetFileManDate(start.Value);

            if (stop.HasValue)
                if (stop != DateTime.MinValue)
                    stopDateParam = Util.GetFileManDate(stop.Value);

            if (type != VprDataType.All)
                typeParam = VprDataTypeDescriptions[(int)type];
            
            this.CommandArgs = new object[] 
            { 
                dfn, 
                typeParam, 
                startDateParam, 
                stopDateParam, 
                max, 
                item
            };
        }

        protected override void ProcessResponse()
        {
            if (!string.IsNullOrWhiteSpace(this.Response.Data))
            {
                // *** Deserialize the response ***
                XmlSerializer serializer = new XmlSerializer(typeof(VprPatientResult));

                using (StringReader reader = new StringReader(this.Response.Data))
                {
                    this.PatientResult = (VprPatientResult)serializer.Deserialize(reader);

                    this.Response.Status = RpcResponseStatus.Success;
                }                
            }
            else
                this.Response.Status = RpcResponseStatus.Fail;
        }

    }
}
