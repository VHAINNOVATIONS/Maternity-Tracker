using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.CDA.Participant
{
    public class CdaParticipantList: List<CdaParticipant>
    {
        public POCD_MT000040Participant1[] ToPocdParticpantArray()
        {
            List<POCD_MT000040Participant1> returnList = new List<POCD_MT000040Participant1>();

            foreach (CdaParticipant tempPart in this)
                returnList.Add(tempPart.ToPocdParticipant()); 

            return returnList.ToArray(); 
        }
    }
}
