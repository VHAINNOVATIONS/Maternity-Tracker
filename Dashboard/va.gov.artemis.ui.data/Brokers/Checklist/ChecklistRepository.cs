// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;
using System.Xml.Serialization;
using VA.Gov.Artemis.Commands.Dsio.Checklist;
using VA.Gov.Artemis.Commands.Dsio.Pregnancy;
using VA.Gov.Artemis.UI.Data.Brokers.Common;
using VA.Gov.Artemis.UI.Data.Models.Checklist;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.UI.Data.Brokers.Checklist
{
    public class ChecklistRepository: RepositoryBase, IChecklistRepository 
    {
        private string DefaultChecklistFileName = "default_checklist.xml"; 
                
        public ChecklistRepository(IRpcBroker newBroker) : base(newBroker)
        {

        }

        public ChecklistItemsResult GetItems(string ien, int page, int itemsPerPage)
        {
            ChecklistItemsResult result = new ChecklistItemsResult();

            if (this.broker != null)
            {
                DsioGetMccChecklistCommand command = new DsioGetMccChecklistCommand(this.broker);

                command.AddCommandArguments(ien, page, itemsPerPage);

                RpcResponse response = command.Execute();

                result.SetResult(response.Status == RpcResponseStatus.Success, response.InformationalMessage);

                if (result.Success)
                {
                    result.TotalResults = command.TotalResults;

                    //XmlSerializer serializer = new XmlSerializer(typeof(List<DsioChecklistItem>));

                    //XmlWriter writer = XmlWriter.Create("\\va.gov.artemis.ui\\Content\\default_checklist.xml");

                    //serializer.Serialize(writer, command.ChecklistItems);

                    //writer.Close(); 

                    if (command.ChecklistItems != null)
                        foreach (DsioChecklistItem dsioItem in command.ChecklistItems)
                        {
                            ChecklistItem item = GetChecklistItem(dsioItem);

                            result.Items.Add(item); 

                        }
                }
            }

            return result; 
        }

        public IenResult SaveItem(ChecklistItem item)
        {
            IenResult result = new IenResult();

            if (this.broker != null)
            {
                DsioSaveMccChecklistCommand command = new DsioSaveMccChecklistCommand(this.broker);

                DsioChecklistItem dsioItem = GetDsioChecklistItem(item);

                command.AddCommandArguments(dsioItem);

                RpcResponse response = command.Execute();

                result.SetResult(response.Status == RpcResponseStatus.Success, response.InformationalMessage);

                if (result.Success)
                    result.Ien = command.Ien;

            }

            return result;
        }

        public PregnancyChecklistItemsResult GetPregnancyItems(string dfn, string pregIen, string itemIen)
        {
            return GetPregnancyItemsInternal(dfn, pregIen, itemIen, DsioChecklistCompletionStatus.Unknown); 
        }

        public PregnancyChecklistItemsResult GetPregnancyItems(string dfn, string pregIen, string itemIen, DsioChecklistCompletionStatus status)
        {
            return GetPregnancyItemsInternal(dfn, pregIen, itemIen, status);
        }        

        public IenResult SavePregnancyItem(PregnancyChecklistItem item)
        {
            IenResult result = new IenResult();

            if (this.broker != null)
            {
                DsioSaveMccPatChecklistCommand command = new DsioSaveMccPatChecklistCommand(broker); 

                DsioChecklistItem dsioItem = GetDsioChecklistItem(item);

                DsioPatientChecklistItem patItem = new DsioPatientChecklistItem(dsioItem);

                patItem.PatientDfn = item.PatientDfn;
                patItem.PregnancyIen = item.PregnancyIen;
                if (item.SpecificDueDate != DateTime.MinValue)
                    patItem.SpecificDueDate = Util.GetFileManDate(item.SpecificDueDate);
                patItem.CompletionStatus = item.CompletionStatus;
                patItem.CompleteDate = Util.GetFileManDate(item.CompleteDate);
                patItem.CompletionLink = item.CompletionLink;
                patItem.CompletedBy = item.CompletedBy;
                patItem.Note = item.StoredNote;
                patItem.InProgress = (item.InProgress) ? "1" : "0";
                                
                // *** These items not saved - generated internally ***
                //patItem.User = item.User;
                //patItem.ItemDate = Util.GetFileManDate(item.ItemDate);

                command.AddCommandArguments(patItem);

                RpcResponse response = command.Execute();

                result.SetResult(response.Status == RpcResponseStatus.Success, response.InformationalMessage);

                if (result.Success)
                    result.Ien = command.Ien;
            }

            return result;
        }

        public BrokerOperationResult AddDefaultPregnancyItems(string dfn, string pregIen)
        {
            BrokerOperationResult result = new BrokerOperationResult();

            ChecklistItemsResult getResult = this.GetItems("", 1, 1000);

            if (string.IsNullOrWhiteSpace(dfn))
                result.Message = "The patient could not be identified";
            else
            {
                if (string.IsNullOrWhiteSpace(pregIen))
                    result.Message = "The pregnancy could not be identified";
                else
                {
                    if (!getResult.Success)
                        result.SetResult(getResult.Success, getResult.Message);
                    else
                    {
                        if (getResult.Items != null)
                            if (getResult.Items.Count == 0)
                                result.SetResult(false, "There are no default checklist items to add");
                            else
                            {
                                foreach (ChecklistItem item in getResult.Items)
                                {
                                    PregnancyChecklistItem patItem = new PregnancyChecklistItem(item);

                                    patItem.PatientDfn = dfn;
                                    patItem.PregnancyIen = pregIen;
                                    patItem.CompletionStatus = DsioChecklistCompletionStatus.NotComplete;
                                    patItem.Ien = "";

                                    if (item.DueCalculationType == DsioChecklistCalculationType.Initial)
                                        patItem.SpecificDueDate = DateTime.Now;

                                    IenResult saveResult = this.SavePregnancyItem(patItem);

                                    if (!saveResult.Success)
                                    {
                                        result.SetResult(saveResult.Success, saveResult.Message);
                                        break;
                                    }
                                    else
                                        result.SetResult(saveResult.Success, saveResult.Message);
                                }
                            }
                    }
                }
            }

            return result; 
        }

        public BrokerOperationResult CompletePregnancyItem(PregnancyChecklistItem item)
        {
            BrokerOperationResult result = new BrokerOperationResult();

            item.CompletionStatus = DsioChecklistCompletionStatus.Complete;
            item.InProgress = false;
            item.CompleteDate = DateTime.Now; 

            result = this.SavePregnancyItem(item); 

            return result; 
        }

        public BrokerOperationResult CancelPregnancyItem(PregnancyChecklistItem item)
        {
            BrokerOperationResult result = new BrokerOperationResult();

            item.CompletionStatus = DsioChecklistCompletionStatus.NotNeededOrApplicable;
            item.InProgress = false; 

            result = this.SavePregnancyItem(item);

            return result; 
        }

        public BrokerOperationResult SetPregnancyItemInProgress(PregnancyChecklistItem item)
        {
            BrokerOperationResult result = new BrokerOperationResult();

            if (item.CompletionStatus == DsioChecklistCompletionStatus.NotComplete)
            {
                item.InProgress = true;

                result = this.SavePregnancyItem(item);
            }
            else
                result.Message = "Item has already been completed"; 

            return result; 
        }

        public BrokerOperationResult DeleteItem(string ien)
        {
            BrokerOperationResult result = new BrokerOperationResult();

            if (this.broker != null)
            {
                DsioDeleteMccChecklistCommand command = new DsioDeleteMccChecklistCommand(broker);

                command.AddCommandArguments(ien);

                RpcResponse response = command.Execute();

                result.SetResult(response.Status == RpcResponseStatus.Success, response.InformationalMessage); 
            }

            return result; 
        }

        public BrokerOperationResult DeletePregnancyItem(string dfn, string ien)
        {
            BrokerOperationResult result = new BrokerOperationResult();

            if (this.broker != null)
            {
                DsioDeleteMccPatChklstCommand command = new DsioDeleteMccPatChklstCommand(broker);

                command.AddCommandArguments(dfn, ien);

                RpcResponse response = command.Execute();

                result.SetResult(response.Status == RpcResponseStatus.Success, response.InformationalMessage);
            }

            return result; 
        }

        public PregnancyChecklistItemResult GetPregnancyItem(string dfn, string ien)
        {
            PregnancyChecklistItemResult result = new PregnancyChecklistItemResult();

            PregnancyChecklistItemsResult tempResult = this.GetPregnancyItems(dfn, "", ien);

            if (!tempResult.Success)
                result.SetResult(tempResult.Success, tempResult.Message); 
            else 
                if (tempResult.Items != null)
                    if (tempResult.Items.Count == 1)
                    {
                        result.Item = tempResult.Items[0];
                        result.Success = true;
                    }

            return result; 
        }

        public BrokerOperationResult LoadDefaultChecklist()
        {
            BrokerOperationResult returnResult = new BrokerOperationResult(); 

            // *** Create a serializer ***
            XmlSerializer serializer = new XmlSerializer(typeof(List<DsioChecklistItem>));

            // *** Get the full name of the source file ***
            string fullName = Path.Combine(this.ContentPath, this.DefaultChecklistFileName); 

            // *** Create a reader ***
            using (XmlReader reader = XmlReader.Create(fullName))
            {
                // *** Deserialize It ***
                var list = serializer.Deserialize(reader);

                // *** Get list ***
                List<DsioChecklistItem> checklistItems = (List<DsioChecklistItem>)list;

                // *** Process if we have any ***
                if (checklistItems.Count > 0)
                {
                    // *** Create the command ***
                    DsioSaveMccChecklistCommand command = new DsioSaveMccChecklistCommand(this.broker);

                    // *** Declare response ***
                    RpcResponse response = null;

                    // *** Loop ***
                    foreach (DsioChecklistItem item in checklistItems)
                    {
                        // *** Don't re-use IEN ***
                        item.Ien = "";

                        // *** Add the arguments ***
                        command.AddCommandArguments(item);

                        // *** Execute ***
                        response = command.Execute();

                        // *** If not successful, stop ***
                        if (response.Status != RpcResponseStatus.Success)
                            break;
                    }

                    // *** Add result ***
                    if (response != null) 
                        returnResult.SetResult(response.Status == RpcResponseStatus.Success, response.InformationalMessage); 
                }
                
            }

            return returnResult; 
        }

        private PregnancyChecklistItemsResult GetPregnancyItemsInternal(string dfn, string pregIen, string itemIen, DsioChecklistCompletionStatus status)
        {
            PregnancyChecklistItemsResult result = new PregnancyChecklistItemsResult();

            if (this.broker != null)
            {
                DsioGetMccPatientChecklistCommand command = new DsioGetMccPatientChecklistCommand(broker);

                command.AddCommandArguments(dfn, itemIen, pregIen, status);

                RpcResponse response = command.Execute();   

                result.SetResult(response.Status == RpcResponseStatus.Success, response.InformationalMessage);

                if (result.Success)
                {
                    result.TotalResults = command.TotalResults;

                    if (command.PatientItems != null)
                        foreach (DsioPatientChecklistItem dsioItem in command.PatientItems)
                        {
                            PregnancyChecklistItem item = GetPatientChecklistItem(dsioItem);

                            result.Items.Add(item);
                        }
                }
            }

            return result;
        }

        private ChecklistItem GetChecklistItem(DsioChecklistItem dsioItem)
        {
            ChecklistItem returnVal = new ChecklistItem()
            {
                Ien = dsioItem.Ien,
                Category = dsioItem.Category,
                Description = dsioItem.Description,
                Link = dsioItem.Link,
                EducationItemIen = dsioItem.EducationIen
            };

            int calcVal = -1;

            if (int.TryParse(dsioItem.DueCalculationValue, out calcVal))
                returnVal.DueCalculationValue = calcVal;

            returnVal.ItemType = dsioItem.ItemType; //GetChecklistItemType(dsioItem.ItemType);

            returnVal.DueCalculationType = dsioItem.DueCalculationType; //GetDueCalculationType(dsioItem.DueCalculationType); 

            return returnVal;
        }

        private DsioChecklistItem GetDsioChecklistItem(ChecklistItem item)
        {
            DsioChecklistItem returnVal = new DsioChecklistItem()
            {
                Ien = item.Ien,
                Category = item.Category,
                Description = item.Description,
                Link = item.Link,
                DueCalculationType = item.DueCalculationType,
                ItemType = item.ItemType, 
                EducationIen = item.EducationItemIen
            };

            returnVal.DueCalculationValue = item.DueCalculationValue.ToString();

            return returnVal;
        }

        //private DueCalculationType GetDueCalculationType(string dsioCalcType)
        //{
        //    DueCalculationType returnVal = DueCalculationType.Unknown;

        //    Dictionary<string, DueCalculationType> lookup = new Dictionary<string, DueCalculationType>();

        //    lookup.Add(DsioChecklistItem.InitialCalcType, DueCalculationType.Initial);
        //    lookup.Add(DsioChecklistItem.WeeksGaCalcType, DueCalculationType.WeeksGa);
        //    lookup.Add(DsioChecklistItem.TrimesterGaCalcType, DueCalculationType.TrimesterGa);
        //    lookup.Add(DsioChecklistItem.WeeksPostpartumCalcType, DueCalculationType.WeeksPostpartum);

        //    if (lookup.ContainsKey(dsioCalcType))
        //        returnVal = lookup[dsioCalcType]; 

        //    return returnVal; 
        //}

        //private ChecklistItemType GetChecklistItemType(string dsioItemType)
        //{
        //    ChecklistItemType returnVal = ChecklistItemType.Unknown;

        //    Dictionary<string, ChecklistItemType> lookup = new Dictionary<string, ChecklistItemType>();

        //    lookup.Add(DsioChecklistItem.MccCallType, ChecklistItemType.MccCall);
        //    lookup.Add(DsioChecklistItem.EdItemType, ChecklistItemType.EducationItem);
        //    lookup.Add(DsioChecklistItem.LabType, ChecklistItemType.Lab);
        //    lookup.Add(DsioChecklistItem.UltrasoundType, ChecklistItemType.Ultrasound);
        //    lookup.Add(DsioChecklistItem.ConsultType, ChecklistItemType.Consult);
        //    lookup.Add(DsioChecklistItem.CdaExchangeType, ChecklistItemType.CdaExchange);
        //    lookup.Add(DsioChecklistItem.VisitType, ChecklistItemType.Visit);
        //    lookup.Add(DsioChecklistItem.OtherType, ChecklistItemType.Other);

        //    if (lookup.ContainsKey(dsioItemType))
        //        returnVal = lookup[dsioItemType];

        //    return returnVal; 
        //}

        private PregnancyChecklistItem GetPatientChecklistItem(DsioPatientChecklistItem dsioItem)
        {
            PregnancyChecklistItem returnItem;

            ChecklistItem baseItem = this.GetChecklistItem(dsioItem);

            returnItem = new PregnancyChecklistItem(baseItem);

            returnItem.PatientDfn = dsioItem.PatientDfn;
            returnItem.PregnancyIen = dsioItem.PregnancyIen;
            returnItem.ItemDate = VistaDates.ParseDateString(dsioItem.ItemDate, VistaDates.VistADateFormatSix);
            returnItem.SpecificDueDate = VistaDates.ParseDateString(dsioItem.SpecificDueDate, VistaDates.VistADateOnlyFormat);
            returnItem.CompletionStatus = dsioItem.CompletionStatus;

            returnItem.CompleteDate = VistaDates.ParseDateString(dsioItem.CompleteDate, VistaDates.VistADateFormatFour);
            if (returnItem.CompleteDate == DateTime.MinValue)
                if (!string.IsNullOrWhiteSpace(dsioItem.CompleteDate))
                    returnItem.CompleteDate = VistaDates.ParseDateString(dsioItem.CompleteDate, VistaDates.VistADateFormatSeven);

            returnItem.CompletionLink = dsioItem.CompletionLink;
            returnItem.CompletedBy = dsioItem.CompletedBy;
            returnItem.StoredNote = dsioItem.Note;
            returnItem.User = dsioItem.User;
            returnItem.InProgress = (dsioItem.InProgress == "1") ? true : false;

            returnItem.EducationItemIen = dsioItem.EducationIen; 

            return returnItem;
        }        

    }
}
