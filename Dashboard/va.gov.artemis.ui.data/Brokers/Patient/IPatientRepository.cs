// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.UI.Data.Brokers.Common;
using VA.Gov.Artemis.UI.Data.Models;
using VA.Gov.Artemis.UI.Data.Models.Text4Baby;

namespace VA.Gov.Artemis.UI.Data.Brokers.Patient
{
    public interface IPatientRepository
    {
        PatientSearchResult Search(string searchParam, int page, int itemsPerPage);

        FlaggedPatientsResult GetFlaggedPatients(int page, int itemsPerPage);

        PatientDemographicsResult GetPatientDemographics(string dfn);

        TrackedPatientsResult GetTrackedPatients(int page, int itemsPerPage);

        PatientSearchResult ProgressiveSearch(string lastName, string firstName, int page, int itemsPerPage);

        BrokerOperationResult SaveText4BabyInfo(string dfn, Text4BabyStatus t4bStat, string t4bParticipantId);

        BrokerOperationResult SaveText4BabyInfo(string dfn, Text4BabyStatus t4bStat);

        BrokerOperationResult SaveNextChecklistDue(string dfn, DateTime nextChecklistDue);
    }
}
