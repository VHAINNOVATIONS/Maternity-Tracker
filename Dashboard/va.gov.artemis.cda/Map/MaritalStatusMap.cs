using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.CDA.Common;

namespace VA.Gov.Artemis.CDA.Map
{
    public class MaritalStatusMap
    {
        // Vista...
        //Global ^DIC(11,,0)
        //^DIC(11,1,0)="DIVORCED^^D"
        //^DIC(11,2,0)="MARRIED^^M"
        //^DIC(11,4,0)="WIDOWED^^W"
        //^DIC(11,5,0)="SEPARATED^^S"
        //^DIC(11,6,0)="NEVER MARRIED^^N"
        //^DIC(11,7,0)="UNKNOWN^UNK^U"

        // HL7
        //HL7 Marital Status

        //Value Set HL7 Marital Status - 2.16.840.1.113883.1.11.12212 
        //Code System MaritalStatus - 2.16.840.1.113883.5.2 
        //Version 1 
        //Definition Marital Status is the domestic partnership status of a person. 

        //A MaritalStatus Annulled 
        //D MaritalStatus Divorced 
        //I MaritalStatus Interlocutory 
        //L MaritalStatus Legally Separated 
        //M MaritalStatus Married 
        //P MaritalStatus Polygamous 
        //S MaritalStatus Never Married 
        //T MaritalStatus Domestic partner 
        //W MaritalStatus Widowed 
        
        private static Dictionary<string, Hl7MaritalStatus> map { get; set; }

        private static void Init() 
        {
            if (map == null)
            {
                map = new Dictionary<string, Hl7MaritalStatus>();

                // Key = VistA Value
                // Value = HL7 Cda Value 

                // *** Divorced ***
                map.Add("D", Hl7MaritalStatus.Divorced);

                // *** Married ***
                map.Add("M", Hl7MaritalStatus.Married);

                // *** Widowed ***
                map.Add("W", Hl7MaritalStatus.Widowed);

                // *** Separated ***
                map.Add("S", Hl7MaritalStatus.LegallySeparated);

                // *** Never Married ***
                map.Add("N", Hl7MaritalStatus.NeverMarried);

                // Note: Vista value "U" for unknown should use null
            }
        }

        //public static string GetHL7MaritalStatus(string vistaMaritalStatus)
        public static Hl7MaritalStatus GetHl7MaritalStatus(string vistaMaritalStatus) 
        {
            Hl7MaritalStatus returnVal = Hl7MaritalStatus.Unknown;

            Init(); 

            map.TryGetValue(vistaMaritalStatus, out returnVal); 

            return returnVal;
        }

        public static string GetVistaMaritalStatus(Hl7MaritalStatus hl7MaritalStatus)
        {
            string returnVal = "";

            Init(); 

            returnVal = map.Where(kvp => kvp.Value == hl7MaritalStatus).First().Key; 

            return returnVal;
        }
    }
}
