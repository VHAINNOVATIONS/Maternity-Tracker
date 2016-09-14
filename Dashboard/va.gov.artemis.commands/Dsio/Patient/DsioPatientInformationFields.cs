using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.Commands.Dsio.Patient
{
    public static class DsioPatientInformationFields
    {
        //Patient, Tracking, NextContact, GravidaParaSummary, LastContactDate, NextChecklistDue, SSN, 
        //DOB, ResidencePhone, WorkPhone, CellPhone, Pregnant, Edd, LastPregEnd, LastDelivery, UnableToConceive, 
        //TryingToGetPregnant, Lmp, Lactating, CurrentPregHighRisk, ZipCode, Email, T4bStatus, T4BDate, T4BId

        //.01           PATIENT
        public const string PatientKey = ".01";
        //.02           TRACKING
        public const string TrackingKey = ".02";
        //.03           NEXT CONTACT DATE
        public const string NextContactDueKey = ".03";
        //.04           GP
        public const string GravidaParaSummaryKey = ".04";

        public const string LastContactDateKey = ".05";
        public const string NextChecklistDueKey = ".06";

        //999.01    SSN
        public const string SSNKey = "999.01";
        //999.02    DOB
        public const string DOBKey = "999.02";
        //999.03    PHONE NUMBER [RESIDENCE]
        public const string ResidencePhoneKey = "999.03";
        //999.04    PHONE NUMBER [WORK]
        public const string WorkPhoneKey = "999.04";
        //999.05    PHONE NUMBER [CELLULAR]
        public const string CellPhoneKey = "999.05";
        //999.06    PREGNANT
        public const string PregnantKey = "999.06";
        //999.07    EDD
        public const string EddKey = "999.07";
        //999.08    LAST PREGNANCY END
        public const string LastPregEndKey = "999.08";
        //999.09    LAST PREGNANCY WITH LIVE BIRTH
        public const string LastDeliveryKey = "999.09";
        //999.1      MEDICALLY UNABLE TO CONCEIVE
        public const string UnableToConceiveKey = "999.1";
        //999.11    TRYING TO BECOME PREGNANT
        public const string TryingToGetPregnantKey = "999.11";
        //999.12    LAST MENSTRUAL PERIOD
        public const string LmpKey = "1.2";
        //999.13    CURRENTLY LACTATING
        public const string LactatingKey = "999.13";

        public const string CurrentPregHighRiskKey = "999.15";

        public const string ZipCodeKey = "999.21";
        public const string EmailKey = "999.22";

        public const string T4BStatusKey = "4.1";
        public const string T4BDateKey = "4.2";
        public const string T4BIdKey = "4.3"; 

    }
}
