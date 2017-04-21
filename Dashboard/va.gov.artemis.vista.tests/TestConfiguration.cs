// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.Vista.Tests
{
    public static class TestConfiguration
    {
        public static string ValidServerName
        {
            get
            {
                return ConfigurationManager.AppSettings["validServer"];
            }
        }

        public static int ValidPort
        {
            get
            {
                int returnVal = 0;

                int.TryParse(ConfigurationManager.AppSettings["validListenerPort"], out returnVal);

                return returnVal;
            }
        }
    }
}
