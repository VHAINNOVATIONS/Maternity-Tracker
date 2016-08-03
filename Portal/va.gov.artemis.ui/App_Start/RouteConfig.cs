using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
//using NavigationRoutes;
using VA.Gov.Artemis.UI.Controllers; 

namespace VA.Gov.Artemis.UI
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            //routes.MapRoute(
            //    name: "NonVACareListIndex",
            //    url: "NonVACare/Index/{dfn}/{pien}/{itemType}/{page}",
            //    defaults: new { controller = "NonVACare", action = "Index", page = UrlParameter.Optional }
            //    );

            ////routes.MapRoute(
            ////    name: "NonVACare",
            ////    url: "NonVACare/{action}/{ien}",
            ////    defaults: new { controller = "NonVACare", action = "Index", ien = UrlParameter.Optional }
            ////    );

            //routes.MapRoute(
            //    name: "PatientListOverview",
            //    url: "PatientList/Overview/{page}",
            //    defaults: new { controller = "PatientList", action = "Overview", page = UrlParameter.Optional }
            //    );

            ////routes.MapRoute(
            ////    name: "NonVACareDetails",
            ////    url: "NonVACare/Details/{dfn}/",
            ////    defaults: new { controller = "NonVACare", action = "Details"}
            ////    );

            //routes.MapRoute(
            //    name: "NonVACareAddEdit",
            //    url: "NonVACare/AddEdit/{dfn}/{pien}/{itemType}",
            //    defaults: new { controller = "NonVACare", action = "AddEdit", dfn = UrlParameter.Optional, pien = UrlParameter.Optional, itemType = UrlParameter.Optional }
            //    );

            //routes.MapRoute(
            //    name: "PatientSearch",
            //    url: "PatientSearch/Search/{criteria}/{page}",
            //    defaults: new { controller = "PatientSearch", action = "Search", criteria = UrlParameter.Optional, page = UrlParameter.Optional }
            //    );

            //routes.MapRoute(
            //    name: "TrackingHistory",
            //    url: "TrackingHistory/ByPatient/{dfn}/{page}",
            //    defaults: new { controller = "TrackingHistory", action = "ByPatient", dfn = UrlParameter.Optional, page = UrlParameter.Optional }
            //    );

            //routes.MapRoute(
            //    name: "AllTrackingHistory",
            //    url: "TrackingHistory/All/{page}",
            //    defaults: new { controller = "TrackingHistory", action = "All", page = UrlParameter.Optional }
            //    );
            
            //routes. MapRoute(
            //    name: "FlaggedPatientIndex", 
            //    url: "FlaggedPatients/Index/{page}", 
            //    defaults: new { controller = "FlaggedPatients", action="Index", page = UrlParameter.Optional}
            //    );

            //routes.MapRoute(
            //    name: "FlaggedPatientDetails",
            //    url: "FlaggedPatients/Details/{dfn}/{page}",
            //    defaults: new { controller = "FlaggedPatients", action = "Details", dfn = UrlParameter.Optional, page= UrlParameter.Optional }
            //    );

            //routes.MapRoute(
            //    name: "FlaggedPatientProgNote",
            //    url: "FlaggedPatients/ProgressNote/{dfn}/{ien}",
            //    defaults: new { controller = "FlaggedPatients", action = "ProgressNote", dfn = UrlParameter.Optional, ien = UrlParameter.Optional }
            //    );

            //routes.MapRoute(
            //    name: "TrackRoute",
            //    url: "Track/{action}/{dfn}",
            //    defaults: new { controller = "Track", action = "Start"}
            //    );

            //routes.MapRoute(
            //    name: "PatientSummary",
            //    url: "Patient/Summary/{dfn}",
            //    defaults: new { controller = "Patient", action = "Summary", dfn = UrlParameter.Optional }
            //    );

            //routes.MapRoute(
            //    name: "PatientContactIndex",
            //    url: "PatientContact/Index/{dfn}/{filter}",
            //    defaults: new { controller = "PatientContact", action = "Index", filter = UrlParameter.Optional }
            //    );

            //routes.MapRoute(
            //    name: "PatientContactCreate",
            //    url: "PatientContact/Create/{dfn}/{callType}/{checkIen}",
            //    defaults: new { controller = "PatientContact", action = "Create" }
            //    );

            //routes.MapRoute(
            //    name: "PatientContactEdit",
            //    url: "PatientContact/Edit/{dfn}/{noteIen}/{checkIen}",
            //    defaults: new { controller = "PatientContact", action = "Edit" }
            //    );

            //routes.MapRoute(
            //    name: "PatientContactView",
            //    url: "PatientContact/ViewNote/{dfn}/{noteIen}/{checkIen}",
            //    defaults: new { controller = "PatientContact", action = "ViewNote" }
            //    );

            //routes.MapRoute(
            //    name: "NotesIndex",
            //    url: "Notes/Index/{dfn}/{filter}/{page}",
            //    defaults: new { controller = "Notes", action = "Index", page = UrlParameter.Optional }
            //    ); 

            //routes.MapRoute(
            //    name: "NotesRoute",
            //    url: "Notes/{action}/{dfn}/{ien}",
            //    defaults: new { controller = "Notes", action = "Index", ien = UrlParameter.Optional}
            //    );

            //routes.MapRoute(
            //    name: "CdaDocView",
            //    url: "Cda/DocumentView/{dfn}/{ien}",
            //    defaults: new { controller = "Cda", action = "DocumentView" }
            //    );

            //routes.MapRoute(
            //    name: "CdaPatientMatch",
            //    url: "Cda/PatientMatch/{dfn}/{page}",
            //    defaults: new { controller = "Cda", action = "PatientMatch", page=UrlParameter.Optional }
            //    );

            //routes.MapRoute(
            //    name: "CdaOptions",
            //    url: "Cda/Options/{dfn}/{documentType}",
            //    defaults: new { controller = "Cda", action = "Options" }
            //    );

            //routes.MapRoute(
            //    name: "CdaRoute",
            //    url: "Cda/{action}/{dfn}/{page}",
            //    defaults: new { controller = "Cda", action = "Index", page = UrlParameter.Optional }
            //    );

            //routes.MapRoute(
            //    name: "SelectFatherRoute",
            //    url: "Pregnancy/SelectFather/{dfn}/{pien}",
            //    defaults: new { controller = "Pregnancy", action = "SelectFather" }
            //    );

            //routes.MapRoute(
            //    name: "AddEditFatherRoute", 
            //    url: "Pregnancy/AddEditFather/{dfn}/{pien}/{fien}", 
            //    defaults: new { controller="Pregnancy", action="AddEditFather"}
            //    );

            //routes.MapRoute(
            //    name: "SelectNonVARoute",
            //    url: "Pregnancy/SelectNonVACare/{dfn}/{pien}/{itemType}/{page}",
            //    defaults: new { controller = "Pregnancy", action = "SelectNonVACare", page = UrlParameter.Optional }
            //    );

            ////routes.MapRoute(
            ////    name: "AddEditNonVARoute",
            ////    url: "Pregnancy/AddEditNonVACare/{dfn}/{pien}/{itemType}/{itemIen}",
            ////    defaults: new { controller = "Pregnancy", action = "AddEditNonVACare", itemIen = UrlParameter.Optional}
            ////    );

            //routes.MapRoute(
            //    name: "OrdersListRoute",
            //    url: "Orders/Index/{dfn}/{page}",
            //    defaults: new { controller = "Orders", action = "Index", page = UrlParameter.Optional }
            //    );

            //routes.MapRoute(
            //    name: "OrderDetailsRoute",
            //    url: "Orders/Detail/{dfn}/{ifn}",
            //    defaults: new { controller = "Orders", action = "Detail" }
            //    );

            //routes.MapRoute(
            //    name: "EddHistoryRoute",
            //    url: "Pregnancy/EddHistory/{dfn}/{pregIen}/{page}",
            //    defaults: new { controller = "Pregnancy", action = "EddHistory", page = UrlParameter.Optional }
            //    );

            //routes.MapRoute(
            //    name: "EddCalculatorRoute",
            //    url: "Pregnancy/EddCalculator/{dfn}/{pregIen}",
            //    defaults: new { controller = "Pregnancy", action = "EddCalculator" }
            //    );

            //routes.MapRoute(
            //    name: "RemindersListRoute",
            //    url: "Reminders/Index/{dfn}/{page}",
            //    defaults: new { controller = "Reminders", action = "Index", page = UrlParameter.Optional }
            //    );

            //routes.MapRoute(
            //    name: "ReminderDetailsRoute",
            //    url: "Reminders/Detail/{dfn}/{ien}",
            //    defaults: new { controller = "Reminders", action = "Detail" }
            //    );

            //routes.MapRoute(
            //    name: "AlertListRoute",
            //    url: "Alerts/Index/{page}",
            //    defaults: new { controller = "Alerts", action = "Index", page = UrlParameter.Optional }
            //    );

            //routes.MapRoute(
            //    name: "AlertDetailsRoute",
            //    url: "Alerts/Detail/{ien}",
            //    defaults: new { controller = "Alerts", action = "Detail" }
            //    );

            //routes.MapRoute(
            //    name: "LabIndexRoute",
            //    url: "Labs/Index/{dfn}/{labType}/{pregFilter}/{page}",
            //    defaults: new { controller = "Labs", action = "Index", page = UrlParameter.Optional }
            //    );

            //routes.MapRoute(
            //    name: "EducationIndexRoute",
            //    url: "Education/Index/{sort}/{page}",
            //    defaults: new { controller = "Education", action = "Index", page = UrlParameter.Optional }
            //    );

            //routes.MapRoute(
            //    name: "AddEditEducationItemRoute",
            //    url: "Education/AddEdit/{ien}",
            //    defaults: new { controller = "Education", action = "AddEdit"}
            //    );

            //routes.MapRoute(
            //    name: "PatientEducationIndexRoute",
            //    url: "Education/PatientIndex/{dfn}/{page}",
            //    defaults: new { controller = "Education", action = "PatientIndex", page = UrlParameter.Optional }
            //    );

            //routes.MapRoute(
            //    name: "PatientAddEditEducationItemRoute",
            //    url: "Education/PatientAddEdit/{dfn}/{ien}",
            //    defaults: new { controller = "Education", action = "PatientAddEdit", ien = UrlParameter.Optional }
            //    );

            //routes.MapRoute(
            //    name: "ConsultIndexRoute",
            //    url: "Consults/Index/{dfn}/{page}",
            //    defaults: new { controller = "Consults", action = "Index", page = UrlParameter.Optional }
            //    );

            //routes.MapRoute(
            //    name: "ConsultDetailsRoute",
            //    url: "Consults/Detail/{dfn}/{ien}",
            //    defaults: new { controller = "Consults", action = "Detail" }
            //    );

            //routes.MapRoute(
            //    name: "RadiologyIndexRoute",
            //    url: "Radiology/Index/{dfn}/{page}",
            //    defaults: new { controller = "Radiology", action = "Index", page = UrlParameter.Optional }
            //    );

            //routes.MapRoute(
            //    name: "ChecklistIndexRoute",
            //    url: "Checklist/Index/{page}",
            //    defaults: new { controller = "Checklist", action = "Index", page = UrlParameter.Optional }
            //    );

            //routes.MapRoute(
            //    name: "ChecklistAddEditRoute",
            //    url: "Checklist/AddEdit/{ien}",
            //    defaults: new { controller = "Checklist", action = "AddEdit" }
            //    );

            //routes.MapRoute(
            //    name: "PregnancyChecklistIndexRoute",
            //    url: "Checklist/PregnancyIndex/{dfn}/{pregIen}/{page}",
            //    defaults: new { controller = "Checklist", action = "PregnancyIndex", pregIen = UrlParameter.Optional, page = UrlParameter.Optional }
            //    );

            //routes.MapRoute(
            //    name: "PregnancyChecklistAddEditRoute",
            //    url: "Checklist/PregnancyAddEdit/{dfn}/{pregIen}/{itemIen}",
            //    defaults: new { controller = "Checklist", action = "PregnancyAddEdit", itemIen = UrlParameter.Optional }
            //    );

            //routes.MapRoute(
            //    name: "PregnancyAddEditRoute",
            //    url: "Pregnancy/{action}/{dfn}/{pregIen}",
            //    defaults: new { controller = "Pregnancy", pregIen = UrlParameter.Optional }
            //    );

            //routes.MapRoute(
            //    name: "OutcomeRoute",
            //    url: "Outcome/{action}/{dfn}/{pregIen}",
            //    defaults: new { controller = "Outcome"}
            //    );

            //routes.MapRoute(
            //    name: "BabyAddEditRoute",
            //    url: "Pregnancy/BabyAddEdit/{dfn}/{pregIen}/{babyIen}",
            //    defaults: new { controller = "Pregnancy", babyIen = UrlParameter.Optional }
            //    ); 
                        
            routes.MapRoute(
                name: "Default",
                url: "{controller}/{action}/{dfn}",
                defaults: new { controller = "Home", action = "Index", dfn = UrlParameter.Optional }
            );

        }
    }
}