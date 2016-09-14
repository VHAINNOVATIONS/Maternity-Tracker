using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.CDA.Common;

namespace VA.Gov.Artemis.CDA.Participant
{
    public enum Hl7RoleClass { Unknown, NextOfKin, EmergencyContact, PersonalRelationship }

    public class CdaParticipant
    {
        public Hl7RoleClass RoleClass { get; set; }
        public CdaAddress Address { get; set; }
        public List<CdaTelephone> PhoneNumbers { get; set; }
        public CdaName Name { get; set; }

        public CdaParticipant()
        {
            this.Address = new CdaAddress();
            this.PhoneNumbers = new List<CdaTelephone>(); 
            this.Name = new CdaName(); 
        }

        public virtual POCD_MT000040Participant1 ToPocdParticipant()
        {
            POCD_MT000040Participant1 returnVal = new POCD_MT000040Participant1();

            returnVal.typeCode = "IND";
                        
            // *** Associated Entity ***
            returnVal.associatedEntity = new POCD_MT000040AssociatedEntity();

            // *** Class of participant ***
            returnVal.associatedEntity.classCode = this.PocdRoleClass;
            
            // *** Name ***
            if (string.IsNullOrWhiteSpace(this.Name.Last))
            {
                returnVal.associatedEntity.nullFlavor = "UNK";
                returnVal.associatedEntity.associatedPerson = new POCD_MT000040Person(); 
                returnVal.associatedEntity.associatedPerson.nullFlavor = "UNK";
                returnVal.associatedEntity.addr = new AD[] { new AD { nullFlavor = "UNK" } };
                returnVal.associatedEntity.telecom = new TEL[] { new TEL { nullFlavor = "UNK" } };
                returnVal.associatedEntity.associatedPerson.name = new PN[] { new PN() { nullFlavor = "UNK" } };
            }
            else
            {
                returnVal.associatedEntity.associatedPerson = new POCD_MT000040Person();
                returnVal.associatedEntity.associatedPerson.name = new PN[] { this.Name.ToPN() };

                // *** Address ***
                returnVal.associatedEntity.addr = new AD[1];
                returnVal.associatedEntity.addr[0] = this.Address.ToAD();

                // *** Phone Numbers ***
                List<TEL> telList = new List<TEL>();
                foreach (CdaTelephone tel in this.PhoneNumbers)
                    telList.Add(tel.ToTEL());
                returnVal.associatedEntity.telecom = telList.ToArray();
            }

            return returnVal; 
        }

        private string PocdRoleClass
        {
            get
            {
                string[] codes = new string[] {"", "NOK", "ECON", "PRS" };

                return codes[(int)this.RoleClass];
            }
        }
    }
}
