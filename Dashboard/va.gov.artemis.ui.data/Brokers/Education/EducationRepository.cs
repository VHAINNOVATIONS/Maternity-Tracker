using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Commands.Dsio.Education;
using VA.Gov.Artemis.UI.Data.Models.Common;
using VA.Gov.Artemis.UI.Data.Models.Education;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Vista.Utility;
using VA.Gov.Artemis.UI.Data.Brokers.Common;
using VA.Gov.Artemis.CDA.ValueSets;
using VA.Gov.Artemis.CDA.Common;

namespace VA.Gov.Artemis.UI.Data.Brokers.Education
{
    public class EducationRepository: RepositoryBase, IEducationRepository
    {
        public EducationRepository(IRpcBroker newBroker) : base(newBroker)
        {

        }

        public IenResult SaveEducationItem(EducationItem item)
        {
            IenResult result = new IenResult();

            if (this.broker != null)
            {
                DsioSaveEducationItemCommand command = new DsioSaveEducationItemCommand(this.broker);

                DsioEducationItem dsioItem = GetDsioItem(item);

                command.AddCommandArguments(dsioItem);

                RpcResponse response = command.Execute();

                result.SetResult(response.Status == RpcResponseStatus.Success, response.InformationalMessage);

                if (result.Success)
                    result.Ien = command.Ien; 
            }

            return result; 
        }

        public EducationItemsResult GetEducationItems(string ien, string category, EducationItemType itemType, int page, int pageSize, EducationItemSort sort)
        {
            EducationItemsResult result = new EducationItemsResult();

            if (this.broker != null)
            {
                DsioGetEducationItemsCommand command = new DsioGetEducationItemsCommand(this.broker);

                string dsioItemType = GetDsioItemType(itemType); 

                command.AddCommandArguments(ien, category, dsioItemType, page, pageSize, (int)sort);

                RpcResponse response = command.Execute();

                result.SetResult(response.Status == RpcResponseStatus.Success, response.InformationalMessage);

                if (result.Success)
                    if (command.EducationItems != null)
                        if (command.EducationItems.Count > 0)
                        {
                            foreach (DsioEducationItem dsioItem in command.EducationItems)
                            {
                                EducationItem item = GetItem(dsioItem);

                                result.EducationItems.Add(item);
                            }

                            result.TotalResults = command.TotalResults; 
                        }
                
            }

            return result; 
        }

        public BrokerOperationResult DeleteEducationItem(string ien)
        {
            BrokerOperationResult result = new BrokerOperationResult();

            if (this.broker != null)
            {
                DsioDeleteEducationItemCommand command = new DsioDeleteEducationItemCommand(this.broker);

                command.AddCommandArguments(ien);

                RpcResponse response = command.Execute();

                result.SetResult(response.Status == RpcResponseStatus.Success, response.InformationalMessage);
            }

            return result; 
        }

        private DsioEducationItem GetDsioItem(EducationItem item)
        {
            DsioEducationItem returnItem = new DsioEducationItem()
            {
                Ien = item.Ien,
                Description = item.Description,
                Category = item.Category,
                Url = item.Url,
                Code = item.Code
            };

            returnItem.ItemType = GetDsioItemType(item.ItemType);
            returnItem.CodeSystem = GetDsioCodeSystem(item.CodingSystem); 

            return returnItem; 
        }

        private EducationItem GetItem(DsioEducationItem dsioItem)
        {
            EducationItem returnItem = new EducationItem()
            {
                Ien = dsioItem.Ien,
                Description = dsioItem.Description,
                Category = dsioItem.Category,
                Url = dsioItem.Url,
                Code = dsioItem.Code
            };

            returnItem.ItemType = GetItemType(dsioItem.ItemType);
            returnItem.CodingSystem = GetCodingSystem(dsioItem.CodeSystem); 

            return returnItem; 
        }

        private string GetDsioItemType(EducationItemType edItemType)
        {
            //string[] edItemTypes = new string[] { "", "DISCUSSION TOPIC", "LINK TO MATERIAL", "PRINTED MATERIAL", "ENROLLMENT", "OTHER" };
            string[] edItemTypes = new string[] { "", "D", "L", "P", "E", "O" };

            return edItemTypes[(int)edItemType];
        }

        private EducationItemType GetItemType(string dsioEdItemType)
        {
            EducationItemType returnVal = EducationItemType.Unknown;

            switch (dsioEdItemType)
            {
                case "DISCUSSION TOPIC":
                    returnVal = EducationItemType.DiscussionTopic;
                    break; 
                case "LINK TO MATERIAL":
                    returnVal = EducationItemType.LinkToMaterial; 
                    break; 
                case "PRINTED MATERIAL":
                    returnVal = EducationItemType.PrintedMaterial; 
                    break; 
                case "ENROLLMENT":
                    returnVal = EducationItemType.Enrollment; 
                    break; 
                case "OTHER":
                    returnVal = EducationItemType.Other;
                    break;
            }

            return returnVal;
        }

        private string GetDsioCodeSystem(CodingSystem codingSystem)
        {
            //string[] codeSystemDescription = new string[] { "NONE", "LOINC", "SNOMED" };
            string[] codeSystemDescription = new string[] { "N", "L", "S", "O" };

            return codeSystemDescription[(int)codingSystem]; 
        }

        private CodingSystem GetCodingSystem(string dsioCodeSystem)
        {
            CodingSystem returnVal = CodingSystem.None;

            switch (dsioCodeSystem)
            {
                case "LOINC":
                    returnVal = CodingSystem.Loinc;
                    break;
                case "SNOMED":
                    returnVal = CodingSystem.SnomedCT;
                    break;
            }

            return returnVal;
        }

        public IenResult SavePatientItem(PatientEducationItem item)
        {
            IenResult result = new IenResult();

            if (this.broker != null)
            {
                DsioEducationItem dsioEdItem = GetDsioItem(item);

                DsioPatientEducationItem dsioItem = new DsioPatientEducationItem(dsioEdItem);
                
                dsioItem.EducationItemIen = item.EducationItemIen;
                dsioItem.PatientDfn = item.PatientDfn;

                dsioItem.CompletedOn = Util.GetFileManDateAndTime(item.CompletedOn);
                
                DsioSavePatientEducationCommand command = new DsioSavePatientEducationCommand(this.broker);

                command.AddCommandArguments(dsioItem);

                RpcResponse response = command.Execute();

                result.SetResult(response.Status == RpcResponseStatus.Success, response.InformationalMessage);

                if (result.Success)
                    result.Ien = command.Ien;
            }

            return result; 
        }

        public PatientEducationItemsResult GetPatientItems(string patientDfn, string ien, DateTime fromDate, DateTime toDate, EducationItemType itemType, int page, int itemsPerPage)
        {
            PatientEducationItemsResult result = new PatientEducationItemsResult();

            if (this.broker != null)
            {
                DsioGetPatientEducationCommand command = new DsioGetPatientEducationCommand(this.broker);

                string dsioItemType = GetDsioItemType(itemType);

                string fmFromDate = Util.GetFileManDate(fromDate); 
                string fmToDate = Util.GetFileManDate(toDate);

                command.AddCommandArguments(patientDfn, ien, fmFromDate, fmToDate, dsioItemType, page, itemsPerPage); 

                RpcResponse response = command.Execute();

                result.SetResult(response.Status == RpcResponseStatus.Success, response.InformationalMessage);

                if (result.Success)
                    if (command.Items != null)
                        if (command.Items.Count > 0)
                        {
                            foreach (DsioPatientEducationItem dsioItem in command.Items)
                            {
                                EducationItem item = GetItem(dsioItem);

                                PatientEducationItem patItem = new PatientEducationItem(item);

                                patItem.CompletedOn = Util.GetDateTime(dsioItem.CompletedOn);
                                patItem.CompletedBy = dsioItem.CompletedBy; 

                                result.Items.Add(patItem);
                            }

                            result.TotalResults = command.TotalResults;
                        }

            }

            return result; 

        }

        public BrokerOperationResult DeletePatientItem(string ien)
        {
            throw new NotImplementedException();
        }

        public Dictionary<string, string> GetItemSelection()
        {
            Dictionary<string, string> returnVal = new Dictionary<string, string>();

            EducationItemsResult result = this.GetEducationItems("", "", EducationItemType.Unknown, 0, 0, EducationItemSort.Description);

            returnVal = new Dictionary<string, string>();

            if (result.Success)
                if (result.EducationItems != null)
                    if (result.EducationItems.Count > 0)
                        foreach (EducationItem item in result.EducationItems)
                            returnVal.Add(item.Ien, item.Description);

            return returnVal;
        }

        public EducationItemsResult LoadDefaults()
        {
            EducationItemsResult returnResult = new EducationItemsResult();

            bool ok = false; 

            EducationItemsResult result = this.GetEducationItems("", "", EducationItemType.Unknown, 0,0, EducationItemSort.Type);

            if (result.Success)
                if (result.EducationItems == null)
                    ok = true;
                else if (result.EducationItems.Count == 0)
                    ok = true;

            if (ok)
            {
                AntepartumEducationValueSet valueSet = new AntepartumEducationValueSet();

                foreach (ValueSetItem item in valueSet.Items)
                {
                    //    public enum CodingSystem {None, Loinc, SnomedCT}

                    CodingSystem[] translation = new CodingSystem[] { CodingSystem.None, CodingSystem.Loinc, CodingSystem.SnomedCT };

                    EducationItem edItem = new EducationItem();
                    edItem.Description = item.ItemName;
                    edItem.Category = item.Category;
                    edItem.Code = item.Code;
                    edItem.CodingSystem = translation[(int)item.CodeSystem];
                    edItem.ItemType = EducationItemType.DiscussionTopic;

                    IenResult saveResult = this.SaveEducationItem(edItem);

                    returnResult.SetResult(saveResult.Success, saveResult.Message);

                    if (!saveResult.Success)
                        break;
                }
            }

            return returnResult; 
        }

    }
}
