using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.UI.Data.Brokers.Common;
using VA.Gov.Artemis.UI.Data.Brokers.Account;
using VA.Gov.Artemis.UI.Data.Brokers.Alerts;
using VA.Gov.Artemis.UI.Data.Brokers.Cda;
using VA.Gov.Artemis.UI.Data.Brokers.Checklist;
using VA.Gov.Artemis.UI.Data.Brokers.Consults;
using VA.Gov.Artemis.UI.Data.Brokers.Division;
using VA.Gov.Artemis.UI.Data.Brokers.Education;
using VA.Gov.Artemis.UI.Data.Brokers.Labs;
using VA.Gov.Artemis.UI.Data.Brokers.NonVACare;
using VA.Gov.Artemis.UI.Data.Brokers.Notes;
using VA.Gov.Artemis.UI.Data.Brokers.Observations;
using VA.Gov.Artemis.UI.Data.Brokers.Orders;
using VA.Gov.Artemis.UI.Data.Brokers.Patient;
using VA.Gov.Artemis.UI.Data.Brokers.Pregnancy;
using VA.Gov.Artemis.UI.Data.Brokers.Radiology;
using VA.Gov.Artemis.UI.Data.Brokers.Reminders;
using VA.Gov.Artemis.UI.Data.Brokers.SelectList;
using VA.Gov.Artemis.UI.Data.Brokers.Settings;
using VA.Gov.Artemis.UI.Data.Brokers.TrackingHistory;
using VA.Gov.Artemis.UI.Data.Brokers.Vpr;

namespace VA.Gov.Artemis.UI.Data.Brokers
{
    public interface IDashboardRepository
    {
        IAccountRepository Accounts { get; set; }
        IDivisionRepository Divisions { get; set; }
        ISettingsRepository Settings { get; set; }
        IPatientRepository Patients { get; set; }
        ISelectListRepository SelectLists { get; set; }
        ITrackingHistoryRepository TrackingHistory { get; set; }
        INoteRepository Notes { get; set; }
        INonVACareRepository NonVACare { get; set; }
        ICdaRepository CdaDocuments { get; set; }
        IVprRepository Vpr { get; set; }
        IPregnancyRepository Pregnancy { get; set; }
        IOrdersRepository Orders { get; set; }
        IObservationsRepository Observations { get; set; }
        IRemindersRepository Reminders { get; set; }
        IAlertsRepository Alerts { get; set; }
        ILabsRepository Labs { get; set; }
        IEducationRepository Education { get; set; }
        IChecklistRepository Checklist { get; set; }
        IConsultsRepository Consults { get; set; }
        IRadiologyRepository Radiology { get; set; }

        void SetRpcBroker(IRpcBroker broker);

        string PrenatalLabFileName { get; set; }
    }
}
