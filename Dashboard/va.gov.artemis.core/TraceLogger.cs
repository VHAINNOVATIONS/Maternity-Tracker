// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System; 
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using NLog; 

namespace VA.Gov.Artemis.Core
{
    public static class TraceLogger
    {
        // *** NLog logger object ***
        private static Logger logger = LogManager.GetLogger("dashboard-trace");

        public static void Log(string message)
        {
            logger.Log(LogLevel.Info, string.Format("{0}: {1}", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"), message)); 
        }
    }
}
