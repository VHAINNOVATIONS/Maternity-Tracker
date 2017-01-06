using VA.Gov.Artemis.Commands.Xus;
using VA.Gov.Artemis.UI.Data.Brokers;
using VA.Gov.Artemis.UI.Filters;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.UI.Data.Brokers.Common;
using VA.Gov.Artemis.UI.Data.Brokers.Division;
using System.Web.Security;
using VA.Gov.Artemis.Core;

namespace VA.Gov.Artemis.UI.Controllers
{
    [Authorize]
    [VerifySession]
    [DisableLocalCache]
    public class DivisionController : DashboardController
    {
        // *** Default constructor used by MVC ***
        public DivisionController() : base() { }

        // *** Broker constructor for testing with mock broker ***
        public DivisionController(IRpcBroker broker): base(broker) {}

        [HttpGet]
        public ActionResult Select()
        {
            // *** Show the division selection ***

            ActionResult returnResult;

            if ((string)TempData.Peek("DivSelectPending") == "true")
            {
                // *** Get the division data from the session ***
                List<XusDivision> divData = (List<XusDivision>)TempData[DivisionDataKey];

                // *** Check if we have anything to work with ***
                if (divData == null)
                {
                    DivisionResult opResult = this.DashboardRepository.Divisions.GetList();

                    if (opResult.Success)
                        divData = opResult.Divisions;

                }

                returnResult = View(divData); 
            }
            else
                returnResult = RedirectToAction("Index", "Home");             

            return returnResult; 
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Select(FormCollection formCollection)
        {
            // *** Select the division ***
            ActionResult returnResult;

            if (formCollection.Get("division.IsDefault") != null)
            {
                // *** Get the division id ***
                string selectedStationNumber = formCollection["division.IsDefault"].ToString();

                // *** Attempt to select ***

                BrokerOperationResult opResult = this.DashboardRepository.Divisions.Select(selectedStationNumber);

                if (opResult.Success)
                {
                    // *** Indicate success to user ***
                    // TODO: Show actual division that was selected...
                    //this.Information("Division Selected");

                    // *** Check that user has the proper context ***
                    BrokerOperationResult result = this.DashboardRepository.Accounts.CreateContext();

                    if (!result.Success)
                    {
                        returnResult = RedirectToAction("NoContext", "Account"); 
                    }
                    else
                    {

                        // *** Set the session timeout based on value in vista ***                            
                        int timeoutInSeconds = this.DashboardRepository.Accounts.GetUserTimeout();

                        // TODO: Used for testing...
                        //timeout = 1; 

                        // *** Set timeout ***
                        if (timeoutInSeconds > 525600)
                            timeoutInSeconds = 525600;

                        // *** Convert timeout to minutes ***
                        int timeout = timeoutInSeconds / 60; 

                        if (timeout >= 1)
                        {
                            VistaLogger.Log(string.Format("Setting Session Timeout to {0} minutes", timeout), "", -1, null, ""); 
                            Session.Timeout = timeout;
                        }

                        // *** Redirect ***
                        returnResult = RedirectToAction("Dashboard", "PatientList");
                    }

                    TempData.Remove("DivSelectPending"); 
                }
                else
                {
                    this.Error("Division selection failed");
                    returnResult = RedirectToAction("Select");
                }
            }
            else
            {
                this.Error("Division selection failed");
                returnResult = RedirectToAction("Select");
            }
            
            return returnResult; 
        }

    }
}
