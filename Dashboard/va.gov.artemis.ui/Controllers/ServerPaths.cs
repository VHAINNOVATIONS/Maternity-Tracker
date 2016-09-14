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