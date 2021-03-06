﻿// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.UI.Data.Brokers.Common;
using VA.Gov.Artemis.UI.Data.Models.NonVACare;

namespace VA.Gov.Artemis.UI.Data.Brokers.NonVACare
{
    public interface INonVACareRepository
    {
        NonVACareItemsResult GetAll(int page, int itemsPerPage);

        NonVACareItemsResult GetList(NonVACareItemType itemType, int page, int itemsPerPage, bool includeInactive);

        IenResult SaveItem(NonVACareItem item);

        NonVACareItemsResult GetItem(string ien);
    }
}
