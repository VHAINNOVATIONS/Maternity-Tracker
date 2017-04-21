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
    public static class ErrorLogger
    {
        private static Logger logger = LogManager.GetLogger("dashboard-error");

        public static void Log(Exception ex, string message)
        {
            string fullMessage = string.Format("{0}: {1} \n {2}", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"), message, ex.ToString());

            logger.Error(fullMessage);
        }

        public static void Log(string message)
        {
            string fullMessage = string.Format("{0}: {1}", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"), message);

            logger.Error(fullMessage); 
        }

    }
}
