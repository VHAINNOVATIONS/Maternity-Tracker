// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.CDA;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.UI.Data.Models.Cda
{
    public class CdaDocumentData
    {
        public string Ien { get; set; } // Internal to VistA
        public string Id { get; set; } // GUID for exchange
        public string PatientDfn { get; set; }
        public ExchangeDirection ExchangeDirection { get; set; }
        public DateTime CreationDateTime { get; set; }
        public DateTime ImportDateTime { get; set; }
        public IheDocumentType DocumentType { get; set; }
        public string Title { get; set; }
        public string IntendedRecipient { get; set; }
        public string Sender { get; set; }
        public string DocumentContent { get; set; }

        public string ImportDateDisplay
        {
            get
            {
                string returnVal = "";

                if (this.ImportDateTime != DateTime.MinValue)
                    returnVal = this.ImportDateTime.ToString(VistaDates.UserDateTimeFormat);

                return returnVal;
            }
        }

        public static CdaDocumentData Create(string uniqueId, string xmlContent,string patientDfn, IheDocumentType docType,  string intendedRecipient, string sender)
        {
            CdaDocumentData returnVal = new CdaDocumentData();

            returnVal.DocumentContent = xmlContent;

            // *** Prepare header ***                
            returnVal.Id = uniqueId; 
            returnVal.PatientDfn = patientDfn;
            returnVal.CreationDateTime = DateTime.Now;
            returnVal.DocumentType = docType;
            returnVal.ExchangeDirection = ExchangeDirection.Outbound;
            returnVal.IntendedRecipient = intendedRecipient;

            returnVal.Sender = sender;

            // *** Document Names ****
            string docName = CdaUtility.DocumentTypeName[(int)docType];

            // *** Title is based on sender and name ***
            returnVal.Title = string.Format("{0} {1}", returnVal.Sender, docName);

            return returnVal; 
        }
    }
}
