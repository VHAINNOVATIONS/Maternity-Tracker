using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.Commands.Dsio.Cda
{
    /// <summary>
    /// CDA Document information which is stored in VistA
    /// </summary>
    public class DsioCdaDocument
    {
        public string Ien { get; set; }
        public string Id { get; set; }
        public string PatientDfn { get; set; }
        public string CreatedOn { get; set; }
        public string ImportExportDate { get; set; }
        public string DocumentType { get; set; }
        public string Direction { get; set; }
        public string Title { get; set; }
        public string Sender { get; set; }
        public string IntendedRecipient { get; set; }
        public string Content { get; set; }
    }
}
