using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.CDA.Participant;

namespace VA.Gov.Artemis.CDA.Map
{
    // *** Could add additional role classes ***

    public class ParticipantRoleMap
    {
        private static Dictionary<string, Hl7RoleClass> map;

        private static void Init()
        {
            if (map == null)
            {
                // Key = VistA Value
                // Value = HL7 Cda Value 

                map = new Dictionary<string, Hl7RoleClass>();
                
                map.Add("ECON", Hl7RoleClass.EmergencyContact);
                map.Add("NOK", Hl7RoleClass.NextOfKin);
                map.Add("SPOUSE", Hl7RoleClass.PersonalRelationship);
                map.Add("FOF", Hl7RoleClass.PersonalRelationship); 
            }
        }

        public static Hl7RoleClass GetHl7RoleClass(string vistaRole)
        {
            Hl7RoleClass returnVal = Hl7RoleClass.Unknown; 

            Init();

            map.TryGetValue(vistaRole.ToUpper(), out returnVal);

            return returnVal; 
        }
    }
}
