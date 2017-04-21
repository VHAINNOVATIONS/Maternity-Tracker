// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Commands.Orwrp;
using VA.Gov.Artemis.UI.Data.Brokers.Common;
using VA.Gov.Artemis.UI.Data.Models.Radiology;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.UI.Data.Brokers.Radiology
{
    public class RadiologyRepository: RepositoryBase, IRadiologyRepository
    {
        public RadiologyRepository(IRpcBroker newBroker): base(newBroker)
        {

        }

        public RadiologyReportsResult GetReports(string dfn)
        {
            RadiologyReportsResult result = new RadiologyReportsResult();

            if (this.broker != null)
            {
                OrwrpReportTextCommand command = new OrwrpReportTextCommand(this.broker);

                command.AddCommandArguments(dfn);

                RpcResponse response = command.Execute();

                result.SetResult(response.Status == RpcResponseStatus.Success, response.InformationalMessage); 

                if (result.Success) 
                    if (command.ReportList != null)
                        foreach (OrwrpReport orwrpReport in command.ReportList)
                        {
                            RadiologyReport report = GetRadiologyReport(orwrpReport);

                            result.Items.Add(report);                             
                        }
            }

            return result; 
        }

        private RadiologyReport GetRadiologyReport(OrwrpReport orwrpReport)
        {
            RadiologyReport returnReport = new RadiologyReport()
            {
                Location = orwrpReport.Location,
                Procedure = orwrpReport.Procedure,
                ReportStatus = orwrpReport.ReportStatus,
                CptCode = orwrpReport.CptCode,
                ReasonForStudy = orwrpReport.ReasonForStudy,
                ClinicalHistory = orwrpReport.ClinicalHistory,
                Impression = orwrpReport.Impression,
                ReportText = orwrpReport.ReportText
            };

            returnReport.ExamDateTime = VistaDates.ParseDateString(orwrpReport.ExamDateTime, VistaDates.VistADateFormatFive);

            return returnReport; 
        }
    }
}
