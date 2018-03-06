// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System.Diagnostics;
using System.Reflection;
using VA.Gov.Artemis.Core;
using VA.Gov.Artemis.UI.Data.Brokers;
using VA.Gov.Artemis.UI.Data.Brokers.Cda;
using VA.Gov.Artemis.UI.Data.Brokers.Common;
using VA.Gov.Artemis.UI.Data.Brokers.Patient;
using VA.Gov.Artemis.UI.Data.Brokers.Settings;
using VA.Gov.Artemis.UI.Data.Models.Common;
using VA.Gov.Artemis.UI.Data.Models.Patient;
using VA.Gov.Artemis.Vista.Broker;

namespace VA.Gov.Artemis.UI.Controllers
{
    // *** Base class for all dashboard controllers ***

    public abstract class DashboardController : BootstrapBaseController
    {
        // *** Constants for TempData ***
        public const string DivisionDataKey = "DivisionData";
        //public const string SearchPatientsKey = "SearchPatients";
        public const string ReturnUrl = "ReturnUrl";
        public const string LastPatientListUrl = "LastPatientListUrl";

        // *** URL for multi-step process if ReturnUrl is not enough
        public const string FinishedUrl = "FinishedUrl";

        // *** Repository for accessing VistA data ***
        protected IDashboardRepository DashboardRepository { get; set; }

        // *** Rpc Broker to access Vista data ***
        private IRpcBroker rpcBroker { get; set; }

        public const int DefaultResultsPerPage = 10;

        // *** Default constructor ***
        public DashboardController()
        {
            this.DashboardRepository = new DashboardRepository();
        }

        // *** Constructor where broker can be specified prior (used by unit tests) ***
        public DashboardController(IRpcBroker broker)
        {
            this.DashboardRepository = new DashboardRepository();
            this.DashboardRepository.SetRpcBroker(broker);
            rpcBroker = broker;
        }

        protected bool CreateBroker()
        {
            // *** Create the broker to use for data calls ***

            bool returnVal = false;

            if (this.rpcBroker == null)
            {
                // *** Get server settings ***
                ServerConfigResult opResult = this.DashboardRepository.Settings.GetServerData();

                if (opResult.Success)
                {
                    // *** Get connected broker ***
                    this.rpcBroker = RpcBrokerUtility.GetNewConnectedRpcBroker(opResult.ServerConfig);

                    // *** Check for broker ***
                    if (this.rpcBroker != null)
                    {
                        // *** Add broker to store ***
                        this.BrokerKey = BrokerStore.Add(this.rpcBroker);

                        returnVal = true;
                    }
                    else
                        ErrorLogger.Log("Could not get a connected broker");
                }
            }
            else // *** We already have a broker ***
                returnVal = true;

            // *** Add Prenatal Lab File Name to repository ***
            this.DashboardRepository.PrenatalLabFileName = this.Request.MapPath("~/Content/PrenatalLabs.csv");

            // *** Add Content Path to Checklist Repository ***
            if (this.DashboardRepository.Checklist != null)
                this.DashboardRepository.Checklist.ContentPath = this.Request.MapPath("~/Content/");

            // *** Add broker to DashboardBroker ***
            if (this.rpcBroker != null)
                this.DashboardRepository.SetRpcBroker(this.rpcBroker);

            return returnVal;
        }

        protected bool CloseBroker()
        {
            // *** Close and cleanup an rpc broker ***

            bool returnVal = false;

            // *** First get it from the store ***
            GetBrokerFromStore();

            // *** If we have one ***
            if (this.rpcBroker != null)
            {
                // *** Delete from store ***
                BrokerStore.Delete(this.BrokerKey);

                // *** Close the broker **
                RpcBrokerUtility.CloseBroker(this.rpcBroker);

                // *** Remove reference ***
                this.rpcBroker = null;

                // *** Indicate success ***
                returnVal = true;
            }

            // *** Remove unneeded key name ***
            if (Session != null)
                Session[RpcBrokerUtility.BrokerKeyName] = "";

            return returnVal;
        }

        protected override void OnActionExecuting(System.Web.Mvc.ActionExecutingContext filterContext)
        {
            // *** Before all actions, get the active rpc broker (if there is one), and pass to "Broker" ***

            GetBrokerFromStore();

            // *** Check if broker was found ***
            if (this.rpcBroker != null)
                this.DashboardRepository.SetRpcBroker(this.rpcBroker);

            // *** Add Prenatal Lab File Name to repository ***
            this.DashboardRepository.PrenatalLabFileName = this.Request.MapPath("~/Content/PrenatalLabs.csv");

            // *** Add Content Path to Checklist Repository ***
            if (this.DashboardRepository.Checklist != null)
                this.DashboardRepository.Checklist.ContentPath = this.Request.MapPath("~/Content/");

            // *** Trace all actions ***
            TraceAction(filterContext.ActionDescriptor.ActionName,
                filterContext.ActionDescriptor.ControllerDescriptor.ControllerName);

            // *** Get location of assembly ***
            string location = Assembly.GetExecutingAssembly().Location;

            // *** Get version from assembly ***
            FileVersionInfo fvi = FileVersionInfo.GetVersionInfo(location);

            // *** Place printable version in view bag ***
            ViewBag.AppVersion = fvi.FileVersion;

            // *** Store patient dfn ***
            // TODO: Think about moving this to an action filter to limit when it's called
            StorePatientDfn(filterContext);

            // *** Add CDA Export folder to session ***
            CdaSettingsResult result = this.DashboardRepository.Settings.GetCdaSettings();

            // *** Allow timeout by default ***
            ViewBag.NoTimeout = false;

            if (result.Success)
                Session["CdaExportFolder"] = result.CdaExportFolder;

        }

        protected int GetPage(string page)
        {
            // *** Get proper page, default to 1 ***
            int pageVal;
            if (!int.TryParse(page, out pageVal))
                pageVal = 1;

            return pageVal;
        }

        //public void UpdateCurrentPregnancy()
        //{
        //    PregnancyDetails currentPregnancyDsio;
        //    PregnancyDetails currentPregnancyWvrpcor;

        //    //Get DSIO current pregnancy
        //    PregnancyResult pregResultDsio = this.DashboardRepository.Pregnancy.GetCurrentPregnancy(this.CurrentPatientDfn);
        //    if (!pregResultDsio.Success)
        //    {
        //        this.Error(pregResultDsio.Message);
        //    }
        //    else
        //    {
        //        currentPregnancyDsio = pregResultDsio.Pregnancy;

        //        //Get Wvrpcor current pregnancy
        //        PregnancyResult pregResultWvrpcor = this.DashboardRepository.Pregnancy.GetCurrentWvrpcorPregnancy(this.CurrentPatientDfn);
        //        if (!pregResultWvrpcor.Success)
        //        {
        //            this.Error(pregResultWvrpcor.Message);
        //        }
        //        else
        //        {
        //            currentPregnancyWvrpcor = pregResultWvrpcor.Pregnancy;

        //            //If the current pregnancy in the DSIO namespace is different than the one in CPRS,
        //            //update it with the pregnancy data from CPRS                
        //            //string ienDsio = pregDsio.Ien;
        //            //string ienWvrpcor = pregWvrpcor.Ien;
        //            if (currentPregnancyDsio != null && currentPregnancyWvrpcor != null)
        //            {
        //                DateTime eddDsio = currentPregnancyDsio.EDD;
        //                DateTime eddWvrpcor = currentPregnancyWvrpcor.EDD;
        //                string lmpDsio = currentPregnancyDsio.Lmp;
        //                string lmpWvrpcor = currentPregnancyWvrpcor.Lmp;
        //                if (eddDsio != eddWvrpcor || lmpDsio != lmpWvrpcor)
        //                {
        //                    //pregDsio.Ien = ienWvrpcor;
        //                    currentPregnancyDsio.EDD = eddWvrpcor;
        //                    currentPregnancyDsio.Lmp = lmpWvrpcor;
        //                    currentPregnancyDsio.Created = currentPregnancyWvrpcor.Created;

        //                    BrokerOperationResult savePregResult = this.DashboardRepository.Pregnancy.SavePregnancy(currentPregnancyDsio);
        //                    if (!savePregResult.Success)
        //                    {
        //                        this.Error(savePregResult.Message);
        //                    }
        //                }
        //            }
        //            else if (currentPregnancyDsio == null && currentPregnancyWvrpcor != null)
        //            {
        //                BrokerOperationResult savePregResult = this.DashboardRepository.Pregnancy.SavePregnancy(currentPregnancyWvrpcor);
        //                if (!savePregResult.Success)
        //                {
        //                    this.Error("Unable to update patient's current pregnancy with the pregnancy from CPRS: " + savePregResult.Message);
        //                }
        //            }
        //        }
        //    }
        //}

        protected BasePatient CurrentPatient
        {
            get
            {
                BasePatient returnVal = null;

                PatientDemographicsResult result = this.DashboardRepository.Patients.GetPatientDemographics(this.CurrentPatientDfn);
                if (result.Success)
                    returnVal = result.Patient;
                else
                {
                    returnVal = new BasePatient() { NotFound = true };
                    this.Error(result.Message);
                }

                return returnVal;
            }
        }

        protected string CurrentPatientDfn { get; set; }

        private void GetBrokerFromStore()
        {
            // *** Sets local broker based on broker in store ***
            if (!string.IsNullOrWhiteSpace(this.BrokerKey))
                this.rpcBroker = BrokerStore.Get(this.BrokerKey);
        }

        private string BrokerKey
        {
            get
            {
                string returnVal = "";

                // *** Get broker key from session ***

                if (this.Session != null)
                    returnVal = (string)Session[RpcBrokerUtility.BrokerKeyName];

                return returnVal;
            }
            set
            {
                if (this.Session != null)
                    Session[RpcBrokerUtility.BrokerKeyName] = value;
            }
        }

        private void TraceAction(string action, string controller)
        {
            string messageFormat = "DashboardController.OnExecutingAction - Executing action [{0}] on controller [{1}]";

            string message = string.Format(messageFormat, action, controller);

            TraceLogger.Log(message);
        }

        private void StorePatientDfn(System.Web.Mvc.ActionExecutingContext filterContext)
        {
            if (filterContext.ActionParameters.ContainsKey("dfn"))
            {
                if (filterContext.ActionParameters["dfn"] != null)
                    this.CurrentPatientDfn = filterContext.ActionParameters["dfn"].ToString();
            }
            else
            {
                foreach (object o in filterContext.ActionParameters.Values)
                    if (o is PatientRelatedModel)
                    {
                        PatientRelatedModel patDetail = (PatientRelatedModel)o;

                        this.CurrentPatientDfn = patDetail.Patient.Dfn;
                    }
            }
        }

    }
}