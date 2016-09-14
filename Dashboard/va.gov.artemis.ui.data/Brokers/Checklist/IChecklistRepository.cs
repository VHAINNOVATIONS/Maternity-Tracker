using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Commands.Dsio.Checklist;
using VA.Gov.Artemis.UI.Data.Brokers.Common;
using VA.Gov.Artemis.UI.Data.Models.Checklist;

namespace VA.Gov.Artemis.UI.Data.Brokers.Checklist
{
    public interface IChecklistRepository
    {        
        ChecklistItemsResult GetItems(string ien, int page, int itemsPerPage);

        IenResult SaveItem(ChecklistItem item);

        PregnancyChecklistItemsResult GetPregnancyItems(string dfn, string pregIen, string itemIen);

        PregnancyChecklistItemsResult GetPregnancyItems(string dfn, string pregIen, string itemIen, DsioChecklistCompletionStatus status);

        PregnancyChecklistItemResult GetPregnancyItem(string dfn, string ien); 
        
        IenResult SavePregnancyItem(PregnancyChecklistItem item);

        BrokerOperationResult AddDefaultPregnancyItems(string dfn, string pregIen);

        BrokerOperationResult CompletePregnancyItem(PregnancyChecklistItem item);

        BrokerOperationResult CancelPregnancyItem(PregnancyChecklistItem item);

        BrokerOperationResult SetPregnancyItemInProgress(PregnancyChecklistItem item);

        BrokerOperationResult DeleteItem(string ien);

        BrokerOperationResult DeletePregnancyItem(string dfn, string ien);

        BrokerOperationResult LoadDefaultChecklist();

        string ContentPath { get; set; }

    }
}
