// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.Commands.Tests.Real
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

        public static string[] ValidAccessCodes
        {
            get
            {
                string concatenated = ConfigurationManager.AppSettings["validAccessCodes"];

                return concatenated.Split(',');
            }
        }

        public static string[] ValidVerifyCodes
        {
            get
            {
                string concatenated = ConfigurationManager.AppSettings["validVerifyCodes"];

                return concatenated.Split(',');
            }
            set
            {
                string concatenated = string.Join(",", value);

                Configuration config = ConfigurationManager.OpenExeConfiguration(ConfigurationUserLevel.None);

                config.AppSettings.Settings["validVerifyCodes"].Value = concatenated;

                config.Save();

                //ConfigurationManager.AppSettings["validVerifyCodes"] = concatenated; 

            }
        }

        public static string[] ValidSigs
        {
            get
            {
                string concatenated = ConfigurationManager.AppSettings["validSigs"];

                return concatenated.Split(',');
            }
        }

        public static string ValidDivisionStationNumber
        {
            get
            {
                return ConfigurationManager.AppSettings["validDivisionStationNumber"]; 
            }
        }

        public static string[] ValidProviderIens
        {
            get
            {
                string concatenated = ConfigurationManager.AppSettings["validProviderIens"];
                return concatenated.Split(',');
            }
        }

        public static string ValidEducationIen
        {
            get
            {
                return ConfigurationManager.AppSettings["validEducationIen"];
            }
        }

        public static string DefaultPatientDfn
        {
            get
            {
                return ConfigurationManager.AppSettings["defaultPatientDfn"];
            }
        }

        public static string ValidConsultIen
        {
            get
            {
                return ConfigurationManager.AppSettings["validConsultIen"]; 
            }
        }

        public static string PatientWithOrdersDfn
        {
            get
            {
                return ConfigurationManager.AppSettings["patientWithOrdersDfn"];
            }
        }

        public static string[] PatientSearchILast4
        {
            get
            {   
                string concatenated = ConfigurationManager.AppSettings["patientSearchILast4"];
                return concatenated.Split(',');
            }
        }

        public static string PatientSearchPartial
        {
            get
            {
                return ConfigurationManager.AppSettings["patientSearchPartial"];
            }
        }

        public static string[] PatientsSearchFullNames
        {
            get
            {
                string concatenated = ConfigurationManager.AppSettings["patientSearchFullNames"];

                return concatenated.Split('|');
            }
        }
    }
}
