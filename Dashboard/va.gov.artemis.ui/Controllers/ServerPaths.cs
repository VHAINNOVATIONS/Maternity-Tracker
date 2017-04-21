// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace VA.Gov.Artemis.UI.Controllers
{
    public class ServerPaths: IServerPaths
    {
        private HttpContext httpContext { get; set; }
        public ServerPaths(HttpContext context)
        {
            this.httpContext = context; 
        }

        public string MapPath(string path)
        {
            return this.httpContext.Server.MapPath(path); 
        }
    }


}