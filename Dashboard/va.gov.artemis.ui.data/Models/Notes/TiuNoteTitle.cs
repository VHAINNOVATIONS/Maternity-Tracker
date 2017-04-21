// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.UI.Data.Models.Notes
{

//OB H&P CONSULT
//OB HISTORY NOTE
//OB FOLLOWUP NOTE
//NURSE POSTPARTUM - DELIVERY INFO
//NURSE POSTPARTUM - MATERNAL INFO

    public enum TiuNoteTitle 
    {
        Unknown, 
        MccDashboardNote, 
        DashboardCdaIncoming, 
        OBHPConsult, 
        PhoneCall1, 
        PhoneCall2, 
        PhoneCall3, 
        PhoneCall4, 
        PhoneCall5, 
        PhoneCall6a, 
        PhoneCall6b, 
        PhoneCall7, 
        PhoneCallAdditional, 
        OBFollowUpNote, 
        NursePostpartumNote,
        MdPostPartumVisit, 
        OBHPInitial,
        OBHistory,
        NursePostpartumDelivery,
        NursePostpartumMaternal, 
        MccProviderContact
    }

}
