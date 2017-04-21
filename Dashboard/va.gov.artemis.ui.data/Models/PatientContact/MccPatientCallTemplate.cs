// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.UI.Data.Models.Notes;

namespace VA.Gov.Artemis.UI.Data.Models.PatientContact
{
    public class MccPatientCallTemplate
    {
        private TiuNoteTitle[] titles = new TiuNoteTitle[]{
                    TiuNoteTitle.PhoneCall1, 
                    TiuNoteTitle.PhoneCall2, 
                    TiuNoteTitle.PhoneCall3, 
                    TiuNoteTitle.PhoneCall4, 
                    TiuNoteTitle.PhoneCall5, 
                    TiuNoteTitle.PhoneCall6a, 
                    TiuNoteTitle.PhoneCall6b, 
                    TiuNoteTitle.PhoneCall7
                };

        public MccPatientCallTemplate()
        {
            this.TabList = new List<MccPatientCallTab>();
        }

        public MccPatientCallTemplate(MccPatientCallType callType)
        {
            this.TabList = new List<MccPatientCallTab>();
            this.CallType = callType;
        }

        public MccPatientCallTemplate(string noteTitle)
        {
            this.TabList = new List<MccPatientCallTab>();

            TiuNoteTitle title = TiuNoteTitleInfo.GetTitle(noteTitle);

            int index = Array.IndexOf(titles, title);

            if (index >= 0)
                this.CallType = (MccPatientCallType)index; 
        }

        public MccPatientCallType CallType { get; set; }

        public string Name
        {
            get
            {
                string returnVal = "";

                returnVal = MccPatientCallTypeUtility.GetDescription(this.CallType);

                return returnVal;
            }
        }

        public List<MccPatientCallTab> TabList { get; set; }

        public TiuNoteTitle NoteTitle
        {
            get
            {
                return titles[(int)this.CallType];
            }
        }
    }
}
