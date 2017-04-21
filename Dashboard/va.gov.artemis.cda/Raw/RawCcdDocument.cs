// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace VA.Gov.Artemis.CDA
{

    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.XmlRootAttribute("ClinicalDocument", Namespace = "urn:hl7-org:v3", IsNullable = false)]
    public class RawCcdDocument : ConsolidatedCdaDocument
    {

        public RawCcdDocument()
            : base()
        {
            // TODO: Get the code for a ccd...
            //<code codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" code="34133-9" displayName="Summarization of Episode Note"/>
            this.code = new CE() { code = "34133-9", codeSystem = "2.16.840.1.113883.6.1", displayName = "Summarization of Episode Note", codeSystemName = "LOINC" };

            // *** NOTE: Could be customized locally or by system.
            this.title = new ST() { Text = new string[] { "Health Summary" } };

        }
    }
}