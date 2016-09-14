using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.CDA.IHE.Sections;
using VA.Gov.Artemis.CDA.Raw;

namespace VA.Gov.Artemis.CDA.IHE.Documents
{
    public class XdriDocument: CdaDocument
    {
        public ImageReportSection ImageReport { get; set; }

        public XdriDocument()
        {
            this.ImageReport = new ImageReportSection(); 
        }

        public RawXdriDocument ToRawDocument()
        {
            RawXdriDocument returnDoc = new RawXdriDocument();

            // *** Get base type ***
            POCD_MT000040ClinicalDocument arg = returnDoc as POCD_MT000040ClinicalDocument;

            // *** Populate from base ***
            arg = this.AddRawDocumentData(arg);

            // *** Add image report ***
            arg.component = this.ImageReport.ToPocdComponent();

            return returnDoc;
        }
    }
}
