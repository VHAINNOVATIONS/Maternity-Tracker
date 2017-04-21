// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.UI.Data.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
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
    public class DashboardRepository: IDashboardRepository
    {
        private IRpcBroker rpcBroker { get; set; }

        private string prenatalLabFile { get; set; }

        public IAccountRepository Accounts { get; set; }

        public IDivisionRepository Divisions { get; set; }

        public ISettingsRepository Settings { get; set; }

        public IPatientRepository Patients { get; set; }

        public ISelectListRepository SelectLists { get; set; }

        public ITrackingHistoryRepository TrackingHistory { get; set; }

        public INoteRepository Notes { get; set; }

        public INonVACareRepository NonVACare { get; set; }

        public ICdaRepository CdaDocuments { get; set; }

        public IVprRepository Vpr { get; set; }

        public IPregnancyRepository Pregnancy { get; set; }

        public IOrdersRepository Orders { get; set; }

        public IObservationsRepository Observations { get; set; }

        public IRemindersRepository Reminders { get; set; }

        public IAlertsRepository Alerts { get; set; }

        public ILabsRepository Labs { get; set; }

        public IEducationRepository Education { get; set; }

        public IChecklistRepository Checklist { get; set; }

        public IConsultsRepository Consults { get; set; }

        public IRadiologyRepository Radiology { get; set; }

        public DashboardRepository()
        {
            this.Settings = new SettingsRepository(); 
        }

        public void SetRpcBroker(IRpcBroker broker)
        {
            this.rpcBroker = broker;

            this.Accounts = new AccountRepository(rpcBroker);
            this.Divisions = new DivisionRepository(rpcBroker);
            this.Patients = new PatientRepository(rpcBroker);
            this.SelectLists = new SelectListRepository(rpcBroker);
            this.TrackingHistory = new TrackingHistoryRepository(rpcBroker);
            this.Notes = new NoteRepository(rpcBroker);
            this.NonVACare = new NonVACareRepository(rpcBroker);
            this.CdaDocuments = new CdaRepository(rpcBroker);
            this.Vpr = new VprRepository(rpcBroker);
            this.Pregnancy = new PregnancyRepository(rpcBroker);
            this.Orders = new OrdersRepository(rpcBroker);
            this.Observations = new ObservationsRepository(rpcBroker);
            this.Reminders = new RemindersRepository(rpcBroker);
            this.Alerts = new AlertsRepository(rpcBroker);

            if (!string.IsNullOrWhiteSpace(this.prenatalLabFile))
                this.Labs = new LabsRepository(rpcBroker, this.prenatalLabFile);

            this.Education = new EducationRepository(rpcBroker);
            this.Checklist = new ChecklistRepository(rpcBroker);
            this.Consults = new ConsultsRepository(rpcBroker);
            this.Radiology = new RadiologyRepository(rpcBroker); 
        }

        public string PrenatalLabFileName 
        {
            set
            {
                if (!string.IsNullOrWhiteSpace(value))
                {
                    this.prenatalLabFile = value;

                    if (this.rpcBroker != null)
                        this.Labs = new LabsRepository(rpcBroker, this.prenatalLabFile);
                }
            }
            get
            {
                return this.prenatalLabFile;
            }
        }

    }
}