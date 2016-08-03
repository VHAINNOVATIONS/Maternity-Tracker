//using VA.Gov.Artemis.Vista.Broker;
using System.Web.Http;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;
//using VA.Gov.Artemis.Core;
//using VA.Gov.Artemis.UI.Data.Brokers;
using System.Collections.Generic;
using System;
//using VA.Gov.Artemis.UI.Data.Brokers.Common;
using System.IO;
using System.Web;

namespace VA.Gov.Artemis.UI
{
    // Note: For instructions on enabling IIS6 or IIS7 classic mode, 
    // visit http://go.microsoft.com/?LinkId=9394801
    public class MvcApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();

            WebApiConfig.Register(GlobalConfiguration.Configuration);
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);

            var scripts = new ScriptBundle("~/MyBundle");
            scripts.IncludeDirectory("~/Scripts", "*.js");
            BundleTable.Bundles.Add(scripts);

            StyleBundle styleBundle = new StyleBundle("~/Content/css");
            styleBundle.Include("~/Content/Home.css");
            styleBundle.Include("~/Content/Login.css");
            styleBundle.Include("~/Content/ChangeVerifyCode.css");

            BundleTable.Bundles.Add(styleBundle);
        }

        //protected void Session_OnEnd()
        //{
        //    string brokerKey = (string)this.Session[RpcBrokerUtility.BrokerKeyName];

        //    if (!string.IsNullOrWhiteSpace(brokerKey))
        //    {
        //        IRpcBroker broker = BrokerStore.Get(brokerKey);

        //        if (broker != null)
        //        {
        //            RpcBrokerUtility.CloseBroker(broker);
        //            BrokerStore.Delete(brokerKey);
        //        }

        //        Session[RpcBrokerUtility.BrokerKeyName] = "";

        //        TraceLogger.Log(string.Format(" -- Broker connection with key [{0}] has been closed -- ", brokerKey));
        //    }

        //    if (Session["OutgoingCdaDocs"] != null)
        //    {
        //        List<string> docList = (List<string>)Session["OutgoingCdaDocs"];

        //        foreach (string doc in docList)
        //        {
        //            try
        //            {
        //                TraceLogger.Log(string.Format("Deleting CDA temporary file, {0}.", doc));
        //                System.IO.File.Delete(doc);
        //            }
        //            catch (Exception genericException)
        //            {
        //                string message = string.Format("Could not delete temporary CDA file {0}", doc);
        //                ErrorLogger.Log(genericException, message);
        //            }
        //        }
        //    }

        //    if (Session["CdaExportFolder"] != null) 
        //    {
        //        string exportFolder = Session["CdaExportFolder"].ToString();

        //        if (Directory.Exists(exportFolder))
        //        {
        //            string[] files = System.IO.Directory.GetFiles(exportFolder);

        //            foreach (string file in files)
        //            {
        //                string tempUpper = System.IO.Path.GetFileName(file).ToUpper();
        //                if ((tempUpper != "CDA.XSL") && (tempUpper != "WARNING READ THIS.TXT"))
        //                {
        //                    DateTime fileDateTime = System.IO.File.GetLastWriteTime(file);
        //                    DateTime expiredDateTime = DateTime.Now.AddDays(-1);

        //                    if (expiredDateTime > fileDateTime)
        //                        try
        //                        {
        //                            System.IO.File.Delete(file);
        //                        }
        //                        catch (Exception ex)
        //                        {
        //                            ErrorLogger.Log(ex, "Could not delete temporary CDA file");
        //                        }
        //                }
        //            }
        //        }
        //    }
        //}

    }
}