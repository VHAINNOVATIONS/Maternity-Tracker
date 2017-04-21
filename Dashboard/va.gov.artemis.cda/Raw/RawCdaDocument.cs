// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Serialization;

namespace VA.Gov.Artemis.CDA
{
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.XmlRootAttribute("ClinicalDocument", Namespace = "urn:hl7-org:v3", IsNullable = false)]
    public class RawCdaDocument : POCD_MT000040ClinicalDocument
    {
        // *** Standard CDA format ***
        public static string CdaDateFormat = "yyyyMMddHHmmsszz";

        public RawCdaDocument()
            : base()
        {
            // *** Add hl7 namespace ***
            this.xmlns = new XmlSerializerNamespaces();
            this.xmlns.Add("voc", "urn:hl7-org:v3/voc");

            //// *** Set the realm to US ***
            //this.realmCode = new List<CS>();
            //this.realmCode.Add(new CS() { code = "US" });

            //// *** All documents will have this type ***
            //this.typeId = new POCD_MT000040InfrastructureRoottypeId() { root = "2.16.840.1.113883.1.3", extension = "POCD_HD000040" };

            //// *** Date/Time of Creation ***
            ////<effectiveTime value='20000407130000+0500'/>
            //this.effectiveTime = new TS() { value = DateTime.Now.ToString(RawCdaDocument.CdaDateFormat) };

            //// *** Confidentiality ***
            ////<confidentialityCode code='N' codeSystem='2.16.840.1.113883.5.25'/>
            //this.confidentialityCode = new CE() { code = "N", codeSystem = "2.16.840.1.113883.5.25" };

            //// *** Language ***
            ////<languageCode code='en-US'/>
            //this.languageCode = new CS() { code = "en-US" };

           
        }

        [XmlNamespaceDeclarations]
        public XmlSerializerNamespaces xmlns;

    }
}