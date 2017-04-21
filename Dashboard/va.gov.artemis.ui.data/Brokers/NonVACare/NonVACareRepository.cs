// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using VA.Gov.Artemis.Commands.Dsio.Base;
using VA.Gov.Artemis.Commands.Dsio.NonVA;
using VA.Gov.Artemis.UI.Data.Brokers.Common;
using VA.Gov.Artemis.UI.Data.Models.NonVACare;
using VA.Gov.Artemis.Vista.Broker;

namespace VA.Gov.Artemis.UI.Data.Brokers.NonVACare
{
    /// <summary>
    /// Access Non-VA Care Items
    /// </summary>
    public class NonVACareRepository: RepositoryBase, INonVACareRepository
    {
        public NonVACareRepository(IRpcBroker newBroker): base(newBroker)
        {
            
        }

        /// <summary>
        /// Gets a full list of the items, with paging
        /// </summary>
        /// <param name="page">The page desired</param>
        /// <param name="itemsPerPage">The number of items per page</param>
        /// <returns>An operation result which contains a list of items</returns>
        public NonVACareItemsResult GetAll(int page, int itemsPerPage)
        {
            // *** NOTE: Includes inactive ***

            return GetList("", page, itemsPerPage, true);
        }

        /// <summary>
        /// Gets a list of items matching a particular type, with paging
        /// </summary>
        /// <param name="itemType">The type of items to get</param>
        /// <param name="page">The page desired</param>
        /// <param name="itemsPerPage">The number of itemsper page</param>
        /// <returns>An operation result which contains a list of items</returns>
        public NonVACareItemsResult GetList(NonVACareItemType itemType, int page, int itemsPerPage, bool includeInactive)
        {
            NonVACareItemsResult returnResult;

            // *** Make the call based on desired item type ***

            switch (itemType)
            {
                case NonVACareItemType.Facility:
                    returnResult = GetList("F", page, itemsPerPage, includeInactive);
                    break; 
                case NonVACareItemType.Provider:
                    returnResult = GetList("P", page, itemsPerPage, includeInactive);
                    break; 
                default:
                    returnResult = GetList("", page, itemsPerPage, includeInactive);
                    break; 
            }

            return returnResult; 
        }

        private NonVACareItemsResult GetList(string commandArgument, int page, int itemsPerPage, bool includeInactive)
        {
            // *** Get a list of all non va items ***

            NonVACareItemsResult result = new NonVACareItemsResult(); 

            // *** Create the command ***
            DsioGetExternalEntityCommand command = new DsioGetExternalEntityCommand(broker);

            // *** Add the arguments ***            
            command.AddCommandArguments(commandArgument, page, itemsPerPage);

            // *** Execute the command ***
            RpcResponse response = command.Execute();

            // *** Gather the results ***
            result.Success = (response.Status == RpcResponseStatus.Success);
            result.Message = response.InformationalMessage;

            // *** Check for success ***
            if (result.Success)
            {
                result.TotalResults = command.TotalResults;

                if (result.TotalResults > 0)
                {
                    // *** Go through each returned item ***
                    foreach (DsioNonVAItem dsioItem in command.NonVAEntities)
                    {                        
                        NonVACareItem item = GetNonVACareItem(dsioItem);

                        // *** Add if active or including inactive ***
                        if ((item.Inactive == false) || (includeInactive))
                            result.Items.Add(item);
                    }
                }
            }

            return result; 
        }

        private NonVACareItem GetNonVACareItem(DsioNonVAItem dsioItem)
        {
            // *** Create a strongly typed item ***
            NonVACareItem item = new NonVACareItem()
            {
                Ien = dsioItem.Ien,
                Name = dsioItem.EntityName,
                OriginalName = dsioItem.EntityName,
                AddressLine1 = dsioItem.Address.StreetLine1,
                AddressLine2 = dsioItem.Address.StreetLine2,
                City = dsioItem.Address.City,
                State = dsioItem.Address.State,
                ZipCode = dsioItem.Address.ZipCode,
                //Inactive = (dsioItem.Inactive == "YES") ? true : false, 
                Inactive = (dsioItem.Inactive == "1") ? true : false, 
                PrimaryContact = dsioItem.PrimaryContact
            };

            if (dsioItem.TelephoneList != null)
                foreach (DsioTelephone dsioTel in dsioItem.TelephoneList)
                {
                    if (dsioTel.Usage == DsioTelephone.WorkPhoneUsage)
                        item.PhoneNumber = dsioTel.Number;
                    else if (dsioTel.Usage == DsioTelephone.FaxUsage)
                        item.FaxNumber = dsioTel.Number;
                }

            switch (dsioItem.EntityType)
            {
                case "PROVIDER":
                case "P":
                    item.ItemType = NonVACareItemType.Provider;
                    break;
                case "FACILITY":
                case "F":
                    item.ItemType = NonVACareItemType.Facility;
                    break;
                default:
                    item.ItemType = NonVACareItemType.Provider;
                    break;
            }

            return item; 
        }
        
        public IenResult SaveItem(NonVACareItem item)
        {
            // *** Creates a new Non VA Care Item ***

            IenResult result = new IenResult(); 

            // *** Create the command ***
            DsioSaveExternalEntityCommand command = new DsioSaveExternalEntityCommand(broker); 

            // *** Create the entity to save ***
            DsioNonVAItem dsioItem = new DsioNonVAItem();

            //dsioItem.OriginalEntityName = item.OriginalName; 
            dsioItem.Ien = item.Ien; 
            dsioItem.EntityName = item.Name; 
            dsioItem.Address.StreetLine1 = item.AddressLine1; 
            dsioItem.Address.StreetLine2 = item.AddressLine2; 
            dsioItem.Address.City = item.City;
            dsioItem.Address.State = item.State;
            dsioItem.Address.ZipCode = item.ZipCode; 
            dsioItem.TelephoneList.Add(new DsioTelephone(){Number = item.PhoneNumber, Usage = DsioTelephone.WorkPhoneUsage});
            dsioItem.TelephoneList.Add(new DsioTelephone() { Number = item.FaxNumber, Usage = DsioTelephone.FaxUsage }); 
            dsioItem.PrimaryContact = item.PrimaryContact; 

            //dsioItem.Inactive = (item.Inactive) ? "YES" : "NO"; 
            dsioItem.Inactive = (item.Inactive) ? "1" : "0"; 
            //dsioItem.EntityType = (item.ItemType== NonVACareItemType.Provider) ? "PROVIDER" : "FACILITY";
            dsioItem.EntityType = (item.ItemType == NonVACareItemType.Provider) ? "P" : "F";

            // *** Add the arguments ***
            command.AddCommandArguments(dsioItem);

            // *** Execute the command ***
            RpcResponse response = command.Execute();

            // *** Gather results ***
            result.Success = (response.Status == RpcResponseStatus.Success);
            result.Message = response.InformationalMessage;

            if (result.Success)
                result.Ien = command.Ien; 

            return result;             
        }

        /// <summary>
        /// Retrieve a single item 
        /// </summary>
        /// <param name="ien">The unique identifier of the item</param>
        /// <returns>An operation result containing the item if found</returns>
        public NonVACareItemsResult GetItem(string ien)
        {
            return GetList(ien, 1, 1, true);
        }
    }
}
