// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Commands.Dsio.Observation;
using VA.Gov.Artemis.UI.Data.Brokers.Common;
using VA.Gov.Artemis.UI.Data.Models.Observations; 

namespace VA.Gov.Artemis.UI.Data.Brokers.Observations
{
    public interface IObservationsRepository
    {
        ObservationListResult GetObservations(string patientDfn, string pregnancyIen, string babyIen, string tiuIen, string fromDate, string toDate, string category, int page, int itemsPerPage);

        IenResult SaveObservation(Observation observation);

        BrokerOperationResult SaveObservations(List<Observation> observationList);

        IenResult AddLactationObservation(string patientDfn, bool currentlyLactating);

        BrokerOperationResult UpdateNextContactDue(string patientDfn, DateTime nextContactDue);

        BrokerOperationResult UpdateLastContactDate(string patientDfn, DateTime lastContactDate);

        BrokerOperationResult UpdateNextChecklistDue(string patientDfn, DateTime nextChecklistDue);

        IenResult SaveSingletonObservation(Observation observation);

        BrokerOperationResult SaveSingletonObservations(List<Observation> observationList);

        BrokerOperationResult SaveSingletonObservationsByCategory(List<Observation> observationList);

        ObservationListResult GetObservationListByCategory(string patientDfn, string pregIen, string category);

    }
}
