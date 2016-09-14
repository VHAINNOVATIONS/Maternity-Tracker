using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.UI.Data.Brokers;
using VA.Gov.Artemis.UI.Data.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using VA.Gov.Artemis.UI.Data.Models.ServerSettings;
using VA.Gov.Artemis.UI.Data.Brokers.Common;
using VA.Gov.Artemis.UI.Data.Brokers.Settings;

namespace VA.Gov.Artemis.UI.Controllers
{
    [AllowAnonymous]
    public class ServerSettingsController : DashboardController
    {
        //
        // GET: /ServerSettings/Edit
        public ActionResult Edit()
        {
            // *** Show the edit server settings view ***

            // *** Get the model ***
            ServerConfigResult opResult = this.DashboardRepository.Settings.GetServerData();

            if (!opResult.Success)
                this.Error(opResult.Message); 

            ServerConfig model = opResult.ServerConfig; 

            // *** Return View ***
            return View(model);
        }

        //
        // POST: /ServerSettings/Edit/
        [HttpPost]
        public ActionResult Edit(ServerConfig serverConfig)
        {
            ActionResult returnResult; 

            bool validModelState = this.ModelState.IsValid; 

            returnResult = ProcessEditGet(serverConfig, validModelState);

            return returnResult; 
        }

        [NonAction]
        public ActionResult ProcessEditGet(ServerConfig serverConfig, bool validModelState)
        {
            // *** Edit the server settings data ***

            ActionResult returnResult;

            // *** Check the model state ***
            if (ModelState.IsValid)
            {
                // *** Save the data ***
                BrokerOperationResult opResult = this.DashboardRepository.Settings.SetServerData(serverConfig); 

                if (opResult.Success)
                {
                    // *** If good, then show info **
                    this.Information("Server Settings Saved");

                    returnResult = RedirectToAction("Dashboard", "PatientList");
                }
                else
                {
                    // *** Show error message ***
                    this.Error("Server settings could not be saved");

                    // *** Return to same view ***
                    returnResult = View(serverConfig);
                }
            }
            else
                returnResult = View(serverConfig); 

            return returnResult; 
        }
        
        [HttpPost]
        public ActionResult TestConnection(string serverName, string serverPort)
        {
            ActionResult returnResult;

            BrokerOperationResult opResult = this.DashboardRepository.Settings.TestServerConnection(serverName, serverPort); 

            if (opResult.Success) 
                returnResult = Content("true");
            else
                returnResult = Content("false"); 

            return returnResult; 
        }

    }
}
