using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;
using VA.Gov.Artemis.CDA.Common;

namespace VA.Gov.Artemis.CDA.RecordTarget
{
    public class CdaRecordTarget    
    {
        public CdaTemplateIdList TemplateIds { get; set; }

        public string PatientId { get; set; } // Required
        public string SSN {get; set; }

        public CdaAddressList PatientAddressList { get; set; } // 1 Required
        public List<CdaTelephone> PatientTelephoneList { get; set; } // 1 Required

        public CdaPatient Patient { get; set; } // Required

        public CdaGuardian Guardian { get; set; }

        public CdaAddress Birthplace { get; set; }

        public CdaLanguage Language { get; set; }

        public CdaProviderOrganization ProviderOrganization { get; set; }

        public CdaRecordTarget()
        {
            this.TemplateIds = new CdaTemplateIdList(); 

            this.PatientAddressList = new CdaAddressList();
            this.PatientTelephoneList = new List<CdaTelephone>();

            this.Patient = new CdaPatient();
            this.Guardian = new CdaGuardian();
            this.Birthplace = new CdaAddress();
            this.Language = new CdaLanguage();
            this.ProviderOrganization = new CdaProviderOrganization(); 
        }

        public POCD_MT000040RecordTarget ToPocdRecordTarget()
        {
            POCD_MT000040RecordTarget recordTarget = new POCD_MT000040RecordTarget();

            if (this.TemplateIds.Count > 0)
                recordTarget.templateId = this.TemplateIds.ToPocd(); 

            recordTarget.patientRole = new POCD_MT000040PatientRole();

            // *** SSN ***
            II ssnII = new II() { extension = this.SSN, root = "2.16.840.1.113883.4.1" };
            recordTarget.patientRole.id = new II[] { ssnII };

            // *** Address ***
            if (this.PatientAddressList.Count > 0)
                recordTarget.patientRole.addr = this.PatientAddressList.ToADArray();
            else
                recordTarget.patientRole.addr = new AD[] { new AD() { nullFlavor = "UNK" } };

            // *** Telephone Numbers ***
            List<TEL> telList = new List<TEL>();
            foreach (CdaTelephone number in this.PatientTelephoneList)
                telList.Add(number.ToTEL());
            if (telList.Count > 0)
                recordTarget.patientRole.telecom = telList.ToArray();
            else
                recordTarget.patientRole.telecom = new TEL[] { new TEL() { nullFlavor = "UNK" } };
            
            // *** Patient ***
            recordTarget.patientRole.patient = this.Patient.ToPocdPat();

            // *** Provider Organization ***
            recordTarget.patientRole.providerOrganization = this.ProviderOrganization.ToPocdOrganization(); 

            return recordTarget; 
        }

    }
    
}
